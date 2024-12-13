app [part1, part2] {
    pf: platform "https://github.com/ostcar/roc-aoc-platform/releases/download/v0.0.8/lhFfiil7mQXDOB6wN-jduJQImoT8qRmoiNHDB4DVF9s.tar.br",
    parser: "https://github.com/lukewilliamboswell/roc-parser/releases/download/0.9.0/w8YKp2YAgQt5REYk912HfKAHBjcXsrnvtjI0CBzoAT4.tar.br",
}

import parser.Parser exposing [Parser, sepBy, chompWhile]
import parser.String exposing [parseStr, string]

example : Str
example =
    """
    RRRRIICCFF
    RRRRIICCCF
    VVRRRCCFFF
    VVRCCCJFFF
    VVVVCJJCFE
    VVIVCCJJEE
    VVIIICJJEE
    MIIIIIJJEE
    MIIISIJEEE
    MMMISSJEEE
    """

expect
    got = part1 example
    expected = Ok "1930"
    got == expected

part1 : Str -> Result Str [ParsingFailure Str, ParsingIncomplete Str]
part1 = \rawInput ->
    parseStr puzzleParser (rawInput |> Str.trim)
    |> Result.map
        \input ->
            input
            |> toGardenMap
            |> toRegionList
            |> List.map calcFencePrice
            |> List.sum
            |> Num.toStr

Position : (U64, U64)
Plant : U8

puzzleParser : Parser (List U8) (List (List Plant))
puzzleParser =
    lineParser |> sepBy (string "\n")

lineParser : Parser (List U8) (List Plant)
lineParser =
    chompWhile \c -> c != '\n'

toGardenMap : List (List Plant) -> Garden
toGardenMap = \rows ->
    rows
    |> List.walkWithIndex
        { plants: Dict.empty {}, maxRowIndex: (List.len rows) - 1, maxColIndex: 0 }
        \garden, row, rowIndex ->
            { garden &
                plants: row
                |> List.mapWithIndex \plant, colIndex -> ((rowIndex, colIndex), plant)
                |> Dict.fromList
                |> Dict.insertAll garden.plants,
                maxColIndex: (List.len row) - 1,
            }

Garden : { plants : Dict Position Plant, maxRowIndex : U64, maxColIndex : U64 }
Region : { plant : Plant, area : List Position }

toRegionList : Garden -> List Region
toRegionList = \garden ->
    toRegionListHelper garden []

toRegionListHelper : Garden, List Region -> List Region
toRegionListHelper = \garden, result ->
    when garden.plants |> Dict.toList |> List.first is
        Err ListWasEmpty -> result
        Ok (pos, plant) ->
            region = craftRegion pos plant garden
            newPlants = region.area |> List.walk garden.plants \state, p -> state |> Dict.remove p
            toRegionListHelper { garden & plants: newPlants } (result |> List.append region)

craftRegion : Position, Plant, Garden -> Region
craftRegion = \pos, plant, garden ->
    craftRegionHelper { plant: plant, area: [] } [pos] garden

craftRegionHelper : Region, List Position, Garden -> Region
craftRegionHelper = \region, positions, garden ->
    when positions is
        [] -> region
        [first, .. as rest] ->
            if region.area |> List.contains first then
                craftRegionHelper region rest garden
                else

            newRegion = { region & area: region.area |> List.append first }
            vertic = getNeighbours first.0 garden.maxRowIndex |> List.map \row -> (row, first.1)
            horiz = getNeighbours first.1 garden.maxColIndex |> List.map \col -> (first.0, col)
            next =
                List.concat vertic horiz
                |> List.keepIf
                    \pos ->
                        region.plant == garden.plants |> Dict.get pos |> Result.withDefault 0
            craftRegionHelper newRegion (rest |> List.concat next) garden

getNeighbours : U64, U64 -> List U64
getNeighbours = \a, b ->
    if a == 0 then
        [1]
    else if a == b then
        [a - 1]
    else
        [a - 1, a + 1]

calcFencePrice : Region -> U64
calcFencePrice = \region ->
    region.area
    |> List.walk
        { visited: [], price: 0 }
        \state, pos ->
            p = 4 - (2 * (pos |> neighbourOf state.visited))
            { visited: state.visited |> List.append pos, price: state.price + p }
    |> \state -> (Num.toU64 state.price) * (List.len region.area)

neighbourOf : Position, List Position -> I64
neighbourOf = \(row, col), neighbours ->
    [(Num.subSaturated row 1, col), (row + 1, col), (row, Num.subSaturated col 1), (row, col + 1)]
    |> List.keepIf
        \p -> neighbours |> List.contains p
    |> List.len
    |> Num.toI64

expect
    got = part2 example
    expected = Ok "1206"
    got == expected

part2 : Str -> Result Str [ParsingFailure Str, ParsingIncomplete Str]
part2 = \rawInput ->
    parseStr puzzleParser (rawInput |> Str.trim)
    |> Result.map
        \input ->
            input
            |> toGardenMap
            |> toRegionList
            |> List.map calcFencePriceWithDiscount
            |> List.sum
            |> Num.toStr

calcFencePriceWithDiscount : Region -> U64
calcFencePriceWithDiscount = \region ->
    allFences = getAllFences region.area [] region
    p = fencesToGroups allFences
    p * (List.len region.area)

Fence : { pos : Position, orientation : Orientation }
Orientation : [North, South, West, East]

getAllFences : List Position, List Fence, Region -> List Fence
getAllFences = \positions, fences, region ->
    when positions is
        [] -> fences
        [(row, col), .. as rest] ->
            north =
                if row == 0 then
                    [{ pos: (row, col), orientation: North }]
                else if region.area |> List.contains (row - 1, col) then
                    []
                else
                    [{ pos: (row, col), orientation: North }]
            south =
                if region.area |> List.contains (row + 1, col) then
                    []
                else
                    [{ pos: (row + 1, col), orientation: South }]
            west =
                if col == 0 then
                    [{ pos: (row, col), orientation: West }]
                else if region.area |> List.contains (row, col - 1) then
                    []
                else
                    [{ pos: (row, col), orientation: West }]
            east =
                if region.area |> List.contains (row, col + 1) then
                    []
                else
                    [{ pos: (row, col + 1), orientation: East }]
            newFences = fences |> List.concat ([north, south, west, east] |> List.join)
            getAllFences rest newFences region

fencesToGroups : List Fence -> U64
fencesToGroups = \fences ->
    fences
    |> List.walk
        (Dict.empty {})
        \acc, fence ->
            (k, v) =
                when fence.orientation is
                    North | South ->
                        ((fence.pos.0, fence.orientation), fence.pos.1)

                    West | East ->
                        ((fence.pos.1, fence.orientation), fence.pos.0)
            acc |> Dict.update k \l -> l |> Result.withDefault [] |> List.append v |> Ok
    |> Dict.map
        \_key, value ->
            value
            |> List.sortAsc
            |> List.walk
                []
                \acc, pos ->
                    when acc |> List.last is
                        Err ListWasEmpty -> [pos]
                        Ok last ->
                            if last + 1 == pos then
                                acc |> List.dropLast 1 |> List.append pos
                            else
                                acc |> List.append pos
            |> List.len
    |> Dict.values
    |> List.sum

expect
    input =
        """
        AAAAAA
        AAABBA
        AAABBA
        ABBAAA
        ABBAAA
        AAAAAA
        """
    got = part2 input
    expected = Ok "368"
    got == expected
