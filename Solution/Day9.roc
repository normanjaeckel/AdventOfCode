interface Solution.Day9
    exposes [
        part1,
        part2,
    ]
    imports [
        "Day9.input" as puzzleInput : Str,
        parser.String.{ parseStr, digits, string },
        parser.Core.{ sepBy, const, keep, map, maybe },
    ]

part1 =
    solvePart1 puzzleInput

solvePart1 = \input ->
    input
    |> Str.trim
    |> parsePuzzleInput
    |> List.map findNextValue
    |> List.sum
    |> Num.toStr

parsePuzzleInput = \input ->
    when parseStr puzzleParser input is
        Ok v -> v
        Err _ -> crash "parsing failed"

puzzleParser =
    (customDigits |> sepBy (string " ")) |> sepBy (string "\n")

customDigits =
    const
        (\posOrNeg -> \d ->
                when posOrNeg is
                    Positive -> Num.toI64 d
                    Negative -> -1 * (Num.toI64 d)

        )
    |> keep
        (
            maybe (string "-")
            |> map
                (\v ->
                    when v is
                        Err _ -> Positive
                        Ok _ -> Negative
                )
        )
    |> keep digits

findNextValue = \line ->
    nextLine =
        line
        |> List.walkWithIndex
            (Container 0 [])
            (\Container previous nL, element, index ->
                if index == 0 then
                    Container element nL
                else
                    Container element (nL |> List.append (element - previous))
            )
        |> (\Container _ nL -> nL)

    when line |> List.last is
        Err _ -> crash "empty list"
        Ok lastElement ->
            if nextLine |> List.all (\element -> element == 0) then
                lastElement # We add 0 to this value and are done.
            else
                lastElement + (findNextValue nextLine)

exampleData1 =
    """
    0 3 6 9 12 15
    1 3 6 10 15 21
    10 13 16 21 30 45
    """

expect
    got = solvePart1 exampleData1
    got == "114"

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
