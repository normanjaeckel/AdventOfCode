interface Solution.Day0
    exposes [
        part1,
        part2,
    ]
    imports [
        "Day0.input" as puzzleInput : Str,
    ]

part1 = puzzleInput |> Str.trimEnd

part2 =
    part1
    |> Str.toScalars
    |> List.reverse
    |> List.walk
        ""
        (\state, element -> Str.appendScalar state element
            |> Result.withDefault "?")
