interface Solution.Day6
    exposes [
        part1,
        part2,
    ]
    imports [
        "Day6.input" as puzzleInput : Str,
        parser.String.{ parseStr, digits, string },
        parser.Core.{ const, skip, oneOrMore, many, maybe, keep, sepBy },
    ]

part1 =
    solvePart1 puzzleInput

solvePart1 = \input ->
    input
    |> parseInput
    |> List.map winningRange
    |> List.map getLenOfRange
    |> List.product
    |> Num.toStr

parseInput = \input ->
    when inputParser |> parseStr input is
        Ok (PuzzleInput times distances) ->
            times
            |> List.walkWithIndex
                []
                (\state, time, index ->
                    when distances |> List.get index is
                        Err _ -> crash "bad input 2"
                        Ok dist -> state |> List.append ({ time: time, distance: dist })
                )

        Err _ -> crash "bad input"

inputParser =
    const (\times -> \distances -> PuzzleInput (times |> List.map Num.toF64) (distances |> List.map Num.toF64))
    |> skip (string "Time:")
    |> skip (many (string " "))
    |> keep (digits |> sepBy (oneOrMore (string " ")))
    |> skip (string "\nDistance:")
    |> skip (many (string " "))
    |> keep (digits |> sepBy (oneOrMore (string " ")))
    |> skip (maybe (string "\n"))

winningRange = \{ time, distance } ->
    wurzel = Num.sqrt (((time ^ 2) / 4) - distance)
    x1 = ((time / 2) - wurzel |> Num.floor) + 1
    x2 = ((time / 2) + wurzel |> Num.ceiling) - 1
    { first: x1, last: x2 }

getLenOfRange = \{ first, last } ->
    last - first + 1

exampleData1 =
    """
    Time:      7  15   30
    Distance:  9  40  200
    """

expect
    got = solvePart1 exampleData1
    got == "288"

part2 =
    solvePart2 puzzleInput

solvePart2 = \input ->
    input
    |> Str.replaceEach " " ""
    |> parseInput
    |> List.map winningRange
    |> List.map getLenOfRange
    |> List.product
    |> Num.toStr

exampleData2 =
    exampleData1

expect
    got = solvePart2 exampleData2
    got == "71503"
