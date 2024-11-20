app "advent-of-code-2023"
    packages {
        pf: "https://github.com/roc-lang/basic-cli/releases/download/0.7.1/Icc3xJoIixF3hCcfXrDwLCu4wQHtNdPyoJkEbkgIElA.tar.br",
        parser: "https://github.com/lukewilliamboswell/roc-parser/releases/download/0.4/yrk4tKd0w9oaxt0s66zrejc6L67Y7B-86BQrL9yjZMY.tar.br",
    }
    imports [
        "Day21.input" as puzzleInput : Str,
        pf.Stdout,
        parser.String.{ parseStr, string },
        parser.Core.{ sepBy, oneOrMore, oneOf, map },
    ]
    provides [main] to pf

main =
    Stdout.line "Solution for part 2: \(part2)"

part2 =
    garden = puzzleInput |> Str.trim |> parsePuzzleInput
    (numOfRows, numOfCols) = getDimensions garden
    start = findStart garden

    springDiamond = walkGarden { garden, numOfRows, numOfCols } 65 (Set.single start) |> Set.len
    summerDiamond = 1 + (walkGarden { garden, numOfRows, numOfCols } 64 (Set.single start) |> Set.len) # We have a + 1 here but we got this just by trial and error
    twoColdDiamonds =
        walkGarden { garden, numOfRows, numOfCols } (65 + 131 + 131) (Set.single start)
        |> Set.len
        |> \n ->
            (n - 9 * springDiamond - (4 * summerDiamond)) // 6

    steps = (26_501_365 - 65) // 131
    totalLen = steps * 2 + 1

    allSpringDiamonds = ((totalLen * totalLen + 2 * totalLen + 1) * springDiamond) // 4
    allSummerDiamonds = ((totalLen * totalLen - 2 * totalLen + 1) * summerDiamond) // 4
    allColdDiamonts = ((totalLen * totalLen - 1) * twoColdDiamonds) // 4

    (allSpringDiamonds + allSummerDiamonds + allColdDiamonts)
    |> Num.toStr

parsePuzzleInput = \input ->
    when parseStr puzzleParser input is
        Ok v -> v
        Err _ -> crash "parsing failed"

puzzleParser =
    lineParser |> sepBy (string "\n")

lineParser =
    oneOrMore
        (
            oneOf [
                string "S" |> map \_ -> Start,
                string "." |> map \_ -> GardenPlot,
                string "#" |> map \_ -> Rock,
            ]
        )

Type : [Start, GardenPlot, Rock]

getDimensions = \garden ->
    rows = List.len garden
    cols =
        when garden |> List.first is
            Err ListWasEmpty -> crash "bad garden"
            Ok row -> List.len row

    (rows |> Num.toI32, cols |> Num.toI32)

findStart = \garden ->
    garden
    |> List.walkWithIndex
        NotFound
        \state, row, rowIndex ->
            when state is
                Found _ -> state
                NotFound ->
                    row
                    |> List.walkWithIndex
                        NotFound
                        \state2, col, colIndex ->
                            when state2 is
                                Found _ -> state2
                                NotFound ->
                                    when col is
                                        Start -> Found (rowIndex |> Num.toI32, colIndex |> Num.toI32)
                                        _ -> NotFound
    |> \finalState ->
        when finalState is
            NotFound -> crash "not start found"
            Found v -> v

Garden : { garden : List (List Type), numOfRows : I32, numOfCols : I32 }

walkGarden = \garden, steps, reached ->
    if steps == 0 then
        reached
    else
        newSteps = steps - 1

        newReached =
            reached
            |> Set.walk
                (Set.empty {})
                \state, (row, col) ->
                    state |> Set.union (getNextElements garden row col)

        walkGarden garden newSteps newReached

getNextElements = \garden, row, col ->
    positions =
        [(row + 1, col), (row - 1, col), (row, col + 1), (row, col - 1)]

    positions
    |> List.keepIf
        \(r, c) ->
            when getType garden r c is
                GardenPlot | Start -> Bool.true
                Rock -> Bool.false
    |> Set.fromList

getType : Garden, I32, I32 -> Type
getType = \garden, row, col ->
    when garden.garden |> List.get (mod row garden.numOfRows |> Num.toNat) |> Result.try (\r -> r |> List.get (mod col garden.numOfCols |> Num.toNat)) is
        Err _ -> crash "bad garden"
        Ok v -> v

mod = \a, b ->
    if a < 0 then
        mod (a + b) b
    else
        a % b

expect
    got = mod -2 12
    got == 10

expect
    got = mod 9 12
    got == 9

expect
    got = mod 14 12
    got == 2
