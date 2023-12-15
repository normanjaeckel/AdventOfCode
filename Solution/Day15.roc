interface Solution.Day15
    exposes [
        part1,
        part2,
    ]
    imports [
        "Day15.input" as puzzleInput : Str,
    ]

part1 =
    solvePart1 puzzleInput

solvePart1 = \input ->
    input
    |> Str.trim
    |> Str.split "\n"
    |> List.map (\l -> l |> Str.split ",")
    |> List.join
    |> List.map holidayASCIIStringHelperAlgorithm
    |> List.sum
    |> Num.toStr

holidayASCIIStringHelperAlgorithm = \s ->
    s
    |> Str.toUtf8
    |> List.walk
        (Num.toU64 0)
        (\state, c ->
            ((state + (Num.toU64 c)) * 17) % 256
        )

expect
    got = holidayASCIIStringHelperAlgorithm "HASH"
    got == 52

expect
    got = holidayASCIIStringHelperAlgorithm "rn=1"
    got == 30

exampleData1 =
    """
    rn=1,cm-,qp=3,cm=2,qp-,pc=4,ot=9,ab=5,pc-,pc=6,ot=7
    rn=1,cm-,qp=3,cm=2,qp-,pc=4,ot=9,ab=5,pc-,pc=6,ot=7
    """

expect
    got = solvePart1 exampleData1
    got == "2640" # 1320 * 2

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
