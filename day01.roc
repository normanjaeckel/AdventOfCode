app [part1, part2] {
    pf: platform "https://github.com/ostcar/roc-aoc-platform/releases/download/v0.0.5/0jGEKnFtQFKLIcVq59ZuLbVJqM4cTTElcZHTXFjqmvg.tar.br",
    parser: "https://github.com/lukewilliamboswell/roc-parser/releases/download/0.9.0/w8YKp2YAgQt5REYk912HfKAHBjcXsrnvtjI0CBzoAT4.tar.br",
}

import parser.Parser exposing [Parser, const, keep, many, map, maybe, skip]
import parser.String exposing [parseStr, digits, string]

examplePart1 : Str
examplePart1 =
    """
    3   4
    4   3
    2   5
    1   3
    3   9
    3   3
    """

expect
    got = part1 examplePart1 |> Str.fromUtf8 |> Result.withDefault "Invalid result"
    expected = "11"
    got == expected

part1 : Str -> List U8
part1 = \rawInput ->
    when parseStr puzzleParser rawInput is
        Err _ ->
            "Invalid input" |> Str.toUtf8

        Ok input ->
            left = input.left |> List.sortAsc
            right = input.right |> List.sortAsc
            List.map2 left right (\a, b -> Num.absDiff a b)
            |> List.sum
            |> Num.toStr
            |> Str.toUtf8

puzzleParser : Parser (List U8) { left : List U64, right : List U64 }
puzzleParser =
    many
        (
            const (\a -> \b -> (a, b))
            |> keep digits
            |> skip (string "   ")
            |> keep digits
            |> skip (maybe (string "\n"))
        )
    |> map \lines ->
        lines
        |> List.walk
            { left: [], right: [] }
            \state, (a, b) ->
                { left: state.left |> List.append a, right: state.right |> List.append b }

examplePart2 = examplePart1

expect
    got = part2 examplePart2 |> Str.fromUtf8 |> Result.withDefault "Invalid result"
    expected = "31"
    got == expected

part2 : Str -> List U8
part2 = \rawInput ->
    when parseStr puzzleParser rawInput is
        Err _ ->
            "Invalid input" |> Str.toUtf8

        Ok input ->
            input.left
            |> List.map
                \a ->
                    count = input.right |> List.countIf \b -> a == b
                    a * count
            |> List.sum
            |> Num.toStr
            |> Str.toUtf8
