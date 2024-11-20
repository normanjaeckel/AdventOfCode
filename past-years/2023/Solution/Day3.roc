interface Solution.Day3
    exposes [
        part1,
        part2,
    ]
    imports [
        "Day3.input" as puzzleInput : Str,
        parser.String.{ parseStr, anyCodeunit, digit, string, digits },
        parser.Core.{ many, oneOf, map },
    ]

part1 =
    solvePart1 puzzleInput

solvePart1 = \input ->
    input
    |> Str.split "\n"
    |> List.dropIf Str.isEmpty
    |> parseSymbols symbolParser1
    |> parsePartNumbers
    |> checkPartNumbers
    |> Num.toStr

exampleData1 =
    """
    467..114..
    ...*......
    ..35..633.
    ......#...
    617*......
    .....+.58.
    ..592.....
    ......755.
    ...$.*....
    .664.598..
    """

expect
    got = solvePart1 exampleData1
    got == "4361"

parseSymbols = \lines, symbolParser ->
    TempResult
        lines
        (
            lines
            |> List.walkWithIndex
                []
                (
                    \state, line, index ->
                        when symbolParser |> parseStr line is
                            Ok parsedElem -> state |> List.append (Pos index (parsedElem |> transformParsedSymbolElem))
                            Err _ -> crash "Parsing failed"
                )

        )

transformParsedSymbolElem = \line ->
    line
    |> List.walkWithIndex
        []
        (\state, elem, index ->
            when elem is
                NoSymbol -> state
                Symbol -> state |> List.append index
        )

parsePartNumbers = \TempResult lines symbols ->
    partNumbers =
        lines
        |> List.walkWithIndex
            []
            (
                \state, line, index ->
                    when partNumberParser |> parseStr line is
                        Ok parsedElem -> state |> List.append (Pos index (parsedElem |> transformParsedPartNumberElem))
                        Err _ -> crash "Parsing failed"
            )
    TempResult2 symbols partNumbers

transformParsedPartNumberElem = \line ->
    res =
        line
        |> List.walkWithIndex
            (StateWithOffset [] 0)
            (\StateWithOffset state offset, elem, index ->
                when elem is
                    NoPartNumber -> StateWithOffset state offset
                    PartNumber n ->
                        StateWithOffset
                            (state |> List.append (PartNumberAt n (index + offset)))
                            (
                                if n < 10 then
                                    offset
                                else if n < 100 then
                                    offset + 1
                                else if n < 1000 then
                                    offset + 2
                                else
                                    crash "bad number"
                            )
            )
    when res is
        StateWithOffset state _offset ->
            state

checkPartNumbers = \TempResult2 symbols partNumbers ->
    partNumbers
    |> List.map
        (\Pos lineIndex line ->
            line
            |> List.walk
                0
                (\state, PartNumberAt n index -> if checkThisNumberAlright (lineIndex + 1) (index + 1) n symbols then state + n else state)
        )
    |> List.sum

checkThisNumberAlright = \lineIndex, index, n, symbols ->
    if n < 10 then
        checkSymbol symbols [
            (lineIndex - 1, index - 1),
            (lineIndex - 1, index),
            (lineIndex - 1, index + 1),
            (lineIndex, index - 1),
            (lineIndex, index + 1),
            (lineIndex + 1, index - 1),
            (lineIndex + 1, index),
            (lineIndex + 1, index + 1),
        ]
    else if n < 100 then
        checkSymbol symbols [
            (lineIndex - 1, index - 1),
            (lineIndex - 1, index),
            (lineIndex - 1, index + 1),
            (lineIndex - 1, index + 2),
            (lineIndex, index - 1),
            (lineIndex, index + 2),
            (lineIndex + 1, index - 1),
            (lineIndex + 1, index),
            (lineIndex + 1, index + 1),
            (lineIndex + 1, index + 2),
        ]
    else if n < 1000 then
        checkSymbol symbols [
            (lineIndex - 1, index - 1),
            (lineIndex - 1, index),
            (lineIndex - 1, index + 1),
            (lineIndex - 1, index + 2),
            (lineIndex - 1, index + 3),
            (lineIndex, index - 1),
            (lineIndex, index + 3),
            (lineIndex + 1, index - 1),
            (lineIndex + 1, index),
            (lineIndex + 1, index + 1),
            (lineIndex + 1, index + 2),
            (lineIndex + 1, index + 3),
        ]
    else
        crash "bad number"

