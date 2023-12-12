interface Solution.Day10
    exposes [
        part1,
        part2,
    ]
    imports [
        "Day10.input" as puzzleInput : Str,
        parser.String.{ parseStr, string },
        parser.Core.{ sepBy, many, oneOf, map },
    ]

part1 =
    solvePart1 puzzleInput

solvePart1 = \input ->
    pipes = input |> Str.trim |> parsePuzzleInput

    startNode = getStartNode pipes

    nextNode = getNextNode pipes startNode

    way = walkNodes pipes (Node Start startNode) nextNode 1

    way // 2 |> Num.toStr

parsePuzzleInput = \input ->
    when parseStr puzzleParser input is
        Ok v -> v
        Err _ -> crash "parsing failed"

puzzleParser =
    mapLineParser |> sepBy (string "\n")

mapLineParser =
    many
        (
            oneOf [
                (string "|" |> map (\_ -> Vertical)),
                (string "-" |> map (\_ -> Horizontal)),
                (string "L" |> map (\_ -> CornerNE)),
                (string "J" |> map (\_ -> CornerNW)),
                (string "7" |> map (\_ -> CornerSW)),
                (string "F" |> map (\_ -> CornerSE)),
                (string "." |> map (\_ -> Ground)),
                (string "S" |> map (\_ -> Start)),
            ]
        )

getStartNode = \pipes ->
    pipes
    |> List.walkUntil
        (1, 1)
        (\(lineIndex, _), line ->
            res =
                line
                |> List.walkUntil
                    1
                    (\colIndex, element ->
                        when element is
                            Start -> Break colIndex
                            _ -> Continue (colIndex + 1)
                    )
            if res <= List.len line then
                Break (lineIndex, res)
            else
                Continue (lineIndex + 1, 1)
        )

getNextNode = \pipes, (startLine, startCol) ->
    southernNode = getNode pipes (startLine + 1, startCol)
    when southernNode is
        Node e _ ->
            if [Vertical, CornerNE, CornerNW] |> List.contains e then
                southernNode
            else
                crash "We implement only a connection to south ... if your puzzle input is not like this, you have to add the respective code."

getNode = \pipes, (nodeLine, nodeCol) ->
    res1 =
        pipes
        |> List.walkUntil
            (State1 Ground 1)
            (\State1 _ lineIndex, line ->
                if lineIndex == nodeLine then
                    res2 =
                        line
                        |> List.walkUntil
                            (State2 Ground 1)
                            (\State2 _ colIndex, element ->
                                if colIndex == nodeCol then
                                    Break (State2 element 0)
                                else
                                    Continue (State2 Ground (colIndex + 1))
                            )
                    when res2 is
                        State2 e2 _ ->
                            Break (State1 e2 0)
                else
                    Continue (State1 Ground (lineIndex + 1))
            )
    when res1 is
        State1 e1 _ -> Node e1 (nodeLine, nodeCol)

walkNodes = \pipes, Node _ (line1, col1), Node node2 (line2, col2), index ->
    next =
        when node2 is
            Vertical ->
                if line1 < line2 then
                    getNode pipes (line2 + 1, col2)
                else
                    getNode pipes (line2 - 1, col2)

            Horizontal ->
                if col1 < col2 then
                    getNode pipes (line2, col2 + 1)
                else
                    getNode pipes (line2, col2 - 1)

            CornerNE ->
                if line1 < line2 then
                    getNode pipes (line2, col2 + 1)
                else
                    getNode pipes (line2 - 1, col2)

            CornerNW ->
                if line1 < line2 then
                    getNode pipes (line2, col2 - 1)
                else
                    getNode pipes (line2 - 1, col2)

            CornerSW ->
                if col1 < col2 then
                    getNode pipes (line2 + 1, col2)
                else
                    getNode pipes (line2, col2 - 1)

            CornerSE ->
                if col2 < col1 then
                    getNode pipes (line2 + 1, col2)
                else
                    getNode pipes (line2, col2 + 1)

            Start ->
                Node node2 (line2, col2)

            Ground ->
                crash "pipe was broken"

    when next is
        Node e _ ->
            if e == Start then
                index + 1
            else
                walkNodes pipes (Node node2 (line2, col2)) next (index + 1)

exampleData1 =
    """
    7-F7-
    .FJ|7
    SJLL7
    |F--J
    LJ.LJ
    """

expect
    got = solvePart1 exampleData1
    got == "8"

part2 =
    solvePart2 puzzleInput

solvePart2 = \_input ->
    "no solution found yet"

# exampleData2 =
#     """
#     """

# expect
#     got = solvePart2 exampleData2
#     got == ""