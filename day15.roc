app [part1, part2] {
    pf: platform "https://github.com/ostcar/roc-aoc-platform/releases/download/v0.0.8/lhFfiil7mQXDOB6wN-jduJQImoT8qRmoiNHDB4DVF9s.tar.br",
    parser: "https://github.com/lukewilliamboswell/roc-parser/releases/download/0.9.0/w8YKp2YAgQt5REYk912HfKAHBjcXsrnvtjI0CBzoAT4.tar.br",
}

import parser.Parser exposing [Parser, const, keep, oneOrMore, map, oneOf, sepBy, skip]
import parser.String exposing [parseStr, codeunit, string]

example : Str
example =
    """
    ########
    #..O.O.#
    ##@.O..#
    #...O..#
    #.#.O..#
    #...O..#
    #......#
    ########

    <^^>>>vv<v>>v<<
    """

example2 : Str
example2 =
    """
    ##########
    #..O..O.O#
    #......O.#
    #.OO..O.O#
    #..O@..O.#
    #O#..O...#
    #O..O..O.#
    #.OO.O.OO#
    #....O...#
    ##########

    <vv>^<v^>v>^vv^v>v<>v^v<v<^vv<<<^><<><>>v<vvv<>^v^>^<<<><<v<<<v^vv^v>^
    vvv<<^>^v^^><<>>><>^<<><^vv^^<>vvv<>><^^v>^>vv<>v<<<<v<^v>^<^^>>>^<v<v
    ><>vv>v^v^<>><>>>><^^>vv>v<^^^>>v^v^<^^>v^^>v^<^v>v<>>v^v^<v>v^^<^^vv<
    <<v<^>>^^^^>>>v^<>vvv^><v<<<>^^^vv^<vvv>^>v<^^^^v<>^>vvvv><>>v^<<^^^^^
    ^><^><>>><>^^<<^^v>>><^<v>^<vv>>v>>>^v><>^v><<<<v>>v<v<v>vvv>^<><<>^><
    ^>><>^v<><^vvv<^^<><v<<<<<><^v<<<><<<^^<v<^^^><^>>^<v^><<<^>>^v<v^v<v^
    >^>>^v>vv>^<<^v<>><<><<v<<v><>v<^vv<<<>^^v^>^^>>><<^v>>v^v><^^>>^<>vv^
    <><^^>^^^<><vvvvv^v<v<<>^v<v>v<<^><<><<><<<^^<<<^<<>><<><^^^>^^<>^>v<>
    ^^>vv<^v^v<vv>^<><v<^v>^^^>>>^^vvv^>vvv<>>>^<^>>>>>^<<^v>^vvv<>^<><<v>
    v^^>>><<^^<>>^v^<v^vv<>v^<<>^<^v^v><^<<<><<^<v><v<>vv>>v><v^<vv<>v^<<^
    """

expect
    got = part1 example
    expected = Ok "2028"
    got == expected

expect
    got = part1 example2
    expected = Ok "10092"
    got == expected

part1 : Str -> Result Str [ParsingFailure Str, ParsingIncomplete Str]
part1 = \rawInput ->
    parseStr puzzleParser (rawInput |> Str.trim)
    |> Result.map
        \input ->
            input.moves
            |> List.walk { locations: Dict.fromList input.locationList, maxRow: input.maxRow, maxCol: input.maxCol } applyMove
            |> calcGPS
            |> Num.toStr

Location : [Empty, Wall, Box, Robot]
Move : [Up, Down, Left, Right]
Warehouse : { locations : Dict (U64, U64) Location, maxRow : U64, maxCol : U64 }

puzzleParser : Parser (List U8) { locationList : List ((U64, U64), Location), moves : List Move, maxRow : U64, maxCol : U64 }
puzzleParser =
    const \grid -> \moves -> {
            locationList: grid |> toLocationList,
            moves,
            maxRow: (List.len grid - 1),
            maxCol: (grid |> List.first |> Result.withDefault [] |> List.len) - 1,
        }
    |> keep warehouseParser
    |> skip (string "\n\n")
    |> keep movesParser

