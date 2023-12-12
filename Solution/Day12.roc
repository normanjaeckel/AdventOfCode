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
    walk line.springs line.dmgInfo NoRequiredSpring
    |> (\l ->
        List.len l
    )

walk = \springs, dmgInfo, requiredSpring ->
    when springs is
        [] ->
            if dmgInfo |> List.isEmpty then
                [""]
            else
                # The walk leads to an invalid state. The springs line is empty but still have unparsed damaged springs.
                []

        [s, .. as rest] ->
            when s is
                OperationalSpring ->
                    when requiredSpring is
                        DamagedSpringRequired ->
                            # The walk leads to an invalid state, because we have to have a damaged spring here but gut an operational.
                            []

                        OperationalSpringRequired | NoRequiredSpring ->
                            walk rest dmgInfo NoRequiredSpring
                            |> List.map (\st -> ".\(st)")

                DamagedSpring ->
                    when requiredSpring is
                        OperationalSpringRequired ->
                            # The walk leads to an invalid state, because we have to have an operational spring here but gut a damaged.
                            []

                        DamagedSpringRequired | NoRequiredSpring ->
                            when dmgInfo |> List.first is
                                Err _ ->
                                    # The walk leads to an invalid state because the dmgInfo list is empty but we have a damaged spring here.
                                    []

                                Ok first ->
                                    if first == 1 then
                                        walk rest (dmgInfo |> List.dropFirst 1) OperationalSpringRequired
                                        |> List.map (\st -> "#\(st)")
                                    else
                                        walk rest (dmgInfo |> List.update 0 (\elem -> elem - 1)) DamagedSpringRequired
                                        |> List.map (\st -> "#\(st)")

                UnknownState ->
                    case1 = walk (rest |> List.prepend OperationalSpring) dmgInfo requiredSpring
                    case2 = walk (rest |> List.prepend DamagedSpring) dmgInfo requiredSpring

                    List.concat case1 case2

expect
    got = walk [OperationalSpring, OperationalSpring] [] NoRequiredSpring |> List.len
    got == 1

expect
    got = walk [OperationalSpring, DamagedSpring] [1] NoRequiredSpring |> List.len
    got == 1

expect
    got = walk [OperationalSpring, OperationalSpring] [2] NoRequiredSpring |> List.len
    got == 0

expect
    got = walk [OperationalSpring, DamagedSpring] [1, 2] NoRequiredSpring |> List.len
    got == 0

expect
    got = walk [OperationalSpring, DamagedSpring, OperationalSpring, DamagedSpring, DamagedSpring] [1, 2] NoRequiredSpring |> List.len
    got == 1

expect
    got = walk [OperationalSpring, DamagedSpring, OperationalSpring, DamagedSpring, DamagedSpring] [1, 1] NoRequiredSpring |> List.len
    got == 0

expect
    got = walk [UnknownState] [1] NoRequiredSpring |> List.len
    got == 1

expect
    got = walk [UnknownState, UnknownState] [1] NoRequiredSpring |> List.len
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
    |> List.walkWithIndex
        []
        (\state, line, index ->
            dbg index
            state |> List.append (calcLineVariants line)
        )
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
