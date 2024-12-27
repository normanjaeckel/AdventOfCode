app [part1, part2] {
    pf: platform "https://github.com/ostcar/roc-aoc-platform/releases/download/v0.0.8/lhFfiil7mQXDOB6wN-jduJQImoT8qRmoiNHDB4DVF9s.tar.br",
    parser: "https://github.com/lukewilliamboswell/roc-parser/releases/download/0.9.0/w8YKp2YAgQt5REYk912HfKAHBjcXsrnvtjI0CBzoAT4.tar.br",
}

import parser.Parser exposing [Parser, sepBy]
import parser.String exposing [parseStr, digits, string]

example : Str
example =
    """
    1
    10
    100
    2024
    """

expect
    got = part1 example
    expected = Ok "37327623"
    got == expected

part1 : Str -> Result Str [ParsingFailure Str, ParsingIncomplete Str]
part1 = \rawInput ->
    parseStr puzzleParser (rawInput |> Str.trim)
    |> Result.map
        \initialNumbers ->
            initialNumbers
            |> List.map (\n -> calcSecret n 2000)
            |> List.sum
            |> Num.toStr

puzzleParser : Parser (List U8) (List U64)
puzzleParser =
    digits |> sepBy (string "\n")

calcSecret : U64, U64 -> U64
calcSecret = \secret, count ->
    if count == 0 then
        secret
        else

    a = (Num.bitwiseXor (secret * 64) secret) % 16777216
    b = (Num.bitwiseXor (a // 32) a) % 16777216
    c = (Num.bitwiseXor (b * 2048) b) % 16777216
    calcSecret c (count - 1)

expect
    got =
        List.range { start: At 1, end: At 10 }
        |> List.map \n -> calcSecret 123 n
    expected = [
        15887950,
        16495136,
        527345,
        704524,
        1553684,
        12683156,
        11100544,
        12249484,
        7753432,
        5908254,
    ]
    got == expected

expect
    got = part2 example
    expected = Ok ""
    got == expected

part2 : Str -> Result Str [ParsingFailure Str, ParsingIncomplete Str]
part2 = \rawInput ->
    parseStr puzzleParser (rawInput |> Str.trim)
    |> Result.map
        \_input ->
            ""
