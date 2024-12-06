app [part1, part2] {
    pf: platform "https://github.com/ostcar/roc-aoc-platform/releases/download/v0.0.8/lhFfiil7mQXDOB6wN-jduJQImoT8qRmoiNHDB4DVF9s.tar.br",
    parser: "https://github.com/lukewilliamboswell/roc-parser/releases/download/0.9.0/w8YKp2YAgQt5REYk912HfKAHBjcXsrnvtjI0CBzoAT4.tar.br",
}

import parser.Parser exposing [Parser, many, map, oneOf, sepBy]
import parser.String exposing [parseStr, codeunit, codeunitSatisfies]

example : Str
example =
    """
    MMMSXXMASM
    MSAMXMSMSA
    AMXSXMAAMM
    MSAMASMSMX
    XMASAMXAMM
    XXAMMXXAMA
    SMSMSASXSS
    SAXAMASAAA
    MAMMMXMMMM
    MXMXAXMASX
    """

expect
    got = part1 example
    expected = Ok "18"
    got == expected

part1 : Str -> Result Str [ParsingFailure Str, ParsingIncomplete Str]
part1 = \rawInput ->
    parseStr puzzleParser (rawInput |> Str.trim)
    |> Result.map
        \input ->
            searchXMAS input Part1
            |> Num.toStr

Map : List (List Symbol)
Symbol : [X, M, A, S, Other]

puzzleParser : Parser (List U8) Map
puzzleParser =
    lineParser |> sepBy (codeunit '\n')

lineParser : Parser (List U8) (List Symbol)
lineParser =
    many symbolParser

symbolParser : Parser (List U8) Symbol
symbolParser =
    oneOf [
        codeunit 'X' |> map \_ -> X,
        codeunit 'M' |> map \_ -> M,
        codeunit 'A' |> map \_ -> A,
        codeunit 'S' |> map \_ -> S,
        codeunitSatisfies (\c -> c != '\n') |> map \_ -> Other,
    ]

PuzzlePart : [Part1, Part2]
Index : U64
Expectation1 : { m : Index, a : Index, s : Index }
Expectation2 : { m : Index, a : Index, s1 : Index, s2 : Index }

searchXMAS : Map, PuzzlePart -> U64
searchXMAS = \m, part ->
    lineLength = m |> List.first |> Result.map (\l -> List.len l) |> Result.withDefault 0
    maxIndex = (List.len m * lineLength) - 1
    longLine =
        m
        |> List.walk
            []
            \state, line ->
                state |> List.concat line
    when part is
        Part1 ->
            a = searchForwardHelperPartOne longLine 0 lineLength maxIndex []
            b = searchForwardHelperPartOne (List.reverse longLine) 0 lineLength maxIndex []
            a + b

        Part2 ->
            a = searchForwardHelperPartTwo longLine 0 lineLength maxIndex []
            b = searchForwardHelperPartTwo (List.reverse longLine) 0 lineLength maxIndex []
            a + b

searchForwardHelperPartOne : List Symbol, Index, U64, Index, List Expectation1 -> U64
searchForwardHelperPartOne = \symbols, index, lineLength, maxIndex, expectations ->
    when symbols is
        [] ->
            List.len expectations

        [symbol, .. as rest] ->
            newExp = checkExpectationsPartOne expectations index symbol lineLength maxIndex
            searchForwardHelperPartOne rest (index + 1) lineLength maxIndex newExp

checkExpectationsPartOne : List Expectation1, Index, Symbol, U64, Index -> List Expectation1
checkExpectationsPartOne = \exps, index, symbol, lineLength, maxIndex ->
    exps
    |> List.dropIf
        \exp ->
            if exp.m == index then
                symbol != M
            else if exp.a == index then
                symbol != A
            else if exp.s == index then
                symbol != S
            else
                Bool.false
    |> \e ->
        if symbol == X then
            e |> List.concat (newExpsPartOne index lineLength maxIndex)
        else
            e

newExpsPartOne : Index, U64, Index -> List Expectation1
newExpsPartOne = \index, lineLength, maxIndex ->
    okToEast = index % lineLength + 4 <= lineLength
    okToWest = index % lineLength >= 3
    okToSouth = index + (3 * lineLength) <= maxIndex
    a =
        if okToEast then
            [{ m: index + 1, a: index + 2, s: index + 3 }]
        else
            []
    b =
        if okToEast && okToSouth then
            a |> List.append { m: index + 1 + lineLength, a: index + 2 + 2 * lineLength, s: index + 3 + 3 * lineLength }
        else
            a
    c =
        if okToSouth then
            b |> List.append { m: index + lineLength, a: index + 2 * lineLength, s: index + 3 * lineLength }
        else
            b
    if okToWest && okToSouth then
        c |> List.append { m: index - 1 + lineLength, a: index - 2 + 2 * lineLength, s: index - 3 + 3 * lineLength }
    else
        c

expect
    got = part2 example
    expected = Ok "9"
    got == expected

example2 =
    """
    S.M.S
    .A.A.
    S.M.S
    """

expect
    got = part2 example2
    expected = Ok "2"
    got == expected

part2 : Str -> Result Str [ParsingFailure Str, ParsingIncomplete Str]
part2 = \rawInput ->
    parseStr puzzleParser (rawInput |> Str.trim)
    |> Result.map
        \input ->
            searchXMAS input Part2
            |> Num.toStr

searchForwardHelperPartTwo : List Symbol, Index, U64, Index, List Expectation2 -> U64
searchForwardHelperPartTwo = \symbols, index, lineLength, maxIndex, expectations ->
    when symbols is
        [] ->
            List.len expectations

        [symbol, .. as rest] ->
            newExp = checkExpectationsPartTwo expectations index symbol lineLength maxIndex
            searchForwardHelperPartTwo rest (index + 1) lineLength maxIndex newExp

checkExpectationsPartTwo : List Expectation2, Index, Symbol, U64, Index -> List Expectation2
checkExpectationsPartTwo = \exps, index, symbol, lineLength, maxIndex ->
    exps
    |> List.dropIf
        \exp ->
            if exp.m == index then
                symbol != M
            else if exp.a == index then
                symbol != A
            else if exp.s1 == index then
                symbol != S
            else if exp.s2 == index then
                symbol != S
            else
                Bool.false
    |> \e ->
        if symbol == M then
            e |> List.concat (newExpsPartTwo index lineLength maxIndex)
        else
            e

newExpsPartTwo : Index, U64, Index -> List Expectation2
newExpsPartTwo = \index, lineLength, maxIndex ->
    okToEast = index % lineLength + 3 <= lineLength
    okToSouth = index + (2 * lineLength) <= maxIndex
    if okToEast && okToSouth then
        [
            { m: index + 2, a: index + 1 + lineLength, s1: index + 2 * lineLength, s2: index + 2 + 2 * lineLength },
            { m: index + 2 * lineLength, a: index + 1 + lineLength, s1: index + 2, s2: index + 2 + 2 * lineLength },
        ]
    else
        []
