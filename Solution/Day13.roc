interface Solution.Day13
    exposes [
        part1,
        part2,
    ]
    imports [
        "Day13.input" as puzzleInput : Str,
        parser.String.{ parseStr, string, codeunit },
        parser.Core.{ sepBy, many, oneOf, map },
    ]

part1 =
    solvePart1 puzzleInput

solvePart1 = \input ->
    parsedInput = input |> Str.trim |> Str.split "\n\n" |> List.map parsePuzzleInput
    invertedParsedInput = parsedInput |> List.map invertMap

    horizontal = parsedInput |> List.map findReflection |> List.map (\n -> n * 100)
    vertical = invertedParsedInput |> List.map findReflection

    List.concat horizontal vertical
    |> List.sum
    |> Num.toStr

parsePuzzleInput = \input ->
    when parseStr puzzleParser input is
        Ok v -> v
        Err _ -> crash "parsing failed"

puzzleParser =
    lineParser |> sepBy (string "\n")

lineParser =
    many
        (
            oneOf [
                codeunit '#' |> map (\_ -> Rock),
                codeunit '.' |> map (\_ -> Ash),
            ]
        )

invertMap = \lines ->
    l = lines |> List.first |> Result.withDefault [] |> List.len
    result = List.repeat [] l

    lines
    |> List.walk
        result
        (\state, line ->
            line
            |> List.walkWithIndex
                state
                (\state2, element, index ->
                    when state2 |> List.get index is
                        Err _ -> crash "impossible"
                        Ok innerList ->
                            state2 |> List.set index (innerList |> List.append element)
                )
        )

expect
    got = invertMap [[Rock, Rock, Ash], [Ash, Ash, Rock], [Ash, Ash, Ash]]
    got == [[Rock, Ash, Ash], [Rock, Ash, Ash], [Ash, Rock, Ash]]

findReflection = \lines ->
    findReflectionHelper [] lines

findReflectionHelper = \left, right ->
    when right is
        [one, .. as rest] ->
            if List.isEmpty rest then
                0
            else
                newLeft = left |> List.append one
                l = List.len newLeft
                if l <= List.len rest then
                    newRest = rest |> List.takeFirst (l)
                    if newLeft |> List.reverse == newRest then
                        l
                    else
                        findReflectionHelper newLeft rest
                else
                    shorterNewLeft = newLeft |> List.takeLast (List.len rest)
                    if shorterNewLeft |> List.reverse == rest then
                        l
                    else
                        findReflectionHelper newLeft rest

        [] ->
            0

exampleData1 =
    """
    #.##..##.
    ..#.##.#.
    ##......#
    ##......#
    ..#.##.#.
    ..##..##.
    #.#.##.#.

    #...##..#
    #....#..#
    ..##..###
    #####.##.
    #####.##.
    ..##..###
    #....#..#
    """

expect
    got = solvePart1 exampleData1
    got == "405"

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
