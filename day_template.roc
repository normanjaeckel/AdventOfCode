app [part1, part2] {
    pf: platform "https://github.com/ostcar/roc-aoc-platform/releases/download/v0.0.6/h-Fncg-ySjnWsh6mOiuaqdkz6wwfYCPCgy64Wep58YI.tar.br",
    parser: "https://github.com/lukewilliamboswell/roc-parser/releases/download/0.9.0/w8YKp2YAgQt5REYk912HfKAHBjcXsrnvtjI0CBzoAT4.tar.br",
}

import parser.Parser exposing [Parser, const]
import parser.String exposing [parseStr]

example : Str
example =
    """
    """

expect
    got = part1 example
    expected = Ok ""
    got == expected

part1 : Str -> Result Str _
part1 = \rawInput ->
    parseStr puzzleParser rawInput
    |> Result.map
        \input ->
            input

puzzleParser : Parser (List U8) Str
puzzleParser =
    const ""

expect
    got = part2 example
    expected = Ok ""
    got == expected

part2 : Str -> Result Str _
part2 = \_rawInput ->
    Ok ""
