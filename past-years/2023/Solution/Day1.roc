interface Solution.Day1
    exposes [
        part1,
        part2,
    ]
    imports [
        "Day1.input" as puzzleInput : Str,
        parser.String.{ anyCodeunit, digit, parseStr, string },
        parser.Core.{ flatten, many, map, oneOf },
    ]

part1 =
    solvePart puzzleInput puzzleParser1

solvePart = \input, parser ->
    when
        input
        |> Str.split "\n"
        |> List.dropIf Str.isEmpty
        |> List.walkTry
            []
            (\state, line ->
                when parser |> parseStr line is
                    Ok values ->
                        (
                            List.first values
                            |> Result.try (\first -> List.last values |> Result.try (\last -> Ok (state |> List.append (first * 10 + last))))
                        )

                    Err e -> Err e
            )
    is
        Err _ -> "error"
        Ok calibrationValues ->
            calibrationValues |> List.sum |> Num.toStr

exampleData1 =
    """
    1abc2
    pqr3stu8vwx
    a1b2c3d4e5f
    treb7uchet
    """

expect solvePart exampleData1 puzzleParser1 == "142"

part2 =
    solvePart2 puzzleInput puzzleParser2 puzzleParser2Backwards

solvePart2 = \input, parser, parserBackwards ->
    when
        input
        |> Str.split "\n"
        |> List.dropIf Str.isEmpty
        |> List.walkTry
            []
            (\state, line ->
                when parser |> parseStr line is
                    Ok values ->
                        (
                            List.first values
                            |> Result.try
                                (\first ->
                                    reverseLine = line |> Str.toUtf8 |> List.reverse |> Str.fromUtf8 |> Result.withDefault ""
                                    parserBackwards
                                    |> parseStr reverseLine
                                    |> Result.try
                                        (\values2 ->
                                            List.first values2 |> Result.try (\last -> Ok (state |> List.append (first * 10 + last)))

                                        )
                                )
                        )

                    Err e -> Err e
            )
    is
        Err _ -> "error"
        Ok calibrationValues ->
            calibrationValues |> List.sum |> Num.toStr

puzzleParser1 =
    many
        (
            oneOf [
                digit |> map \d -> Digit d,
                anyCodeunit |> map \_ -> Other,
            ]
        )
    |> map
        (\l ->
            newList = mapCharList l
            if List.isEmpty newList then
                Err "No digit found"
            else
                Ok newList
        )
    |> flatten

puzzleParser2 =
    many
        (
            oneOf [
                digit |> map \d -> Digit d,
                string "one" |> map \_ -> Digit 1,
                string "two" |> map \_ -> Digit 2,
                string "three" |> map \_ -> Digit 3,
                string "four" |> map \_ -> Digit 4,
                string "five" |> map \_ -> Digit 5,
                string "six" |> map \_ -> Digit 6,
                string "seven" |> map \_ -> Digit 7,
                string "eight" |> map \_ -> Digit 8,
                string "nine" |> map \_ -> Digit 9,
                anyCodeunit |> map \_ -> Other,
            ]
        )
    |> map
        (\l ->
            newList = mapCharList l
            if List.isEmpty newList then
                Err "No digit found"
            else
                Ok newList
        )
    |> flatten

puzzleParser2Backwards =
    many
        (
            oneOf [
                digit |> map \d -> Digit d,
                string "eno" |> map \_ -> Digit 1,
                string "owt" |> map \_ -> Digit 2,
                string "eerht" |> map \_ -> Digit 3,
                string "ruof" |> map \_ -> Digit 4,
                string "evif" |> map \_ -> Digit 5,
                string "xis" |> map \_ -> Digit 6,
                string "neves" |> map \_ -> Digit 7,
                string "thgie" |> map \_ -> Digit 8,
                string "enin" |> map \_ -> Digit 9,
                anyCodeunit |> map \_ -> Other,
            ]
        )
    |> map
        (\l ->
            newList = mapCharList l
            if List.isEmpty newList then
                Err "No digit found"
            else
                Ok newList
        )
    |> flatten

mapCharList = \cl ->
    cl
    |> List.walk
        []
        (\state, elem ->
            when elem is
                Digit n -> state |> List.append n
                Other -> state
        )

exampleData2 =
    """
    two1nine
    eightwothree
    abcone2threexyz
    xtwone3four
    4nineeightseven2
    zoneight234
    73333pqr333333stsixteen
    """

expect solvePart2 exampleData2 puzzleParser2 puzzleParser2Backwards == "281"
