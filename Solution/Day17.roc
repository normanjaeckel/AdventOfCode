interface Solution.Day17
    exposes [
        part1,
        part2,
    ]
    imports [
        "Day17.input" as puzzleInput : Str,
        parser.String.{ parseStr, digit, string },
        parser.Core.{ sepBy, many },
    ]

part1 =
    solvePart1 puzzleInput

solvePart1 = \input ->
    city = input |> Str.trim |> parsePuzzleInput

    walkThrough city
    |> Num.toStr

parsePuzzleInput = \input ->
    when parseStr puzzleParser input is
        Ok v -> v
        Err _ -> crash "parsing failed"

puzzleParser =
    lineParser |> sepBy (string "\n")

lineParser =
    many digit

walkThrough = \cityMap ->
    numOfRows = List.len cityMap
    numOfCols =
        when cityMap |> List.first is
            Err _ -> crash "bad city input"
            Ok l -> List.len l

    startQueueA = [Crucible 0 0 OnStart 0] |> List.reserve 10000
    startQueueB = [0] |> List.reserve 10000
    visited = Set.withCapacity (numOfRows * numOfCols)

    walkThroughHelper { map: cityMap, rows: numOfRows, cols: numOfCols } startQueueA startQueueB visited

walkThroughHelper = \city, queueA, queueB, visited ->
    (Crucible row col directionRestriction heat, newQueueA, newQueueB) = getSmallestFrom queueA queueB

    if row == (city.rows - 1) && col == (city.cols - 1) then
        heat
    else
        (nextElementsA, nextElementsB, newVisited) =
            if visited |> Set.contains (row, col, directionRestriction) then
                ([], [], visited)
            else
                (nextElA, nextElB) =
                    when directionRestriction is
                        OnStart ->
                            (vA, vB) = part1NextDirsOnVertical city 0 0 0
                            (hA, hB) = part1NextDirsOnHorizontal city 0 0 0
                            (List.concat vA hA, List.concat vB hB)

                        Vertical -> part1NextDirsOnVertical city heat row col
                        Horizontal -> part1NextDirsOnHorizontal city heat row col

                (nextElA, nextElB, visited |> Set.insert (row, col, directionRestriction))

        walkThroughHelper city (newQueueA |> List.concat nextElementsA) (newQueueB |> List.concat nextElementsB) newVisited

getSmallestFrom = \queueA, queueB ->
    min =
        when queueB |> List.min is
            Ok m -> m
            Err ListWasEmpty -> crash "queue is empty"
    idx =
        when queueB |> List.findFirstIndex \h -> h == min is
            Ok i -> i
            Err NotFound -> crash "missing element in queue B"
    smallest =
        when queueA |> List.get idx is
            Ok c -> c
            Err OutOfBounds -> crash "missing element in queue A"
    { before: beforeA, others: othersA } = queueA |> List.split idx
    { before: beforeB, others: othersB } = queueB |> List.split idx
    newQueueA = beforeA |> List.concat (othersA |> List.dropFirst 1)
    newQueueB = beforeB |> List.concat (othersB |> List.dropFirst 1)
    (smallest, newQueueA, newQueueB)

# queue
# |> List.walk
#     ([], Nothing)
#     (\(newQueue, found), element1 ->
#         when found is
#             Nothing ->
#                 (newQueue, Found element1)

#             Found element2 ->
#                 if compareCrucibles element1 element2 then
#                     (newQueue |> List.append element1, Found element2)
#                 else
#                     (newQueue |> List.append element2, Found element1)
#     )
# |> (\(newQueue, found) ->
#     when found is
#         Nothing -> crash "queue is empty "
#         Found element ->
#             (element, newQueue)
# )

# compareCrucibles = \Crucible _ _ _ heat1, Crucible _ _ _ heat2 ->
#     heat1 >= heat2

part1NextDirsOnVertical = \city, heat, row, col ->
    (res1, _) =
        List.range { start: After col, end: At (Num.min (col + 3) (city.cols - 1)) }
        |> List.walk
            (List.withCapacity 6, heat)
            (\(state, currentHeat), newValue ->
                heatAtBlock = getHeatAtBlock city row newValue
                newHeat = currentHeat + heatAtBlock
                (state |> List.append (Crucible row newValue Horizontal newHeat), newHeat)
            )

    List.range { start: At (subtractionAtMostUntilZero col 3), end: Before col }
    |> List.reverse
    |> List.walk
        (res1, heat)
        (\(state, currentHeat), newValue ->
            heatAtBlock = getHeatAtBlock city row newValue
            newHeat = currentHeat + heatAtBlock
            (state |> List.append (Crucible row newValue Horizontal newHeat), newHeat)
        )
    |> (\(resultA, _) ->
        resultB = resultA |> List.map \Crucible _ _ _ h -> h
        (resultA, resultB)
    )

part1NextDirsOnHorizontal = \city, heat, row, col ->
    (res1, _) =
        List.range { start: After row, end: At (Num.min (row + 3) (city.rows - 1)) }
        |> List.walk
            (List.withCapacity 6, heat)
            (\(state, currentHeat), newValue ->
                heatAtBlock = getHeatAtBlock city newValue col
                newHeat = currentHeat + heatAtBlock
                (state |> List.append (Crucible newValue col Vertical newHeat), newHeat)
            )

    List.range { start: At (subtractionAtMostUntilZero row 3), end: Before row }
    |> List.reverse
    |> List.walk
        (res1, heat)
        (\(state, currentHeat), newValue ->
            heatAtBlock = getHeatAtBlock city newValue col
            newHeat = currentHeat + heatAtBlock
            (state |> List.append (Crucible newValue col Vertical newHeat), newHeat)
        )
    |> (\(resultA, _) ->
        resultB = resultA |> List.map \Crucible _ _ _ h -> h
        (resultA, resultB)
    )
subtractionAtMostUntilZero = \a, b ->
    if a <= b then
        0
    else
        a - b

getHeatAtBlock = \city, row, col ->
    when city.map |> List.get row |> Result.try (\line -> line |> List.get col) is
        Err _ -> crash "bad city"
        Ok heat -> heat

exampleData1 =
    """
    2413432311323
    3215453535623
    3255245654254
    3446585845452
    4546657867536
    1438598798454
    4457876987766
    3637877979653
    4654967986887
    4564679986453
    1224686865563
    2546548887735
    4322674655533
    """

expect
    got = solvePart1 exampleData1
    got == "102"

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
