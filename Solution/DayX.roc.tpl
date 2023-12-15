interface Solution.DayX
    exposes [
        part1,
        part2,
    ]
    imports [
        "DayX.input" as puzzleInput : Str,
        parser.String.{ parseStr },
        parser.Core.{ const },
    ]

part1 =
    solvePart1 puzzleInput

solvePart1 = \input ->
    input
    |> Str.trim
    |> parsePuzzleInput
    |> (\x ->
        dbg
            x

        "no solution found"
    )

parsePuzzleInput = \input ->
    when parseStr puzzleParser input is
        Ok v -> v
        Err _ -> crash "parsing failed"

puzzleParser =
    const ""

exampleData1 =
    """
    """

expect
    got = solvePart1 exampleData1
    got == ""

part2 =
    solvePart2 puzzleInput

solvePart2 = \_input ->
    ""

exampleData2 =
    """
    """

expect
    got = solvePart2 exampleData2
    got == ""
