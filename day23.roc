app [part1, part2] {
    pf: platform "https://github.com/ostcar/roc-aoc-platform/releases/download/v0.0.8/lhFfiil7mQXDOB6wN-jduJQImoT8qRmoiNHDB4DVF9s.tar.br",
    parser: "https://github.com/lukewilliamboswell/roc-parser/releases/download/0.9.0/w8YKp2YAgQt5REYk912HfKAHBjcXsrnvtjI0CBzoAT4.tar.br",
}

import parser.Parser exposing [Parser, const, keep, sepBy, skip, map, chompWhile, flatten]
import parser.String exposing [parseStr, string]

example : Str
example =
    """
    kh-tc
    qp-kh
    de-cg
    ka-co
    yn-aq
    qp-ub
    cg-tb
    vc-aq
    tb-ka
    wh-tc
    yn-cg
    kh-ub
    ta-co
    de-co
    tc-td
    tb-wq
    wh-td
    ta-ka
    td-qp
    aq-cg
    wq-ub
    ub-vc
    de-ta
    wq-aq
    wq-vc
    wh-yn
    ka-de
    kh-ta
    co-tc
    wh-qp
    tb-vc
    td-yn
    """

expect
    got = part1 example
    expected = Ok "7"
    got == expected

part1 : Str -> Result Str [ParsingFailure Str, ParsingIncomplete Str]
part1 = \rawInput ->
    parseStr puzzleParser (rawInput |> Str.trim)
    |> Result.map
        \connections ->
            network = toNetwork connections
            groups = findGroups network
            filterForT groups |> List.len |> Num.toStr

Connection : (Computer, Computer)
Computer : Str
Network : Dict Computer (List Computer)

puzzleParser : Parser (List U8) (List Connection)
puzzleParser =
    connectionParser |> sepBy (string "\n")

connectionParser : Parser (List U8) Connection
connectionParser =
    const \a -> \b -> (a, b)
    |> keep computerParser
    |> skip (string "-")
    |> keep computerParser

computerParser : Parser (List U8) Computer
computerParser =
    chompWhile \cp -> 'a' <= cp && 'z' >= cp
    |> map \s ->
        when Str.fromUtf8 s is
            Ok c -> Ok c
            Err _ -> Err "invalid computer id"
    |> flatten

toNetwork : List Connection -> Network
toNetwork = \connections ->
    connections
    |> List.walk (Dict.empty {}) \network, (a, b) ->
        network
        |> Dict.update a \possibileValue ->
            when possibileValue is
                Err Missing -> Ok [b]
                Ok value -> Ok (value |> List.append b)
        |> Dict.update b \possibileValue ->
            when possibileValue is
                Err Missing -> Ok [a]
                Ok value -> Ok (value |> List.append a)

findGroups : Network -> List (Set Computer)
findGroups = \network ->
    network
    |> Dict.toList
    |> List.walk [] \acc, (computer, others) ->
        others
        |> List.map \o ->
            (o, o |> hasConnectionsTo others network)
        |> List.dropIf \t -> List.isEmpty t.1
        |> List.map \t ->
            t.1
            |> List.map \x ->
                [computer, t.0, x] |> Set.fromList
        |> List.join
        |> \w ->
            acc |> List.append w
    |> List.join
    |> List.walk [] \acc, elem ->
        if acc |> List.contains elem then
            acc
        else
            acc |> List.append elem

hasConnectionsTo : Computer, List Computer, Network -> List Computer
hasConnectionsTo = \computer, others, network ->
    when network |> Dict.get computer is
        Err KeyNotFound -> []
        Ok connected ->
            others |> List.keepIf \o -> connected |> List.contains o

filterForT : List (Set Computer) -> List (Set Computer)
filterForT = \groups ->
    groups
    |> List.dropIf \g ->
        g |> Set.keepIf (\c -> c |> Str.startsWith "t") |> Set.isEmpty

expect
    got = part2 example
    expected = Ok "co,de,ka,ta"
    got == expected

part2 : Str -> Result Str [ParsingFailure Str, ParsingIncomplete Str]
part2 = \rawInput ->
    parseStr puzzleParser (rawInput |> Str.trim)
    |> Result.map
        \connections ->
            network = toNetwork connections
            groups = findGroups2 network
            groups
            |> List.last
            |> Result.withDefault (Set.empty {})
            |> Set.toList
            |> List.sortWith \a, b ->
                Num.compare (strToNum a) (strToNum b)
            |> Str.joinWith ","

strToNum : Str -> U64
strToNum = \s ->
    s
    |> Str.toUtf8
    |> List.reverse
    |> List.walkWithIndex 0 \acc, cp, i ->
        acc + (Num.toU64 cp * (10 |> Num.powInt (2 * i)))

findGroups2 : Network -> List (Set Computer)
findGroups2 = \network ->
    network
    |> Dict.toList
    |> List.walk [] \result, (computer, others) ->
        result |> List.concat (getParties [Set.single computer] others network)
    |> List.sortWith \a, b ->
        Num.compare (Set.len a) (Set.len b)

getParties : List (Set Computer), List Computer, Network -> List (Set Computer)
getParties = \computers, others, network ->
    when others is
        [] -> computers
        [one, .. as rest] ->
            filtered = one |> hasConnectionsTo rest network
            with = getParties (computers |> List.map (\s -> s |> Set.insert one)) filtered network
            without = getParties computers rest network
            List.concat with without

#     others
#     |> List.map \o ->
#         (o, o |> hasConnectionsTo others network)
#     |> List.dropIf \t -> List.isEmpty t.1
#     |> List.map \t ->
#         t.1
#         |> List.map \x ->
#             [computer, t.0, x] |> Set.fromList
#     |> List.join
#     |> \w ->
#         acc |> List.append w
# |> List.join
# |> List.walk [] \acc, elem ->
#     if acc |> List.contains elem then
#         acc
#     else
#         acc |> List.append elem

