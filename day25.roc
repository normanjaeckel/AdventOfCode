app [part1, part2] {
    pf: platform "https://github.com/ostcar/roc-aoc-platform/releases/download/v0.0.8/lhFfiil7mQXDOB6wN-jduJQImoT8qRmoiNHDB4DVF9s.tar.br",
    parser: "https://github.com/lukewilliamboswell/roc-parser/releases/download/0.9.0/w8YKp2YAgQt5REYk912HfKAHBjcXsrnvtjI0CBzoAT4.tar.br",
}

import parser.Parser exposing [Parser, sepBy, oneOrMore, oneOf, map]
import parser.String exposing [parseStr, string]

example : Str
example =
    """
    #####
    .####
    .####
    .####
    .#.#.
    .#...
    .....

    #####
    ##.##
    .#.##
    ...##
    ...#.
    ...#.
    .....

    .....
    #....
    #....
    #...#
    #.#.#
    #.###
    #####

    .....
    .....
    #.#..
    ###..
    ###.#
    ###.#
    #####

    .....
    .....
    .....
    #....
    #.#..
    #.#.#
    #####
    """

expect
    got = part1 example
    expected = Ok "3"
    got == expected

part1 : Str -> Result Str [ParsingFailure Str, ParsingIncomplete Str]
part1 = \rawInput ->
    parseStr puzzleParser (rawInput |> Str.trim)
    |> Result.map
        \schemas ->
            { keys, locks } = getKeysAndLocksFrom schemas
            locks
            |> List.map \lock -> lock |> fittingKeys keys |> List.len
            |> List.sum
            |> Num.toStr

Schema : List (List Symbol)
Symbol : [Filled, Empty]
Code : List U64

puzzleParser : Parser (List U8) (List Schema)
puzzleParser =
    schemaParser |> sepBy (string "\n\n")

schemaParser : Parser (List U8) Schema
schemaParser =
    lineParser |> sepBy (string "\n")

lineParser : Parser (List U8) (List Symbol)
lineParser =
    oneOrMore
        (
            oneOf [
                string "#" |> map \_ -> Filled,
                string "." |> map \_ -> Empty,
            ]
        )

getKeysAndLocksFrom : List Schema -> { keys : List Code, locks : List Code }
getKeysAndLocksFrom = \schemas ->
    initial = { keys: [], locks: [] }
    schemas
    |> List.walk initial \acc, schema ->
        if schema |> isLock then
            { acc & locks: acc.locks |> List.append (schema |> toCode) }
        else
            { acc & keys: acc.keys |> List.append (schema |> List.reverse |> toCode) }

isLock : Schema -> Bool
isLock = \schema ->
    firstElement = schema |> List.first |> Result.withDefault [] |> List.first |> Result.withDefault Empty
    firstElement == Filled

toCode : Schema -> Code
toCode = \schema ->
    schema
    |> List.walk (Dict.empty {}) \outerState, line ->
        line
        |> List.walkWithIndex outerState \state, symbol, index ->
            when symbol is
                Filled ->
                    state
                    |> Dict.update index \possibileValue ->
                        when possibileValue is
                            Err Missing -> Ok 0
                            Ok value -> Ok (value + 1)

                Empty -> state
    |> Dict.toList
    |> List.sortWith \a, b ->
        Num.compare a.0 b.0
    |> List.map .1

fittingKeys : Code, List Code -> List Code
fittingKeys = \lock, keys ->
    keys
    |> List.keepIf \key ->
        List.map2 lock key \l, k ->
            l + k <= 5
        |> List.all \r -> r

expect
    got = part2 example
    expected = Ok ""
    got == expected

part2 : Str -> Result Str [ParsingFailure Str, ParsingIncomplete Str]
part2 = \_rawInput ->
    Ok "Merry Christmas!"
