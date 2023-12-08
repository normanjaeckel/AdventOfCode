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
    |> List.sortWith (handSorting getHandRank1)
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

handSorting = \rankFn ->
    \Hand cards1 _, Hand cards2 _ ->
        if rankFn cards1 > rankFn cards2 then
            GT
        else if rankFn cards1 == rankFn cards2 then
            EQ
        else
            LT

getHandRank1 = \cards ->
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

    cardsValue =
        cards
        |> List.walk
            0
            (\state, c -> (state * 20) + cardValue c)

    (typeValue * 10000000) + cardsValue

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

solvePart2 = \input ->
    input
    |> Str.trimEnd
    |> parseHands
    |> List.sortWith (handSorting getHandRank2)
    |> List.walkWithIndex
        0
        (\state, Hand _ bid, index ->
            state + ((index + 1) * bid)
        )
    |> Num.toStr

getHandRank2 = \cards ->
    updateCardNums = \currentValue ->
        when currentValue is
            Missing -> Present 1
            Present i -> Present (i + 1)

    d =
        cards
        |> List.walk
            (Dict.withCapacity 13)
            (\state, c -> state |> Dict.update c updateCardNums)

    numOfJokers =
        d |> Dict.get CardJ |> Result.withDefault 0

    typeValue =
        when d |> Dict.values |> List.sortDesc is
            [5] ->
                7 # Five of a kind

            [a, _] ->
                # either 4 1 or 3 2
                if numOfJokers > 0 then
                    7 # Five of a kind
                else if a == 4 then
                    6 # Four of a kind
                else
                    5 # Full house

            [a, _, _] ->
                # either 3 1 1 or 2 2 1
                when numOfJokers is
                    3 ->
                        6 # Four of a kind

                    2 ->
                        6 # Four of a kind

                    1 ->
                        if a == 3 then
                            6 # Four of a kind
                        else
                            5 # Full house

                    _ ->
                        if a == 3 then
                            4 # Three of a kind
                        else
                            3 # Two pair

            [_, _, _, _] ->
                # 2 1 1 1
                if numOfJokers > 0 then
                    4 # Three of a kind
                else
                    2 # One pair

            [_, _, _, _, _] ->
                # all cards are different
                if numOfJokers > 0 then
                    2 # One pair
                else
                    1 # High card

            _ -> crash "bad hand"

    cardValue = \c ->
        when c is
            CardA -> 13
            CardK -> 12
            CardQ -> 11
            CardT -> 10
            Card9 -> 9
            Card8 -> 8
            Card7 -> 7
            Card6 -> 6
            Card5 -> 5
            Card4 -> 4
            Card3 -> 3
            Card2 -> 2
            CardJ -> 1

    cardsValue =
        cards
        |> List.walk
            0
            (\state, c -> (state * 20) + cardValue c)

    (typeValue * 10000000) + cardsValue

exampleData2 =
    exampleData1

expect
    got = solvePart2 exampleData2
    got == "5905"
