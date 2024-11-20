interface Solution.Day12
    exposes [
        part1,
        part2,
    ]
    imports [
        "Day12.input" as puzzleInput : Str,
        parser.String.{ parseStr, string, codeunit, digits },
        parser.Core.{ const, keep, skip, sepBy, many, oneOf, map },
    ]

part1 =
    solvePart1 puzzleInput

solvePart1 = \input ->
    input
    |> Str.trim
    |> parsePuzzleInput
    |> List.map calcLineVariants
    |> List.sum
    |> Num.toStr

parsePuzzleInput = \input ->
    when parseStr puzzleParser input is
        Ok v -> v
        Err _ -> crash "parsing failed"

puzzleParser =
    lineParser |> sepBy (string "\n")

lineParser =
    const (\springs -> \dmgInfo -> { springs, dmgInfo })
    |> keep springParser
    |> skip (string " ")
    |> keep dmgInfoParser

springParser =
    many
        (
            oneOf [
                (codeunit '.' |> map (\_ -> OperationalSpring)),
                (codeunit '#' |> map (\_ -> DamagedSpring)),
                (codeunit '?' |> map (\_ -> UnknownState)),
            ]
        )

dmgInfoParser =
    digits |> sepBy (string ",")

calcLineVariants = \line ->
    walk line.springs [Variant line.dmgInfo NoRequiredSpring 1]

walk = \springs, variants ->
    when springs is
        [] ->
            variants
            |> List.walk
                0
                (\state, Variant dmgInfo _requirement weight ->
                    if dmgInfo |> List.isEmpty then
                        # Good case: springs is empty an dmgInfo is empty. Return weight value
                        state + weight
                    else
                        # The walk leads to an invalid state. The springs line is empty but still have unparsed damaged springs.
                        state + 0
                )

        [s, .. as rest] ->
            newVariants =
                when s is
                    OperationalSpring ->
                        variants
                        |> List.walk
                            []
                            (\state, Variant dmgInfo requirement weight ->
                                when requirement is
                                    DamagedSpringRequired ->
                                        # The walk leads to an invalid state, because we have to have a damaged spring here but gut an operational.
                                        state

                                    OperationalSpringRequired | NoRequiredSpring ->
                                        state |> List.append (Variant dmgInfo NoRequiredSpring weight)
                            )

                    DamagedSpring ->
                        variants
                        |> List.walk
                            []
                            (\state, Variant dmgInfo requirement weight ->
                                when requirement is
                                    OperationalSpringRequired ->
                                        # The walk leads to an invalid state, because we have to have an operational spring here but gut a damaged.
                                        state

                                    DamagedSpringRequired | NoRequiredSpring ->
                                        when dmgInfo |> List.first is
                                            Err _ ->
                                                # The walk leads to an invalid state because the dmgInfo list is empty but we have a damaged spring here.
                                                state

                                            Ok first ->
                                                if first == 1 then
                                                    state |> List.append (Variant (dmgInfo |> List.dropFirst 1) OperationalSpringRequired weight)
                                                else
                                                    state
                                                    |> List.append
                                                        (
                                                            Variant
                                                                (dmgInfo |> List.update 0 (\elem -> elem - 1))
                                                                DamagedSpringRequired
                                                                weight
                                                        )
                            )

                    UnknownState ->
                        variants
                        |> List.walk
                            []
                            (\state, Variant dmgInfo requirement weight ->
                                # Assume OperationalSpring and add Variant to state or discard it.
                                # Then assume DamagedSpring and so on.
                                when requirement is
                                    OperationalSpringRequired ->
                                        state |> List.append (Variant dmgInfo NoRequiredSpring weight)

                                    DamagedSpringRequired ->
                                        # Copied code ...
                                        when dmgInfo |> List.first is
                                            Err _ ->
                                                # The walk leads to an invalid state because the dmgInfo list is empty but we have a damaged spring here.
                                                state

                                            Ok first ->
                                                if first == 1 then
                                                    state |> List.append (Variant (dmgInfo |> List.dropFirst 1) OperationalSpringRequired weight)
                                                else
                                                    state
                                                    |> List.append
                                                        (
                                                            Variant
                                                                (dmgInfo |> List.update 0 (\elem -> elem - 1))
                                                                DamagedSpringRequired
                                                                weight
                                                        )

                                    NoRequiredSpring ->
                                        case1 = Variant dmgInfo NoRequiredSpring weight # Assume OperationalSpring
                                        case2 = # Assume DamagedSpring
                                            # Copied code ...
                                            when dmgInfo |> List.first is
                                                Err _ ->
                                                    # The walk leads to an invalid state because the dmgInfo list is empty but we have a damaged spring here.
                                                    []

                                                Ok first ->
                                                    if first == 1 then
                                                        [Variant (dmgInfo |> List.dropFirst 1) OperationalSpringRequired weight]
                                                    else
                                                        [Variant (dmgInfo |> List.update 0 (\elem -> elem - 1)) DamagedSpringRequired weight]

                                        state |> List.append case1 |> List.concat case2
                            )

            walk rest (newVariants |> reduceDuplicats)

