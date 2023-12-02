interface Solution.DayX
    exposes [
        part1,
        part2,
    ]
    imports [
        "DayX.input" as puzzleInput : Str,
        # parser.String.{ parseStr },
        # parser.Core.{ many },
    ]

part1 =
    solvePart1 puzzleInput

solvePart1 = \input ->
    input
    |> Str.split "\n"
    |> List.dropIf Str.isEmpty
    |> List.walkTry
        ""
        (\state, line ->
            Ok ""
        )
    |> Result.withDefault "error"

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
