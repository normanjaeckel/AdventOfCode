app [part1, part2] {
    pf: platform "https://github.com/ostcar/roc-aoc-platform/releases/download/v0.0.5/0jGEKnFtQFKLIcVq59ZuLbVJqM4cTTElcZHTXFjqmvg.tar.br",
}

examplePart1 =
    "the example for part 1"

expect
    got = part1 examplePart1
    expected = "the example for part 1" |> Str.toUtf8
    got == expected

part1 : Str -> List U8
part1 = \input ->
    input
    |> Str.toUtf8

examplePart2 =
    "example for part 2"

expect
    got = part2 examplePart2
    expected = "2 trap rof elpmaxe" |> Str.toUtf8
    got == expected

part2 = \input ->
    input
    |> Str.toUtf8
    |> List.reverse
