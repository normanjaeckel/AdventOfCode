interface Solution.Day7
    exposes [
        part1,
        part2,
    ]
    imports [
        "Day7.input" as puzzleInput : Str,
        parser.String.{ parseStr, string, digits, anyCodeunit },
        parser.Core.{ sepBy, const, keep, skip, map },
    ]

part1 =
    solvePart1 puzzleInput

solvePart1 = \input ->
    input
    |> Str.trimEnd
    |> parseHands
    |> List.sortWith handSorting
    |> List.walkWithIndex
        0
        (\state, Hand _ bid, index ->
            state + ((index + 1) * bid)
        )
    |> Num.toStr

parseHands = \input ->
    when inputParser |> parseStr input is
        Err _ -> crash "bad input"
        Ok v -> v

inputParser =
    lineParser |> sepBy (string "\n")

lineParser =
    const (\hand -> \bid -> Hand hand bid)
    |> keep handParser
    |> skip (string " ")
    |> keep digits

handParser =
    const (\a -> \b -> \c -> \d -> \e -> [a, b, c, d, e])
    |> keep (anyCodeunit |> map (\c -> codeToCard c))
    |> keep (anyCodeunit |> map (\c -> codeToCard c))
    |> keep (anyCodeunit |> map (\c -> codeToCard c))
    |> keep (anyCodeunit |> map (\c -> codeToCard c))
    |> keep (anyCodeunit |> map (\c -> codeToCard c))

codeToCard = \c ->
    when c is
        'A' -> CardA
        'K' -> CardK
        'Q' -> CardQ
        'J' -> CardJ
        'T' -> CardT
        '9' -> Card9
        '8' -> Card8
        '7' -> Card7
        '6' -> Card6
        '5' -> Card5
        '4' -> Card4
        '3' -> Card3
        '2' -> Card2
        _ -> crash "bad card"

handSorting = \Hand cards1 _, Hand cards2 _ ->
    if getHandRank cards1 > getHandRank cards2 then
        GT
    else if getHandRank cards1 == getHandRank cards2 then
        EQ
    else
        LT

getHandRank = \cards ->
    updateCardNums = \currentValue ->
        when currentValue is
            Missing -> Present 1
            Present i -> Present (i + 1)

    d =
        cards
        |> List.walk
            (Dict.withCapacity 13)
            (\state, c -> state |> Dict.update c updateCardNums)

    typeValue =
        when d |> Dict.values |> List.sortDesc is
            [5] ->
                7 # Five of a kind

            [a, _] ->
                if a == 4 then
                    6 # Four of a kind
                else
                    5 # Full house

            [a, _, _] ->
                if a == 3 then
                    4 # Three of a kind
                else
                    3 # Two pair

            [_, _, _, _] ->
                2 # One pair

            [_, _, _, _, _] ->
                1 # High card

            _ -> crash "bad hand"

    cardsValue =
        cards
        |> List.walk
            0
            (\state, c -> (state * 20) + cardValue c)

    (typeValue * 10000000) + cardsValue

cardValue = \c ->
    when c is
        CardA -> 13
        CardK -> 12
        CardQ -> 11
        CardJ -> 10
        CardT -> 9
        Card9 -> 8
        Card8 -> 7
        Card7 -> 6
        Card6 -> 5
        Card5 -> 4
        Card4 -> 3
        Card3 -> 2
        Card2 -> 1

exampleData1 =
    """
    32T3K 765
    T55J5 684
    KK677 28
    KTJJT 220
    QQQJA 483
    """

expect
    got = solvePart1 exampleData1
    got == "6440"

part2 =
    solvePart2 puzzleInput

solvePart2 = \_input ->
    ""

exampleData2 =
    """
    """

expect
    got = solvePart2 exampleData2
    got == ""