warehouseParser : Parser (List U8) (List (List Location))
warehouseParser =
    warehouseLine |> sepBy (string "\n")

warehouseLine : Parser (List U8) (List Location)
warehouseLine =
    oneOrMore
        (
            oneOf [
                codeunit '#' |> map \_ -> Wall,
                codeunit 'O' |> map \_ -> Box,
                codeunit '.' |> map \_ -> Empty,
                codeunit '@' |> map \_ -> Robot,
            ]
        )

toLocationList : List (List Location) -> List ((U64, U64), Location)
toLocationList = \locs ->
    locs
    |> List.walkWithIndex
        []
        \state1, line, rowIndex ->
            line
            |> List.walkWithIndex
                state1
                \state2, loc, colIndex ->
                    state2 |> List.append ((rowIndex, colIndex), loc)

movesParser : Parser (List U8) (List Move)
movesParser =
    oneOrMore
        (
            oneOf [
                codeunit '^' |> map \_ -> Ok Up,
                codeunit 'v' |> map \_ -> Ok Down,
                codeunit '<' |> map \_ -> Ok Left,
                codeunit '>' |> map \_ -> Ok Right,
                codeunit '\n' |> map \_ -> Err Newline,
            ]
        )
    |> map \l -> l
        |> List.walk [] \state, m ->
            when m is
                Ok ok -> state |> List.append ok
                Err Newline -> state

applyMove : Warehouse, Move -> Warehouse
applyMove = \warehouse, move ->
    (row, col) = findRobot warehouse
    affected =
        when move is
            Up -> List.range { start: At row, end: At 0 } |> List.map \n -> (n, col)
            Down -> List.range { start: At row, end: At warehouse.maxRow } |> List.map \n -> (n, col)
            Left -> List.range { start: At col, end: At 0 } |> List.map \n -> (row, n)
            Right -> List.range { start: At col, end: At warehouse.maxCol } |> List.map \n -> (row, n)
    affected
    |> List.walkUntil
        []
        \state, pos ->
            loc = warehouse.locations |> Dict.get pos |> Result.withDefault Wall
            when loc is
                Wall -> Break state
                Empty -> state |> moveInLine pos [] |> Break
                Box | Robot -> state |> List.append (pos, loc) |> Continue
    |> \l ->
        { warehouse & locations: warehouse.locations |> Dict.insertAll (l |> Dict.fromList) }

findRobot : Warehouse -> (U64, U64)
findRobot = \warehouse ->
    warehouse.locations
    |> Dict.walkUntil
        (Err RobotNotFound)
        \state, pos, loc ->
            when loc is
                Robot -> Break (Ok pos)
                _ -> Continue state
    |> Result.withDefault (0, 0)

moveInLine : List ((U64, U64), Location), (U64, U64), List ((U64, U64), Location) -> List ((U64, U64), Location)
moveInLine = \affected, pos, result ->
    when affected is
        [] -> result |> List.append (pos, Empty)
        [.. as rest, last] ->
            moveInLine rest last.0 (result |> List.append (pos, last.1))

calcGPS : Warehouse -> U64
calcGPS = \warehouse ->
    warehouse.locations
    |> Dict.toList
    |> List.map
        \((row, col), loc) ->
            when loc is
                Box -> row * 100 + col
                _ -> 0
    |> List.sum

expect
    got = part2 example2
    expected = Ok "9021"
    got == expected

part2 : Str -> Result Str [ParsingFailure Str, ParsingIncomplete Str]
part2 = \rawInput ->
    parseStr puzzleParser (rawInput |> Str.trim)
    |> Result.map
        \input ->
            input.moves
            |> List.walk { locations: input.locationList |> extendWarehouse, maxRow: input.maxRow * 2, maxCol: input.maxCol * 2 } applyMove2
            |> calcGPS2
            |> Num.toStr

LocactionExtended : [BoxLeft, BoxRight, Wall, Empty, Robot]
WarehouseExtended : { locations : Dict (U64, U64) LocactionExtended, maxRow : U64, maxCol : U64 }

