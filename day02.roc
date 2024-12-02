app [part1, part2] {
    pf: platform "https://github.com/ostcar/roc-aoc-platform/releases/download/v0.0.6/h-Fncg-ySjnWsh6mOiuaqdkz6wwfYCPCgy64Wep58YI.tar.br",
    parser: "https://github.com/lukewilliamboswell/roc-parser/releases/download/0.9.0/w8YKp2YAgQt5REYk912HfKAHBjcXsrnvtjI0CBzoAT4.tar.br",
}

import parser.Parser exposing [Parser, const, keep, many, maybe, skip]
import parser.String exposing [parseStr, digits, string]

example : Str
example =
    """
    7 6 4 2 1
    1 2 7 8 9
    9 7 6 2 1
    1 3 2 4 5
    8 6 4 4 1
    1 3 6 7 9
    """

expect
    got = part1 example
    expected = Ok "2"
    got == expected

part1 : Str -> Result Str [ParsingFailure Str, ParsingIncomplete Str]
part1 = \rawInput ->
    parseStr puzzleParser rawInput
    |> Result.map
        \reports ->
            reports
            |> List.keepIf
                \report ->
                    checkSafety report PDInactive
            |> List.len
            |> Num.toStr

Report : List Level
Level : U64
ProblemDampener : [PDActive, PDInactive]

puzzleParser : Parser (List U8) (List Report)
puzzleParser =
    const \first -> \rest -> rest |> List.prepend first
    |> keep reportParser
    |> keep
        (
            many
                (
                    const \report -> report
                    |> skip (string "\n")
                    |> keep reportParser
                )
        )

reportParser : Parser (List U8) Report
reportParser =
    many
        (
            const \level -> level
            |> keep digits
            |> skip (maybe (string " "))
        )

checkSafety : Report, ProblemDampener -> Bool
checkSafety = \report, pd ->
    (safeAsc report pd) || (safeDesc report pd)

safeAsc : Report, ProblemDampener -> Bool
safeAsc = \report, pd ->
    when report is
        [first, second, third, .. as rest] ->
            when pd is
                PDInactive ->
                    checkLevels first second && safeAscHelper first second third rest PDInactive

                PDActive ->
                    if checkLevels first second then
                        safeAscHelper first second third rest PDActive
                    else if checkLevels first third then
                        # In this case it might be also correct to skip first element but this makes no difference.
                        when rest is
                            [fourth, .. as next] ->
                                safeAscHelper first third fourth next PDInactive

                            [] ->
                                Bool.true
                    else
                        safeAscHelper first second third rest PDInactive

        _ ->
            Bool.false

safeAscHelper : Level, Level, Level, Report, ProblemDampener -> Bool
safeAscHelper = \first, second, third, rest, pd ->
    when rest is
        [] ->
            pd == PDActive || checkLevels second third

        [fourth, .. as next] ->
            if checkLevels second third then
                safeAscHelper second third fourth next pd
            else
                when pd is
                    PDInactive ->
                        Bool.false

                    PDActive ->
                        if checkLevels first third then
                            safeAscHelper first third fourth next PDInactive
                        else
                            safeAscHelper first second fourth next PDInactive

checkLevels : Level, Level -> Bool
checkLevels = \a, b ->
    a < b && b <= a + 3

safeDesc : Report, ProblemDampener -> Bool
safeDesc = \report, pd ->
    report
    |> List.reverse
    |> safeAsc pd

expect
    got = part2 example
    expected = Ok "4"
    got == expected

part2 : Str -> Result Str [ParsingFailure Str, ParsingIncomplete Str]
part2 = \rawInput ->
    parseStr puzzleParser rawInput
    |> Result.map
        \reports ->
            reports
            |> List.keepIf
                \report ->
                    checkSafety report PDActive
            |> List.len
            |> Num.toStr
