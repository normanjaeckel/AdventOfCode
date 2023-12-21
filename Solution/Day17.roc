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

    startQueue = [Crucible 0 0 OnStart 0]
    visited = [] |> List.reserve (numOfRows * numOfCols)

    walkThroughHelper { map: cityMap, rows: numOfRows, cols: numOfCols } startQueue visited

walkThroughHelper = \city, queue, visited ->

    (Crucible row col directionRestriction heat, newQueue) = getSmallestFrom queue

    if row == (city.rows - 1) && col == (city.cols - 1) then
        heat
    else
        (nextElements, newVisited) =
            if visited |> List.contains (row, col, directionRestriction) then
                ([], visited)
            else
                nextElements1 =
                    when directionRestriction is
                        OnStart -> List.concat (part1NextDirsOnVertical city 0 0 0) (part1NextDirsOnHorizontal city 0 0 0)
                        Vertical -> part1NextDirsOnVertical city heat row col
                        Horizontal -> part1NextDirsOnHorizontal city heat row col

                (nextElements1, visited |> List.append (row, col, directionRestriction))

        walkThroughHelper city (newQueue |> List.concat nextElements) newVisited

getSmallestFrom = \queue ->
    queue
    |> List.walk
        ([], Nothing)
        (\(newQueue, found), element1 ->
            when found is
                Nothing ->
                    (newQueue, Found element1)

                Found element2 ->
                    if compareCrucibles element1 element2 then
                        (newQueue |> List.append element1, Found element2)
                    else
                        (newQueue |> List.append element2, Found element1)
        )
    |> (\(newQueue, found) ->
        when found is
            Nothing -> crash "queue is empty "
            Found element ->
                (element, newQueue)
    )

compareCrucibles = \Crucible _ _ _ heat1, Crucible _ _ _ heat2 ->
    heat1 >= heat2

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
    |> (\(list, _) -> list)

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
    |> (\(list, _) -> list)

subtractionAtMostUntilZero = \a, b ->
    if a <= b then
        0
    else
        a - b

getHeatAtBlock = \city, row, col ->
    when city.map |> List.get row |> Result.try (\line -> line |> List.get col) is
        Err _ -> crash "bad city"
        Ok heat -> heat

# getSmallestFrom2 = \queue ->
#     sorted =
#         queue
#         |> List.sortWith
#             (\Crucible _ _ _ heat1, Crucible _ _ _ heat2 ->
#                 Num.compare heat1 heat2
#             )

#     when sorted is
#         [] ->
#             crash "queue is empty"

#         [first, .. as rest] ->
#             (first, rest)

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
