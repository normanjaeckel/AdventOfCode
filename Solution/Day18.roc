interface Solution.Day18
    exposes [
        part1,
        part2,
    ]
    imports [
        "Day18.input" as puzzleInput : Str,
        parser.String.{ parseStr, string, digits, codeunit },
        parser.Core.{ const, sepBy, keep, skip, oneOf, many, map },
    ]

part1 =
    solvePart1 puzzleInput

solvePart1 = \input ->
    steps = input |> Str.trim |> parsePuzzleInput
    steps |> gaussArea |> Num.toStr

parsePuzzleInput = \input ->
    when parseStr puzzleParser input is
        Ok v -> v
        Err _ -> crash "parsing failed"

puzzleParser =
    lineParser |> sepBy (string "\n")

lineParser =
    const (\direction -> \length -> \color -> { direction, length, color })
    |> keep directionParser
    |> skip (string " ")
    |> keep (digits |> map (\d -> Num.toI64 d))
    |> skip (string " ")
    |> keep colorParser

directionParser =
    oneOf [
        codeunit 'R' |> map (\_ -> Right),
        codeunit 'D' |> map (\_ -> Down),
        codeunit 'L' |> map (\_ -> Left),
        codeunit 'U' |> map (\_ -> Up),
    ]

colorParser =
    const (\h -> h)
    |> skip (string "(#")
    |> keep hexParser
    |> skip (string ")")

hexParser =
    many
        (
            oneOf [
                codeunit '0',
                codeunit '1',
                codeunit '2',
                codeunit '3',
                codeunit '4',
                codeunit '5',
                codeunit '6',
                codeunit '7',
                codeunit '8',
                codeunit '9',
                codeunit 'a',
                codeunit 'b',
                codeunit 'c',
                codeunit 'd',
                codeunit 'e',
                codeunit 'f',
            ]
        )

gaussArea = \steps ->
    steps
    |> List.walk
        (0, 0, 0)
        (\(area, y, lineLen), { direction, length } ->
            newLineLen = lineLen + length
            when direction is
                Right ->
                    (area - (y * length), y, newLineLen)

                Left ->
                    (area + (y * length), y, newLineLen)

                Down ->
                    (area, y + length, newLineLen)

                Up ->
                    (area, y - length, newLineLen)
        )
    |> (\(area, _, lineLen) -> area + (lineLen // 2) + 1)

exampleData1 =
    """
    R 6 (#70c710)
    D 5 (#0dc571)
    L 2 (#5713f0)
    D 2 (#d2c081)
    R 2 (#59c680)
    D 2 (#411b91)
    L 5 (#8ceee2)
    U 2 (#caa173)
    L 1 (#1b58a2)
    U 2 (#caa171)
    R 2 (#7807d2)
    U 3 (#a77fa3)
    L 2 (#015232)
    U 2 (#7a21e3)
    """

expect
    got = solvePart1 exampleData1
    got == "62"

part2 =
    solvePart2 puzzleInput

solvePart2 = \input ->
    steps = input |> Str.trim |> parsePuzzleInput
    steps |> parseColors |> gaussArea |> Num.toStr

exampleData2 =
    exampleData1

expect
    got = solvePart2 exampleData2
    got == "952408144115"

parseColors = \steps ->
    steps
    |> List.map
        (\{ color } ->
            newdirection =
                when color |> List.last is
                    Err _ -> crash "bad colors"
                    Ok char ->
                        when char is
                            '0' -> Right
                            '1' -> Down
                            '2' -> Left
                            '3' -> Up
                            _ -> crash "bad colors 2"

            newLength = hexListToNum (color |> List.takeFirst 5)

            { direction: newdirection, length: newLength }
        )

hexListToNum = \l ->
    l
    |> List.reverse
    |> List.walkWithIndex
        (Num.toI64 0)
        (\state, char, index ->
            state + ((charToNum char) * (Num.powInt 16 (Num.toI64 index))) |> Num.toI64
        )

charToNum = \char ->
    when char is
        '0' -> 0
        '1' -> 1
        '2' -> 2
        '3' -> 3
        '4' -> 4
        '5' -> 5
        '6' -> 6
        '7' -> 7
        '8' -> 8
        '9' -> 9
        'a' -> 10
        'b' -> 11
        'c' -> 12
        'd' -> 13
        'e' -> 14
        'f' -> 15
        _ -> crash "bad value"

expect
    got = hexListToNum ['7', '0', 'c', '7', '1']
    got == 461937
