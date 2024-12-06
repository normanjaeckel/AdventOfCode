app [part1, part2] {
    pf: platform "https://github.com/ostcar/roc-aoc-platform/releases/download/v0.0.8/lhFfiil7mQXDOB6wN-jduJQImoT8qRmoiNHDB4DVF9s.tar.br",
    parser: "https://github.com/lukewilliamboswell/roc-parser/releases/download/0.9.0/w8YKp2YAgQt5REYk912HfKAHBjcXsrnvtjI0CBzoAT4.tar.br",
}

import parser.Parser exposing [Parser, const, keep, skip, sepBy]
import parser.String exposing [parseStr, string, digits]

example : Str
example =
    """
    47|53
    97|13
    97|61
    97|47
    75|29
    61|13
    75|53
    29|13
    97|29
    53|29
    61|53
    97|53
    61|29
    47|13
    75|47
    97|75
    47|61
    75|61
    47|29
    75|13
    53|13

    75,47,61,53,29
    97,61,53,29,13
    75,29,13
    75,97,47,61,53
    61,13,29
    97,13,75,29,47
    """

expect
    got = part1 example
    expected = Ok "143"
    got == expected

part1 : Str -> Result Str [ParsingFailure Str, ParsingIncomplete Str, OutOfBounds]
part1 = \rawInput ->
    parseStr puzzleParser (rawInput |> Str.trim)
    |> Result.try
        \(rules, updates) ->
            updates
            |> List.keepIf
                \update ->
                    update |> check rules
            |> List.mapTry
                \update ->
                    idx = (List.len update) // 2
                    update |> List.get idx
            |> try
            |> List.sum
            |> Num.toStr
            |> Ok

PageOrderingRule : { left : U64, right : U64 }
PageUpdate : List U64

puzzleParser : Parser (List U8) (List PageOrderingRule, List PageUpdate)
puzzleParser =
    const \a -> \b -> (a, b)
    |> keep (pageOrderingRuleParser |> sepBy (string "\n"))
    |> skip (string "\n\n")
    |> keep (pageUpdateParser |> sepBy (string ("\n")))

pageOrderingRuleParser : Parser (List U8) PageOrderingRule
pageOrderingRuleParser =
    const \l -> \r -> { left: l, right: r }
    |> keep digits
    |> skip (string "|")
    |> keep digits

pageUpdateParser : Parser (List U8) PageUpdate
pageUpdateParser =
    digits |> sepBy (string ",")

check : PageUpdate, List PageOrderingRule -> Bool
check = \update, rules ->
    rules
    |> List.walkUntil
        Bool.true
        \_, rule ->
            update
            |> List.walkUntil
                Right
                \state, page ->
                    when state is
                        Right ->
                            if rule.right == page then
                                Continue Left
                            else
                                Continue Right

                        Left ->
                            if rule.left == page then
                                Break End
                            else
                                Continue Left

                        End ->
                            crash "Impossible"
            |> \state ->
                when state is
                    End -> Break Bool.false
                    _ -> Continue Bool.true

expect
    got = part2 example
    expected = Ok "123"
    got == expected

part2 : Str -> Result Str [ParsingFailure Str, ParsingIncomplete Str, OutOfBounds]
part2 = \rawInput ->
    parseStr puzzleParser (rawInput |> Str.trim)
    |> Result.try
        \(rules, updates) ->
            updates
            |> List.dropIf
                \update ->
                    update |> check rules
            |> List.map (\u -> orderThem u rules)
            |> List.mapTry
                \update ->
                    idx = (List.len update) // 2
                    update |> List.get idx
            |> try
            |> List.sum
            |> Num.toStr
            |> Ok

orderThem : PageUpdate, List PageOrderingRule -> PageUpdate
orderThem = \update, rules ->
    update
    |> List.sortWith
        \a, b ->
            if rules |> List.contains { left: a, right: b } then
                LT
            else if rules |> List.contains { left: b, right: a } then
                GT
            else
                EQ
