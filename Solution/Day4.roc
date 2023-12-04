interface Solution.Day4
    exposes [
        part1,
        part2,
    ]
    imports [
        "Day4.input" as puzzleInput : Str,
        parser.String.{ parseStr, string, digits },
        parser.Core.{ const, keep, skip, maybe, many },
    ]

part1 =
    solvePart1 puzzleInput

solvePart1 = \input ->
    input
    |> Str.split "\n"
    |> List.dropIf Str.isEmpty
    |> List.map
        (\line ->
            when cardParser |> parseStr line is
                Err _ -> crash "bad card"
                Ok (Card winningNums currentNumbers) ->
                    currentNumbers
                    |> List.keepIf (\n -> winningNums |> List.contains n)
                    |> List.len
                    |> (\count -> if count == 0 then 0 else Num.powInt 2 (count - 1))
        )
    |> List.sum
    |> Num.toStr

cardParser =
    const (\winningNums -> \currentNumbers -> Card winningNums currentNumbers)
    |> skip (string "Card")
    |> skip (many (string " "))
    |> skip digits
    |> skip (string ":")
    |> keep numsParser
    |> skip (string " |")
    |> keep numsParser

numsParser =
    many
        (
            const (\n -> n)
            |> skip (string " ")
            |> skip (maybe (string " "))
            |> keep digits
        )

exampleData1 =
    """
    Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
    Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
    Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
    Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
    Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
    Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
    """

expect
    got = solvePart1 exampleData1
    got == "13"

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
