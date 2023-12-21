interface Solution.Day18
    exposes [
        part1,
        part2,
    ]
    imports [
        "Day18.input" as puzzleInput : Str,
        parser.String.{ parseStr, string, digits, codeunit },
        parser.Core.{ const, sepBy, keep, skip, oneOf, many, map },
    ]

part1 =
    solvePart1 puzzleInput

solvePart1 = \input ->
    steps = input |> Str.trim |> parsePuzzleInput
    lagoon = drawEdgeOfLagoon steps
    (minX, minY) = getMinXYFor lagoon
    (maxX, maxY) = getMaxXYFor lagoon
    dbg (minX, maxX, minY, maxY, ((maxX - minX + 1) * (maxY - minY + 1)))
    fillArea { minX, minY, maxX, maxY, lagoon }
    |> (\n -> ((maxX - minX + 1) * (maxY - minY + 1)) - (Num.toI64 n) + (List.len lagoon |> Num.toI64))
    |> Num.toStr

parsePuzzleInput = \input ->
    when parseStr puzzleParser input is
        Ok v -> v
        Err _ -> crash "parsing failed"

puzzleParser =
    lineParser |> sepBy (string "\n")

lineParser =
    const (\direction -> \length -> \color -> { direction, length, color })
    |> keep directionParser
    |> skip (string " ")
    |> keep digits
    |> skip (string " ")
    |> keep colorParser

directionParser =
    oneOf [
        codeunit 'R' |> map (\_ -> Right),
        codeunit 'D' |> map (\_ -> Down),
        codeunit 'L' |> map (\_ -> Left),
        codeunit 'U' |> map (\_ -> Up),
    ]

colorParser =
    const (\h -> h)
    |> skip (string "(#")
    |> keep hexParser
    |> skip (string ")")

hexParser =
    many
        (
            oneOf [
                codeunit '0' |> map (\_ -> 0),
                codeunit '1' |> map (\_ -> 1),
                codeunit '2' |> map (\_ -> 2),
                codeunit '3' |> map (\_ -> 3),
                codeunit '4' |> map (\_ -> 4),
                codeunit '5' |> map (\_ -> 5),
                codeunit '6' |> map (\_ -> 6),
                codeunit '7' |> map (\_ -> 7),
                codeunit '8' |> map (\_ -> 8),
                codeunit '9' |> map (\_ -> 9),
                codeunit 'a' |> map (\_ -> 10),
                codeunit 'b' |> map (\_ -> 11),
                codeunit 'c' |> map (\_ -> 12),
                codeunit 'd' |> map (\_ -> 13),
                codeunit 'e' |> map (\_ -> 14),
                codeunit 'f' |> map (\_ -> 15),
            ]
        )

drawEdgeOfLagoon = \steps ->
    steps
    |> List.walk
        ([], (0, 0))
        (\(lagoon, (x, y)), step ->
            (dx, dy) =
                when step.direction is
                    Right -> (0, 1)
                    Down -> (1, 0)
                    Left -> (0, -1)
                    Up -> (-1, 0)
            new =
                List.range { start: At 1, end: Length step.length }
                |> List.map
                    (\n ->
                        (x + (dx * n), y + (dy * n))
                    )
            (lagoon |> List.concat new, new |> List.last |> Result.withDefault (0, 0))
        )
    |> (\(lagoon, _) -> lagoon)

getMinXYFor = \lagoon ->
    lagoon
    |> List.walk
        (0, 0)
        (\(i, j), (x, y) ->
            (Num.min i x, Num.min j y)
        )
    |> (\(x, y) -> (x - 1, y - 1))

getMaxXYFor = \lagoon ->
    lagoon
    |> List.walk
        (0, 0)
        (\(i, j), (x, y) ->
            (Num.max i x, Num.max j y)
        )
    |> (\(x, y) -> (x + 1, y + 1))

fillArea = \board ->
    startPos = (board.minX, board.minY)
    visited = board.lagoon
    fillAreaHelper board [startPos] visited

fillAreaHelper = \board, currentPositions, visited ->
    dbg (List.len visited)
    if List.isEmpty currentPositions then
        List.len visited
    else
        newVisited = visited |> List.concat currentPositions
        nextPositions =
            currentPositions
            |> List.walk
                []
                (\state, (x, y) ->
                    [(x + 1, y), (x - 1, y), (x, y + 1), (x, y - 1)]
                    |> List.dropIf
                        (\(i, j) ->
                            (i < board.minX)
                            || (i > board.maxX)
                            || (j < board.minY)
                            || (j > board.maxY)
                            || (newVisited |> List.contains (i, j))
                            || (state |> List.contains (i, j))
                        )
                    |> (\l -> state |> List.concat l)
                )

        fillAreaHelper board nextPositions newVisited

exampleData1 =
    """
    R 6 (#70c710)
    D 5 (#0dc571)
    L 2 (#5713f0)
    D 2 (#d2c081)
    R 2 (#59c680)
    D 2 (#411b91)
    L 5 (#8ceee2)
    U 2 (#caa173)
    L 1 (#1b58a2)
    U 2 (#caa171)
    R 2 (#7807d2)
    U 3 (#a77fa3)
    L 2 (#015232)
    U 2 (#7a21e3)
    """

expect
    got = solvePart1 exampleData1
    got == "62"

part2 =
    solvePart2 puzzleInput

solvePart2 = \_input ->
    ""

exampleData2 =
    """
    """

# #######
# #.....#
# ###...#
# ..#...#
# ..#...#
# ###.###
# #...#..
# ##..###
# .#....#
# .######

expect
    got = solvePart2 exampleData2
    got == ""
