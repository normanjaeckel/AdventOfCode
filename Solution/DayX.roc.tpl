interface Solution.DayX
    exposes [
        part1,
        part2,
    ]
    imports [
        "DayX.input" as puzzleInput : Str,
        # parser.String.{ parseStr },
        # parser.Core.{ const, keep, skip },
    ]

part1 =
    solvePart1 puzzleInput

solvePart1 = \input ->
    input
    |> parsePuzzleInput
    |> (\a ->
        dbg
            x

        "no solution found"
    )

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
