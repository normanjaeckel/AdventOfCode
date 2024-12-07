app [part1, part2] {
    pf: platform "https://github.com/ostcar/roc-aoc-platform/releases/download/v0.0.7/Tg23npX1TEGNlsYqX1JfrdtvW4OlwLdvsFnJMUJNZSU.tar.br",
    parser: "https://github.com/lukewilliamboswell/roc-parser/releases/download/0.9.0/w8YKp2YAgQt5REYk912HfKAHBjcXsrnvtjI0CBzoAT4.tar.br",
}

import parser.Parser exposing [Parser, const, keep, sepBy, skip]
import parser.String exposing [parseStr, string, digits]

example : Str
example =
    """
    190: 10 19
    3267: 81 40 27
    83: 17 5
    156: 15 6
    7290: 6 8 6 15
    161011: 16 10 13
    192: 17 8 14
    21037: 9 7 18 13
    292: 11 6 16 20
    """

expect
    got = part1 example
    expected = Ok "3749"
    got == expected

part1 : Str -> Result Str [ParsingFailure Str, ParsingIncomplete Str]
part1 = \rawInput ->
    parseStr puzzleParser (rawInput |> Str.trim)
    |> Result.map \equations -> equations |> solvePuzzle Part1

expect
    got = part2 example
    expected = Ok "11387"
    got == expected

part2 : Str -> Result Str [ParsingFailure Str, ParsingIncomplete Str]
part2 = \rawInput ->
    parseStr puzzleParser (rawInput |> Str.trim)
    |> Result.map \equations -> equations |> solvePuzzle Part2

solvePuzzle : List Equation, Part -> Str
solvePuzzle = \equations, part ->
    equations
    |> List.map \equation -> checkSolutions equation part
    |> List.map2
        equations
        \variants, equation ->
            if variants > 0 then
                equation.testValue
            else
                0
    |> List.sum
    |> Num.toStr

Part : [Part1, Part2]
Equation : { testValue : U64, nums : List U64 }

puzzleParser : Parser (List U8) (List Equation)
puzzleParser =
    lineParser |> sepBy (string "\n")

lineParser : Parser List Equation
lineParser =
    const \testValue -> \nums -> { testValue, nums }
    |> keep digits
    |> skip (string ": ")
    |> keep (digits |> sepBy (string " "))

checkSolutions : Equation, Part -> U64
checkSolutions = \equation, part ->
    checkSolutionsHelper [0] equation.testValue equation.nums part

checkSolutionsHelper : List U64, U64, List U64, Part -> U64
checkSolutionsHelper = \variants, testValue, nums, part ->
    when nums is
        [] ->
            variants
            |> List.keepIf \v -> v == testValue
            |> List.len

        [first, .. as rest] ->
            variants
            |> List.walk
                []
                \acc, variant ->
                    v =
                        when part is
                            Part1 -> [variant + first, variant * first]
                            Part2 -> [variant + first, variant * first] |> List.append (concatination variant first)
                    v
                    |> List.dropIf \res -> res > testValue || res == 0
                    |> \newVariants -> acc |> List.concat newVariants
            |> checkSolutionsHelper testValue rest part

concatination : U64, U64 -> U64
concatination = \a, b ->
    n = b |> Num.toStr |> Str.toUtf8 |> List.len
    a * (10 |> Num.powInt n) + b

expect
    got = concatination 123 45
    expected = 12345
    got == expected

expect
    got = concatination 1 234567
    expected = 1234567
    got == expected
