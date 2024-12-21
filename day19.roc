app [part1, part2] {
    pf: platform "https://github.com/ostcar/roc-aoc-platform/releases/download/v0.0.8/lhFfiil7mQXDOB6wN-jduJQImoT8qRmoiNHDB4DVF9s.tar.br",
    parser: "https://github.com/lukewilliamboswell/roc-parser/releases/download/0.9.0/w8YKp2YAgQt5REYk912HfKAHBjcXsrnvtjI0CBzoAT4.tar.br",
}

import parser.Parser exposing [Parser, const, keep, skip, sepBy, oneOrMore, oneOf, map]
import parser.String exposing [parseStr, string]

example : Str
example =
    """
    r, wr, b, g, bwu, rb, gb, br

    brwrr
    bggr
    gbbr
    rrbgbr
    ubwu
    bwurrg
    brgr
    bbrgwb
    """

expect
    got = part1 example
    expected = Ok "6"
    got == expected

part1 : Str -> Result Str [ParsingFailure Str, ParsingIncomplete Str]
part1 = \rawInput ->
    parseStr puzzleParser (rawInput |> Str.trim)
    |> Result.map
        \input ->
            towels = input.towels
            designs = input.designs
            designs
            |> List.map \d ->
                countPossibilities towels d (Dict.single "" 1) |> .count
            |> List.keepIf \n -> n > 0
            |> List.len
            |> Num.toStr

puzzleParser : Parser (List U8) { towels : List Str, designs : List Str }
puzzleParser =
    const \towels -> \designs -> { towels, designs }
    |> keep (towelParser |> sepBy (string ", "))
    |> skip (string "\n\n")
    |> keep (designParser |> sepBy (string "\n"))

towelParser : Parser (List U8) Str
towelParser =
    oneOrMore
        (
            oneOf [
                string "w",
                string "u",
                string "b",
                string "r",
                string "g",
            ]
        )
    |> map \l -> l |> Str.joinWith ""

designParser : Parser (List U8) Str
designParser =
    towelParser

expect
    got = part2 example
    expected = Ok "16"
    got == expected

part2 : Str -> Result Str [ParsingFailure Str, ParsingIncomplete Str]
part2 = \rawInput ->
    parseStr puzzleParser (rawInput |> Str.trim)
    |> Result.map
        \input ->
            towels = input.towels
            designs = input.designs
            designs
            |> List.map \d ->
                countPossibilities towels d (Dict.single "" 1) |> .count
            |> List.sum
            |> Num.toStr

Pattern : Str
Cache : Dict Pattern U64

countPossibilities : List Pattern, Pattern, Cache -> { count : U64, cache : Cache }
countPossibilities = \towels, part, cache ->
    when cache |> Dict.get part is
        Ok v -> { count: v, cache }
        Err KeyNotFound ->
            towels
            |> List.keepIf \t -> part |> Str.startsWith t
            |> List.map \t -> part |> Str.dropPrefix t
            |> List.walk { count: 0, cache } \acc, variant ->
                countPossibilities towels variant acc.cache
                |> \result ->
                    { count: acc.count + result.count, cache: result.cache }
            |> \result2 ->
                { result2 & cache: result2.cache |> Dict.insert part result2.count }