checkSymbol = \symbols, positions ->
    positions
    |> List.any
        (\pos ->
            transformedSymbols symbols
            |> List.any
                (\symbol ->
                    symbol == pos
                )
        )

transformedSymbols = \symbols ->
    symbols
    |> List.walk
        []
        (\state, Pos lineIndex symbol -> state |> List.concat (symbol |> List.map (\s -> (lineIndex + 1, s + 1))))

symbolParser1 =
    many
        (
            oneOf [
                digit |> map (\_ -> NoSymbol),
                string "." |> map (\_ -> NoSymbol),
                anyCodeunit |> map (\_ -> Symbol),
            ]
        )

partNumberParser =
    many
        (
            oneOf [
                digits |> map (\n -> PartNumber n),
                anyCodeunit |> map (\_ -> NoPartNumber),
            ]
        )

part2 =
    solvePart2 puzzleInput

solvePart2 = \input ->
    input
    |> Str.split "\n"
    |> List.dropIf Str.isEmpty
    |> parseSymbols symbolParser2
    |> parsePartNumbers
    |> checkGears
    |> Num.toStr

exampleData2 =
    exampleData1

expect
    got = solvePart2 exampleData2
    got == "467835"

symbolParser2 =
    many
        (
            oneOf [
                string "*" |> map (\_ -> Symbol),
                anyCodeunit |> map (\_ -> NoSymbol),
            ]
        )

checkGears = \TempResult2 gears partNumbers ->
    gears
    |> transformedSymbols
    |> List.map
        (\gear ->
            partNumbers
            |> List.walk
                []
                (\state, Pos lineIndexX line ->
                    lineIndex = lineIndexX + 1
                    line
                    |> List.walk
                        []
                        (\state2, PartNumberAt n indexX ->
                            index = indexX + 1
                            if n < 10 then
                                state2
                                |> List.concat
                                    (
                                        checkMeYet n gear [
                                            (lineIndex - 1, index - 1),
                                            (lineIndex - 1, index),
                                            (lineIndex - 1, index + 1),
                                            (lineIndex, index - 1),
                                            (lineIndex, index + 1),
                                            (lineIndex + 1, index - 1),
                                            (lineIndex + 1, index),
                                            (lineIndex + 1, index + 1),
                                        ]
                                    )
                            else if n < 100 then
                                state2
                                |> List.concat
                                    (
                                        checkMeYet n gear [
                                            (lineIndex - 1, index - 1),
                                            (lineIndex - 1, index),
                                            (lineIndex - 1, index + 1),
                                            (lineIndex - 1, index + 2),
                                            (lineIndex, index - 1),
                                            (lineIndex, index + 2),
                                            (lineIndex + 1, index - 1),
                                            (lineIndex + 1, index),
                                            (lineIndex + 1, index + 1),
                                            (lineIndex + 1, index + 2),

                                        ]
                                    )
                            else if n < 1000 then
                                state2
                                |> List.concat
                                    (
                                        checkMeYet n gear [
                                            (lineIndex - 1, index - 1),
                                            (lineIndex - 1, index),
                                            (lineIndex - 1, index + 1),
                                            (lineIndex - 1, index + 2),
                                            (lineIndex - 1, index + 3),
                                            (lineIndex, index - 1),
                                            (lineIndex, index + 3),
                                            (lineIndex + 1, index - 1),
                                            (lineIndex + 1, index),
                                            (lineIndex + 1, index + 1),
                                            (lineIndex + 1, index + 2),
                                            (lineIndex + 1, index + 3),

                                        ]
                                    )
                            else
                                crash "bad number"
                        )
                    |> (\r -> state |> List.concat r)
                )
            |> (\partNumbersAgain ->
                when partNumbersAgain is
                    [a, b, ..] -> a * b
                    _ -> 0
            )
        )
    |> List.sum

checkMeYet = \n, gear, positions ->
    if positions |> List.any (\p -> p == gear) then
        [n]
    else
        []
