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

    calcSecret (nextSecret secret) (count - 1)

nextSecret : U64 -> U64
nextSecret = \secret ->
    a = (Num.bitwiseXor (secret * 64) secret) % 16777216
    b = (Num.bitwiseXor (a // 32) a) % 16777216
    c = (Num.bitwiseXor (b * 2048) b) % 16777216
    c

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

example2 : Str
example2 =
    """
    1
    2
    3
    2024
    """

expect
    got = part2 example2
    expected = Ok "23"
    got == expected

part2 : Str -> Result Str [ParsingFailure Str, ParsingIncomplete Str]
part2 = \rawInput ->
    parseStr puzzleParser (rawInput |> Str.trim)
    |> Result.map
        \numbers ->
            collection =
                numbers
                |> List.map \n -> secrets2000 n
                |> List.walk (Dict.empty {}) \acc, dict ->
                    dictMap2 acc dict
            collection |> Dict.values |> List.max |> Result.withDefault 0 |> Num.toStr

secrets2000 : U64 -> Dict (List I64) U64
secrets2000 = \secret ->
    next = nextSecret secret
    nextDigit = next % 10
    diff = Num.toI64 nextDigit - Num.toI64 (secret % 10)
    secrets2000Helper next (2000 - 1) [(nextDigit, diff)] (Dict.empty {})

secrets2000Helper : U64, U64, List (U64, I64), Dict (List I64) U64 -> Dict (List I64) U64
secrets2000Helper = \num, count, listNum, result ->
    if count == 0 then
        result
        else

    next = nextSecret num
    nextDigit = next % 10
    prev = listNum |> List.last |> Result.withDefault (0, 0) |> .0
    newListNum = listNum |> List.append (nextDigit, (Num.toI64 nextDigit - Num.toI64 prev))
    newResult =
        when newListNum |> List.takeLast 4 is
            [(_, a), (_, b), (_, c), (_, d)] ->
                result
                |> Dict.update [a, b, c, d] \possibleValue ->
                    when possibleValue is
                        Err Missing -> Ok nextDigit
                        Ok value -> Ok value

            _ -> result

    secrets2000Helper next (count - 1) newListNum newResult

dictMap2 : Dict k (Num a), Dict k (Num a) -> Dict k (Num a)
dictMap2 = \d1, d2 ->
    if Dict.len d1 < Dict.len d2 then
        d1
        |> Dict.walk d2 \acc, key, value ->
            acc
            |> Dict.update key \possibleValue ->
                when possibleValue is
                    Err Missing -> Ok value
                    Ok found -> Ok (value + found)
    else
        d2
        |> Dict.walk d1 \acc, key, value ->
            acc
            |> Dict.update key \possibleValue ->
                when possibleValue is
                    Err Missing -> Ok value
                    Ok found -> Ok (value + found)