extendWarehouse : List ((U64, U64), Location) -> Dict (U64, U64) LocactionExtended
extendWarehouse = \locationList ->
    locationList
    |> List.walk
        []
        \acc, ((row, col), loc) ->
            (left, right) =
                when loc is
                    Wall -> (Wall, Wall)
                    Empty -> (Empty, Empty)
                    Robot -> (Robot, Empty)
                    Box -> (BoxLeft, BoxRight)
            acc |> List.concat [((row, col * 2), left), ((row, col * 2 + 1), right)]
    |> Dict.fromList

applyMove2 : WarehouseExtended, Move -> WarehouseExtended
applyMove2 = \warehouse, move ->
    (row, col) = findRobot2 warehouse
    movingHelper warehouse move [((row, col), Robot)] []
    |> moveThem move
    |> \l ->
        { warehouse & locations: warehouse.locations |> Dict.insertAll (l |> Dict.fromList) }

findRobot2 : WarehouseExtended -> (U64, U64)
findRobot2 = \warehouse ->
    warehouse.locations
    |> Dict.walkUntil
        (Err RobotNotFound)
        \state, pos, loc ->
            when loc is
                Robot -> Break (Ok pos)
                _ -> Continue state
    |> Result.withDefault (0, 0)

movingHelper : WarehouseExtended, Move, List ((U64, U64), LocactionExtended), List ((U64, U64), LocactionExtended) -> List ((U64, U64), LocactionExtended)
movingHelper = \warehouse, move, toBeMoved, result ->
    if List.isEmpty toBeMoved then
        result
        else

    nextToBeMoved =
        toBeMoved
        |> List.walkTry
            []
            \state, tbm ->
                ((row, col), nextLoc) = getNext warehouse move tbm
                when nextLoc is
                    Wall ->
                        Err Blocked

                    Empty ->
                        Ok state

                    BoxLeft ->
                        when move is
                            Up | Down -> Ok (state |> List.concat [((row, col), BoxLeft), ((row, col + 1), BoxRight)])
                            Left | Right -> Ok (state |> List.append ((row, col), nextLoc))

                    BoxRight ->
                        when move is
                            Up | Down -> Ok (state |> List.concat [((row, col - 1), BoxLeft), ((row, col), BoxRight)])
                            Left | Right -> Ok (state |> List.append ((row, col), nextLoc))

                    Robot -> crash "Uh oh"

    when nextToBeMoved is
        Err Blocked -> []
        Ok ntbm ->
            movingHelper warehouse move ntbm (result |> List.concat toBeMoved)

getNext : WarehouseExtended, Move, ((U64, U64), LocactionExtended) -> ((U64, U64), LocactionExtended)
getNext = \warehouse, move, ((row, col), _loc) ->
    nextPos =
        when move is
            Up -> (row - 1, col)
            Down -> (row + 1, col)
            Left -> (row, col - 1)
            Right -> (row, col + 1)
    nextLoc = warehouse.locations |> Dict.get nextPos |> Result.withDefault Wall
    (nextPos, nextLoc)

moveThem : List ((U64, U64), LocactionExtended), Move -> List ((U64, U64), LocactionExtended)
moveThem = \list, move ->
    initial = list |> List.map (\(pos, _loc) -> (pos, Empty)) |> Set.fromList
    list
    |> List.walk
        initial
        \state, ((row, col), loc) ->
            when move is
                Up -> state |> Set.insert ((row - 1, col), loc)
                Down -> state |> Set.insert ((row + 1, col), loc)
                Left -> state |> Set.insert ((row, col - 1), loc)
                Right -> state |> Set.insert ((row, col + 1), loc)
    |> Set.toList

calcGPS2 : WarehouseExtended -> U64
calcGPS2 = \warehouse ->
    warehouse.locations
    |> Dict.toList
    |> List.map
        \((row, col), loc) ->
            when loc is
                BoxLeft -> row * 100 + col
                _ -> 0
    |> List.sum
