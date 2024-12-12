app [part1, part2] {
    pf: platform "https://github.com/ostcar/roc-aoc-platform/releases/download/v0.0.8/lhFfiil7mQXDOB6wN-jduJQImoT8qRmoiNHDB4DVF9s.tar.br",
    parser: "https://github.com/lukewilliamboswell/roc-parser/releases/download/0.9.0/w8YKp2YAgQt5REYk912HfKAHBjcXsrnvtjI0CBzoAT4.tar.br",
}

import parser.Parser exposing [Parser, sepBy]
import parser.String exposing [parseStr, digits, string]

example : Str
example =
    "125 17"

expect
    got = part1 example
    expected = Ok "55312"
    got == expected

part1 : Str -> Result Str [ParsingFailure Str, ParsingIncomplete Str]
part1 = \rawInput ->
    parseStr puzzleParser (rawInput |> Str.trim)
    |> Result.map
        \stones ->
            stones
            |> blink 25
            |> List.len
            |> Num.toStr

puzzleParser : Parser (List U8) (List U64)
puzzleParser =
    digits |> sepBy (string " ")

blink : List U64, U64 -> List U64
blink = \stones, count ->
    if count == 0 then
        stones
        else

    stones
    |> List.map
        \stone ->
            if stone == 0 then
                [1]
            else
                stoneDigits = stone |> Num.toStr |> Str.toUtf8
                len = List.len stoneDigits
                if len % 2 == 0 then
                    half = len // 2
                    first = stoneDigits |> List.takeFirst half |> Str.fromUtf8 |> Result.try \r -> Str.toU64 r
                    second = stoneDigits |> List.dropFirst half |> Str.fromUtf8 |> Result.try \r -> Str.toU64 r
                    when (first, second) is
                        (Ok a, Ok b) ->
                            [a, b]

                        _ -> crash "Uh oh"
                else
                    [stone * 2024]
    |> List.join
    |> blink (count - 1)

part2 : Str -> Result Str [ParsingFailure Str, ParsingIncomplete Str]
part2 = \rawInput ->
    parseStr puzzleParser (rawInput |> Str.trim)
    |> Result.map
        \stones ->
            map = updateMap (Dict.empty {}) stones
            solvePart2 map stones
            |> Num.toStr

Map : Dict U64 (List U64)

updateMap : Map, List U64 -> Map
updateMap = \map, stones ->
    when stones is
        [] -> map
        [stone, .. as rest] ->
            if map |> Dict.contains stone then
                updateMap map rest
            else
                newStones = [stone] |> blink 15
                newMap = map |> Dict.insert stone newStones
                updateMap newMap (rest |> List.concat newStones)

solvePart2 : Map, List U64 -> U64
solvePart2 = \map, stones ->
    convertedMap = map |> Dict.map \_key, val -> List.len val # After 15 blinks
    convertedMap2 = mapByOne map convertedMap # After 30 blinks
    convertedMap3 = mapByOne map convertedMap2 # After 45 blinks
    convertedMap4 = mapByOne map convertedMap3 # After 60 blinks
    convertedMap5 = mapByOne map convertedMap4 # After 75 blinks

    stones
    |> List.map
        \stone ->
            when convertedMap5 |> Dict.get stone is
                Err KeyNotFound -> crash "Bad luck"
                Ok v -> v
    |> List.sum

mapByOne : Map, Dict U64 U64 -> Dict U64 U64
mapByOne = \map, convertedMap ->
    map
    |> Dict.map
        \_key, stones ->
            stones
            |> List.map
                \stone ->
                    when convertedMap |> Dict.get stone is
                        Err KeyNotFound -> crash "Uh oh"
                        Ok val -> val
            |> List.sum
