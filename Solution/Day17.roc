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
            Err _ -> crash "bad city input        "
            Ok l -> List.len l

    start = [Crucible 0 0 [] 0]
    visited = [] |> List.reserve (numOfRows * numOfCols)

    walkThroughHelper { map: cityMap, rows: numOfRows, cols: numOfCols } start visited

walkThroughHelper = \city, queue, visited ->
    (Crucible row col forbiddenDirections heat, newQueue) = getSmallestFrom queue

    newVisited = visited |> List.append (Crucible row col forbiddenDirections heat)

    if row == (city.rows - 1) && col == (city.cols - 1) then
        heat
    else
        [North, East, South, West]
        |> List.dropIf
            (\direction -> forbiddenDirections |> List.contains direction)
        |> List.walk
            []
            (\state, direction ->
                List.range { start: At 1, end: At 3 }
                |> List.walk
                    (state, heat)
                    (\(innerState, extraHeat), steps ->
                        when getBlock city direction row col steps is
                            Err _ ->
                                (innerState, extraHeat)

                            Ok (newRow, newCol, heatAtBlock) ->
                                newForbiddenDirections =
                                    when direction is
                                        North -> [North, South]
                                        South -> [North, South]
                                        West -> [West, East]
                                        East -> [West, East]
                                newHeat = heatAtBlock + extraHeat
                                (innerState |> List.append (Crucible newRow newCol newForbiddenDirections newHeat), newHeat)
                    )
                |> (\(nextElements, _) ->
                    state |> List.concat nextElements
                )
            )
        |> List.dropIf
            (\Crucible row1 col1 forbiddenDirections1 h1 ->
                newVisited
                |> List.any
                    (\Crucible vRow vCol vForbiddenDirections _ ->
                        vRow == row1 && vCol == col1 && vForbiddenDirections == forbiddenDirections1
                    )
            )
        |> (\nextElements ->
            walkThroughHelper city (newQueue |> List.concat nextElements) newVisited
        )

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

getBlock = \city, direction, row, col, steps ->
    new =
        when direction is
            North ->
                if row >= steps then
                    Ok (row - steps, col)
                else
                    Err OutOfCity

            South ->
                if row + steps < city.rows then
                    Ok (row + steps, col)
                else
                    Err OutOfCity

            West ->
                if col >= steps then
                    Ok (row, col - steps)
                else
                    Err OutOfCity

            East ->
                if col + steps < city.cols then
                    Ok (row, col + steps)
                else
                    Err OutOfCity

    new
    |> Result.try
        (\(newRow, newCol) ->
            city.map
            |> List.get newRow
            |> Result.try
                (
                    \line -> line |> List.get newCol
                )
            |> Result.try
                (
                    \heat -> Ok (newRow, newCol, heat)
                )
        )

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
