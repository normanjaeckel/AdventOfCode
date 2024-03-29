interface Solution.Day14
    exposes [
        part1,
        part2,
    ]
    imports [
        "Day14.input" as puzzleInput : Str,
        parser.String.{ parseStr, string, codeunit },
        parser.Core.{ many, oneOf, sepBy, map },
    ]

part1 =
    solvePart1 puzzleInput

solvePart1 = \input ->
    input
    |> Str.trim
    |> parsePuzzleInput
    |> rotateAndInvert
    |> tiltPlatformToWest
    |> calcLoad
    |> Num.toStr

parsePuzzleInput = \input ->
    when parseStr puzzleParser input is
        Ok v -> v
        Err _ -> crash "parsing failed"

puzzleParser =
    lineParser |> sepBy (string "\n")

lineParser =
    many
        (
            oneOf [
                codeunit 'O' |> map (\_ -> Sphere),
                codeunit '#' |> map (\_ -> Block),
                codeunit '.' |> map (\_ -> Space),
            ]
        )

rotateAndInvert = \platform ->
    rotateAndInvertHelper platform []

rotateAndInvertHelper = \lines, result ->
    lines
    |> List.walk
        (State [] [])
        (\State state1 state2, line ->
            when line is
                [first, .. as rest] ->
                    State (state1 |> List.append first) (state2 |> List.append rest)

                [] ->
                    State state1 state2
        )
    |> (\State newRow rest ->
        if List.isEmpty newRow then
            result
        else
            rotateAndInvertHelper rest (result |> List.append newRow)
    )

tiltPlatformToWest = \platform ->
    platform
    |> List.map
        (\line ->
            tiltLineHelper line []
        )

tiltLineHelper = \line, result ->
    if List.isEmpty line then
        result
    else
        when line |> List.splitFirst Block is
            Err _ ->
                result |> List.concat (tiltPart line)

            Ok { before, after } ->
                r = result |> List.concat (tiltPart before) |> List.append Block
                tiltLineHelper after r

tiltPart = \line ->
    total = List.len line
    spheres = line |> List.countIf (\element -> element == Sphere)
    spaces = total - spheres

    List.repeat Sphere spheres
    |> List.concat (List.repeat Space spaces)

calcLoad = \platform ->
    platform
    |> List.map
        (\line ->
            l = List.len line

            line
            |> List.walkWithIndex
                0
                (\state, element, index ->
                    if element == Sphere then
                        state + (l - index)
                    else
                        state
                )
        )
    |> List.sum

exampleData1 =
    """
    O....#....
    O.OO#....#
    .....##...
    OO.#O....O
    .O.....O#.
    O.#..O.#.#
    ..O..#O..O
    .......O..
    #....###..
    #OO..#....
    """

rotated =
    """
    OO.O.O..##
    ...OO....O
    .O...#O..O
    .O.#......
    .#.O......
    #.#..O#.##
    ..#...O.#.
    ....O#.O#.
    ....#.....
    .#.O.#O...
    """

expect
    got = exampleData1 |> parsePuzzleInput |> rotateAndInvert
    got == rotated |> parsePuzzleInput

expect
    got = solvePart1 exampleData1
    got == "136"

part2 =
    solvePart2 puzzleInput

offset =
    120

calcLoad2 = \platform ->
    platform |> rotateAndInvert |> calcLoad

solvePart2 = \input ->
    input
    |> Str.trim
    |> parsePuzzleInput
    |> checkForRepetition
    |> calcLoad2
    |> Num.toStr

exampleData2 =
    exampleData1

expect
    got = solvePart2 exampleData2
    got == "64"

preparePlatform = \platform ->
    platform
    |> List.map
        (\line -> List.reverse line)

runOneCyle = \platform ->
    platform
    |> rotateAndInvert
    |> tiltPlatformToWest
    |> List.reverse
    |> rotateAndInvert
    |> tiltPlatformToWest
    |> List.reverse
    |> rotateAndInvert
    |> tiltPlatformToWest
    |> List.reverse
    |> rotateAndInvert
    |> tiltPlatformToWest
    |> List.reverse

runNCyles = \platform, n ->
    if n == 0 then
        platform
    else
        platform
        |> runOneCyle
        |> runNCyles (n - 1)

expect
    afterOneCyle =
        """
        .....#....
        ....#...O#
        ...OO##...
        .OO#......
        .....OOO#.
        .O#...O#.#
        ....O#....
        ......OOOO
        #...O###..
        #..OO#....
        """
    got = exampleData1 |> parsePuzzleInput |> preparePlatform |> runOneCyle |> preparePlatform
    got == afterOneCyle |> parsePuzzleInput

expect
    afterTwoCycles =
        """
        .....#....
        ....#...O#
        .....##...
        ..O#......
        .....OOO#.
        .O#...O#.#
        ....O#...O
        .......OOO
        #..OO###..
        #.OOO#...O
        """
    got = exampleData1 |> parsePuzzleInput |> preparePlatform |> runNCyles 2 |> preparePlatform
    got == afterTwoCycles |> parsePuzzleInput

expect
    afterThreeCycles =
        """
        .....#....
        ....#...O#
        .....##...
        ..O#......
        .....OOO#.
        .O#...O#.#
        ....O#...O
        .......OOO
        #...O###.O
        #.OOO#...O
        """
    got = exampleData1 |> parsePuzzleInput |> preparePlatform |> runNCyles 3 |> preparePlatform
    got == afterThreeCycles |> parsePuzzleInput

checkForRepetition = \platform ->
    p2 =
        platform
        |> preparePlatform
        |> runNCyles offset
        |> preparePlatform

    n = calcLoad2 p2

    List.range { start: At 1, end: Length 100 }
    |> List.walkUntil
        (p2 |> preparePlatform)
        \state, i ->
            newState = state |> runOneCyle
            if newState |> preparePlatform |> calcLoad2 == n then
                rest = (1_000_000_000 - offset) % i
                Break (newState |> runNCyles (rest))
            else
                Continue newState
    |> preparePlatform
