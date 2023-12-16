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

    way = walkNodes pipes (Node Start startNode) nextNode [Node Start startNode]

    (List.len way) // 2 |> Num.toStr

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
        (\(rowIndex, _), row ->
            res =
                row
                |> List.walkUntil
                    1
                    (\colIndex, element ->
                        when element is
                            Start -> Break colIndex
                            _ -> Continue (colIndex + 1)
                    )
            if res <= List.len row then
                Break (rowIndex, res)
            else
                Continue (rowIndex + 1, 1)
        )

getNextNode = \pipes, (startRow, startCol) ->
    southernNode = getNode pipes (startRow + 1, startCol)
    when southernNode is
        Node e _ ->
            if [Vertical, CornerNE, CornerNW] |> List.contains e then
                southernNode
            else
                crash "I implement only a connection to south ... if your puzzle input is not like this, you have to add the respective code here. Good luck."

getNode = \pipes, (nodeRow, nodeCol) ->
    res1 =
        pipes
        |> List.walkUntil
            (State1 Ground 1)
            (\State1 _ rowIndex, row ->
                if rowIndex == nodeRow then
                    res2 =
                        row
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
                    Continue (State1 Ground (rowIndex + 1))
            )
    when res1 is
        State1 e1 _ -> Node e1 (nodeRow, nodeCol)

walkNodes = \pipes, Node _ (row1, col1), Node node2 (row2, col2), result ->
    next =
        when node2 is
            Vertical ->
                if row1 < row2 then
                    getNode pipes (row2 + 1, col2)
                else
                    getNode pipes (row2 - 1, col2)

            Horizontal ->
                if col1 < col2 then
                    getNode pipes (row2, col2 + 1)
                else
                    getNode pipes (row2, col2 - 1)

            CornerNE ->
                if row1 < row2 then
                    getNode pipes (row2, col2 + 1)
                else
                    getNode pipes (row2 - 1, col2)

            CornerNW ->
                if row1 < row2 then
                    getNode pipes (row2, col2 - 1)
                else
                    getNode pipes (row2 - 1, col2)

            CornerSW ->
                if col1 < col2 then
                    getNode pipes (row2 + 1, col2)
                else
                    getNode pipes (row2, col2 - 1)

            CornerSE ->
                if col2 < col1 then
                    getNode pipes (row2 + 1, col2)
                else
                    getNode pipes (row2, col2 + 1)

            Start ->
                Node node2 (row2, col2)

            Ground ->
                crash "pipe was broken"

    when next is
        Node e _ ->
            if e == Start then
                result |> List.append (Node node2 (row2, col2))
            else
                walkNodes pipes (Node node2 (row2, col2)) next (result |> List.append (Node node2 (row2, col2)))

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

solvePart2 = \input ->
    pipes = input |> Str.trim |> parsePuzzleInput

    startNode = getStartNode pipes

    nextNode = getNextNode pipes startNode

    (way, typeOnStart) = walkNodes pipes (Node Start startNode) nextNode [Node Start startNode] |> modifyWay

    pipes
    |> List.mapWithIndex (\line, rowIndex -> countInLine line (rowIndex + 1) way typeOnStart)
    |> List.sum
    |> Num.toStr

modifyWay = \way ->
    (Node _ (startNodeRow, startNodeCol)) =
        when way |> List.first is
            Err _ -> crash "way must not be empty"
            Ok s -> s

    (Node _ (lastNodeRow, lastNodeCol)) =
        when way |> List.last is
            Err _ -> crash "way must not be emtpy"
            Ok l -> l

    # We assume that the second element is southern, see the getNextNode function.
    # So we just check the last element and make | or 7 or F

    element =
        if startNodeRow == lastNodeRow then
            if startNodeCol < lastNodeCol then
                CornerSE
            else
                CornerSW
        else
            Vertical

    (way |> List.set 0 (Node element (startNodeRow, startNodeCol)), element)

countInLine = \line, rowIndex, way, typeOnStart ->
    line
    |> List.walkWithIndex
        (Out, 0)
        (\(status, count), nodeRaw, colIndex ->
            node =
                when nodeRaw is
                    Start -> typeOnStart
                    _ -> nodeRaw
            if way |> List.contains (Node node (rowIndex, colIndex + 1)) then
                when status is
                    Out ->
                        when node is
                            Vertical -> (In, count)
                            CornerNE -> (Riding CounterClockwise, count)
                            CornerSE -> (Riding Clockwise, count)
                            _ -> crash "impossible 1"

                    In ->
                        when node is
                            Vertical -> (Out, count)
                            CornerNE -> (Riding Clockwise, count)
                            CornerSE -> (Riding CounterClockwise, count)
                            _ -> crash "impossible 2"

                    Riding Clockwise ->
                        when node is
                            Horizontal -> (Riding Clockwise, count)
                            CornerNW -> (In, count)
                            CornerSW -> (Out, count)
                            _ -> crash "impossible 3"

                    Riding CounterClockwise ->
                        when node is
                            Horizontal -> (Riding CounterClockwise, count)
                            CornerNW -> (Out, count)
                            CornerSW -> (In, count)
                            _ -> crash "impossible 4"
            else
                when status is
                    Out -> (Out, count)
                    In -> (In, count + 1)
                    Riding Clockwise -> (Out, count)
                    Riding CounterClockwise -> (In, count + 1)
        )
    |> (\(_, count) -> count)

exampleData2 =
    exampleData1

expect
    got = solvePart2 exampleData2
    got == "1"

exampleData3 =
    """
    FF7FSF7F7F7F7F7F---7
    L|LJ||||||||||||F--J
    FL-7LJLJ||||||LJL-77
    F--JF--7||LJLJ7F7FJ-
    L---JF-JLJ.||-FJLJJ7
    |F|F-JF---7F7-L7L|7|
    |FFJF7L7F-JF7|JL---7
    7-L-JL7||F7|L7F-7F7|
    L.L7LFJ|||||FJL7||LJ
    L7JLJL-JLJLJL--JLJ.L
    """

expect
    got = solvePart2 exampleData3
    got == "10"