reduceDuplicats = \variants ->
    reduceDuplicatsHelper variants []

reduceDuplicatsHelper = \l, result ->
    when l is
        [first, .. as rest] ->
            rest
            |> List.walk
                (first, [])
                (\(state, newRest), element ->
                    if compareVariants element first then
                        (combineVariants state element, newRest)
                    else
                        (state, newRest |> List.append element)
                )
            |> (\(ready, newRest) ->
                reduceDuplicatsHelper newRest (result |> List.append ready)
            )

        [] -> result

compareVariants = \Variant dmgInfo1 requirement1 _, Variant dmgInfo2 requirement2 _ ->
    (dmgInfo1, requirement1) == (dmgInfo2, requirement2)

combineVariants = \Variant dmgInfo1 requirement1 weight1, Variant _ _ weight2 ->
    Variant dmgInfo1 requirement1 (weight1 + weight2)

# reducerWalk = \l ->
#     when l is
#         [Variant dmgInfo1 requirement1 weight1, Variant dmgInfo2 requirement2 weight2, .. as rest] ->
#             if (dmgInfo1, requirement1) == (dmgInfo2, requirement2) then
#                 new = combine (Variant dmgInfo1 requirement1 weight1) (Variant dmgInfo2 requirement2 weight2)
#                 reducerWalk (rest |> List.prepend new)
#             else
#                 reducerWalk (rest |> List.prepend (Variant dmgInfo2 requirement2 weight2)) |> List.prepend (Variant dmgInfo2 requirement2 weight2)

#         [_, ..] -> l
#         [] -> l

expect
    got = walk [OperationalSpring, OperationalSpring] [Variant [] NoRequiredSpring 1]
    got == 1

expect
    got = walk [OperationalSpring, DamagedSpring] [Variant [1] NoRequiredSpring 1]
    got == 1

expect
    got = walk [OperationalSpring, OperationalSpring] [Variant [2] NoRequiredSpring 1]
    got == 0

expect
    got = walk [OperationalSpring, DamagedSpring] [Variant [1, 2] NoRequiredSpring 1]
    got == 0

expect
    got = walk [OperationalSpring, DamagedSpring, OperationalSpring, DamagedSpring, DamagedSpring] [Variant [1, 2] NoRequiredSpring 1]
    got == 1

expect
    got = walk [OperationalSpring, DamagedSpring, OperationalSpring, DamagedSpring, DamagedSpring] [Variant [1, 1] NoRequiredSpring 1]
    got == 0

expect
    got = walk [UnknownState] [Variant [1] NoRequiredSpring 1]
    got == 1

expect
    got = walk [UnknownState, UnknownState] [Variant [1] NoRequiredSpring 1]
    got == 2

expect
    got = solvePart1 "?###???????? 3,2,1"
    got == "10"

exampleData1 =
    """
    ???.### 1,1,3
    .??..??...?##. 1,1,3
    ?#?#?#?#?#?#?#? 1,3,1,6
    ????.#...#... 4,1,1
    ????.######..#####. 1,6,5
    ?###???????? 3,2,1
    """

expect
    got = solvePart1 exampleData1
    got == "21"

part2 =
    solvePart2 puzzleInput

solvePart2 = \input ->
    input
    |> Str.trim
    |> parsePuzzleInput
    |> List.map unfoldCondictionRecords
    |> List.map calcLineVariants
    |> List.sum
    |> Num.toStr

exampleData2 =
    exampleData1

unfoldCondictionRecords = \line ->
    springs = List.join [
        line.springs,
        [UnknownState],
        line.springs,
        [UnknownState],
        line.springs,
        [UnknownState],
        line.springs,
        [UnknownState],
        line.springs,
    ]

    dmgInfo = List.join [
        line.dmgInfo,
        line.dmgInfo,
        line.dmgInfo,
        line.dmgInfo,
        line.dmgInfo,
    ]

    { springs, dmgInfo }

expect
    got = parsePuzzleInput "???.### 1,1,3" |> List.map unfoldCondictionRecords
    got
    == [
        {
            springs: [
                UnknownState,
                UnknownState,
                UnknownState,
                OperationalSpring,
                DamagedSpring,
                DamagedSpring,
                DamagedSpring,
                UnknownState,
                UnknownState,
                UnknownState,
                UnknownState,
                OperationalSpring,
                DamagedSpring,
                DamagedSpring,
                DamagedSpring,
                UnknownState,
                UnknownState,
                UnknownState,
                UnknownState,
                OperationalSpring,
                DamagedSpring,
                DamagedSpring,
                DamagedSpring,
                UnknownState,
                UnknownState,
                UnknownState,
                UnknownState,
                OperationalSpring,
                DamagedSpring,
                DamagedSpring,
                DamagedSpring,
                UnknownState,
                UnknownState,
                UnknownState,
                UnknownState,
                OperationalSpring,
                DamagedSpring,
                DamagedSpring,
                DamagedSpring,
            ],
            dmgInfo: [1, 1, 3, 1, 1, 3, 1, 1, 3, 1, 1, 3, 1, 1, 3],
        },
    ]

expect
    got = solvePart2 exampleData2
    got == "525152"
