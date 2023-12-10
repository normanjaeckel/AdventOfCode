interface Solution.Day8
    exposes [
        part1,
        part2,
    ]
    imports [
        "Day8.input" as puzzleInput : Str,
        parser.String.{ RawStr, parseStr, codeunit, string },
        parser.Core.{ Parser, const, keep, skip, sepBy, map, oneOf, chompUntil, oneOrMore },
    ]

part1 =
    solvePart1 puzzleInput

solvePart1 = \input ->
    i = input |> Str.trim |> parseInput inputParser1
    n = input |> Str.trim |> parseInput inputParser2 |> List.map (\MapLine a b c -> (a, (b, c))) |> Dict.fromList

    walk i n 0 "AAA"
    |> Num.toStr

parseInput = \input, parser ->
    when parseStr parser input is
        Ok v -> v
        Err _ -> crash "bad input"

inputParser1 =
    const (\i -> \_ -> i)
    |> keep
        (
            oneOrMore
                (
                    oneOf [
                        codeunit 'L' |> map (\_ -> Left),
                        codeunit 'R' |> map (\_ -> Right),
                    ]
                )
        )
    |> skip (string "\n\n")
    |> keep (networkLineParser |> sepBy (string "\n"))

inputParser2 =
    const (\_ -> \n -> n)
    |> keep
        (
            oneOrMore
                (
                    oneOf [
                        codeunit 'L' |> map (\_ -> Left),
                        codeunit 'R' |> map (\_ -> Right),
                    ]
                )
        )
    |> skip (string "\n\n")
    |> keep (networkLineParser |> sepBy (string "\n"))

networkLineParser =
    const (\element1 -> \element2 -> \element3 -> MapLine element1 element2 element3)
    |> keep (chompUntil ' ' |> map (\v -> Str.fromUtf8 v |> helper))
    |> skip (string " = (")
    |> keep (chompUntil ',' |> map (\v -> Str.fromUtf8 v |> helper))
    |> skip (string ", ")
    |> keep (chompUntil ')' |> map (\v -> Str.fromUtf8 v |> helper))
    |> skip (string ")")

helper = \res ->
    when res is
        Ok v -> v
        Err _ -> crash "bad utf8 value"

walk = \instructions, network, index, node ->
    nextInstruction = getNextInstruction instructions index
    nextNode = getNextNode network node nextInstruction
    if nextNode == "ZZZ" then
        index + 1
    else
        walk instructions network (index + 1) nextNode

getNextInstruction = \instructions, index ->
    l = List.len instructions
    when instructions |> List.get (index % l) is
        Err _ -> crash "ugly error"
        Ok v -> v

getNextNode = \network, node, direction ->
    when network |> Dict.get node is
        Err _ -> crash "bad input, missing node in network"
        Ok (a, b) ->
            when direction is
                Left -> a
                Right -> b

exampleData1 =
    """
    RL

    AAA = (BBB, CCC)
    BBB = (DDD, EEE)
    CCC = (ZZZ, GGG)
    DDD = (DDD, DDD)
    EEE = (EEE, EEE)
    GGG = (GGG, GGG)
    ZZZ = (ZZZ, ZZZ)
    """

exampleData2 =
    """
    LLR

    AAA = (BBB, BBB)
    BBB = (AAA, ZZZ)
    ZZZ = (ZZZ, ZZZ)
    """

expect
    got = solvePart1 exampleData1
    got == "2"

expect
    got = solvePart1 exampleData2
    got == "6"

part2 =
    solvePart2 puzzleInput

solvePart2 = \input ->
    i = input |> Str.trim |> parseInput inputParser1
    n = input |> Str.trim |> parseInput inputParser2 |> List.map (\MapLine a b c -> (a, (b, c))) |> Dict.fromList

    startingNodes = n |> Dict.keepIf (\(k, _) -> k |> Str.endsWith "A") |> Dict.keys

    startingNodes
    |> List.map
        (\startingNode ->
            walk2 i n 0 startingNode
        )
    |> List.walk
        1
        (\state, value ->
            eu = euklid state value
            state * value // eu
        )
    |> Num.toStr

walk2 = \instructions, network, index, node ->
    nextInstruction = getNextInstruction instructions index
    nextNode = getNextNode network node nextInstruction
    if nextNode |> Str.endsWith "Z" then
        index + 1
    else
        walk2 instructions network (index + 1) nextNode

euklid = \a, b ->
    if b == 0 then
        a
    else
        euklid b (a % b)
