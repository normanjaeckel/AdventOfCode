interface Solution.Day11
    exposes [
        part1,
        part2,
    ]
    imports [
        "Day11.input" as puzzleInput : Str,
    ]

part1 =
    solvePart1 puzzleInput

solvePart1 = \input ->
    rows = input |> Str.split "\n" |> List.len
    cols = input |> Str.split "\n" |> List.first |> Result.try (\r -> r |> Str.toUtf8 |> List.len |> Ok) |> Result.withDefault 0

    galaxies = input |> Str.trim |> parsePuzzleInput
    (emptyRows, emptyCols) = getEmptyRowsAndCols galaxies rows cols

    extendedGalaxies = getExtendedGalaxies galaxies emptyRows emptyCols

    getDistances extendedGalaxies
    |> Num.toStr

parsePuzzleInput = \input ->
    input
    |> Str.split "\n"
    |> List.walkWithIndex
        []
        (\state1, row, index1 ->
            row
            |> Str.toUtf8
            |> List.walkWithIndex
                []
                (\state2, col, index2 ->
                    if col == '#' then
                        state2 |> List.append (index1, index2)
                    else
                        state2
                )
            |> (\s -> state1 |> List.concat s)
        )

getEmptyRowsAndCols = \galaxies, rows, cols ->
    r = List.range { start: At 0, end: Before rows } |> Set.fromList
    c = List.range { start: At 0, end: Before cols } |> Set.fromList

    galaxies
    |> List.walk
        (r, c)
        (\(stateR, stateC), (galaxyR, galaxyC) ->
            (stateR |> Set.remove galaxyR, stateC |> Set.remove galaxyC)
        )

getExtendedGalaxies = \galaxies, emptyRows, emptyCols ->
    galaxies
    |> List.map
        (\(rowG, colG) ->
            x =
                emptyRows
                |> Set.walk
                    0
                    (\state, emptyRow ->
                        if emptyRow < rowG then
                            state + 1
                        else
                            state
                    )
            y =
                emptyCols
                |> Set.walk
                    0
                    (\state, emptyCol ->
                        if emptyCol < colG then
                            state + 1
                        else
                            state
                    )
            (rowG + x, colG + y)
        )

getDistances = \galaxies ->
    galaxies
    |> List.walk
        0
        (\state1, (x1, y1) ->
            galaxies
            |> List.walk
                0
                (\state2, (x2, y2) ->
                    x = if x2 > x1 then x2 - x1 else x1 - x2
                    y = if y2 > y1 then y2 - y1 else y1 - y2
                    state2 + x + y
                )
            |> (\s -> state1 + s)
        )
    |> (\s -> s // 2)

exampleData1 =
    """
    ...#......
    .......#..
    #.........
    ..........
    ......#...
    .#........
    .........#
    ..........
    .......#..
    #...#.....
    """

expect
    got = solvePart1 exampleData1
    got == "374"

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
