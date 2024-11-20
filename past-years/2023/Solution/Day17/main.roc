app "advent-of-code-2023"
    packages {
        pf: "https://github.com/roc-lang/basic-cli/releases/download/0.7.1/Icc3xJoIixF3hCcfXrDwLCu4wQHtNdPyoJkEbkgIElA.tar.br",
        parser: "https://github.com/lukewilliamboswell/roc-parser/releases/download/0.4/yrk4tKd0w9oaxt0s66zrejc6L67Y7B-86BQrL9yjZMY.tar.br",
    }
    imports [
        "Day17.input" as puzzleInput : Str,
        pf.Stdout,
        pf.Task,
        parser.String.{ parseStr, string, digit },
        parser.Core.{ sepBy, many },
    ]
    provides [main] to pf

main =
    _ <- Stdout.line "Solution for part 1: \(part1)" |> Task.await
    Stdout.line "Solution for part 2: \(part2)"

part1 =
    solvePart puzzleInput Part1

solvePart = \input, part ->
    city = input |> Str.trim |> parsePuzzleInput

    walkThrough city part
    |> Num.toStr

parsePuzzleInput = \input ->
    when parseStr puzzleParser input is
        Ok v -> v
        Err _ -> crash "parsing failed"

puzzleParser =
    lineParser |> sepBy (string "\n")

lineParser =
    many digit

walkThrough = \cityMap, part ->
    numOfRows = List.len cityMap
    numOfCols =
        when cityMap |> List.first is
            Err _ -> crash "bad city input"
            Ok l -> List.len l

    startQueueA = [Crucible 0 0 OnStart 0] |> List.reserve 10000
    startQueueB = [0] |> List.reserve 10000
    visited = List.withCapacity 2_000_000

    walkThroughHelper { map: cityMap, rows: numOfRows, cols: numOfCols, part: part } startQueueA startQueueB visited

walkThroughHelper = \city, queueA, queueB, visited ->
    (Crucible row col directionRestriction heat, newQueueA, newQueueB) = getSmallestFrom queueA queueB

    if row == (city.rows - 1) && col == (city.cols - 1) then
        heat
    else if visited |> List.contains (row, col, directionRestriction) then
        walkThroughHelper city newQueueA newQueueB visited
    else
        (nextElementsA, nextElementsB) =
            when directionRestriction is
                OnStart ->
                    (vA, vB) = part1NextDirsOnVertical city 0 0 0
                    (hA, hB) = part1NextDirsOnHorizontal city 0 0 0
                    (List.concat vA hA, List.concat vB hB)

                Vertical -> part1NextDirsOnVertical city heat row col
                Horizontal -> part1NextDirsOnHorizontal city heat row col

        walkThroughHelper city (newQueueA |> List.concat nextElementsA) (newQueueB |> List.concat nextElementsB) (visited |> List.append (row, col, directionRestriction))

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

part1NextDirsOnVertical = \city, heat, row, col ->
    (minSteps, maxSteps) =
        when city.part is
            Part1 -> (1, 3)
            Part2 -> (4, 10)

    (res1, _) =
        List.range { start: After col, end: At (Num.min (col + maxSteps) (city.cols - 1)) }
        |> List.walkWithIndex
            (List.withCapacity 20, heat)
            (\(state, currentHeat), newValue, index ->
                heatAtBlock = getHeatAtBlock city row newValue
                newHeat = currentHeat + heatAtBlock
                if index + 1 < minSteps then
                    (state, newHeat)
                else
                    (state |> List.append (Crucible row newValue Horizontal newHeat), newHeat)
            )

    List.range { start: At (subtractionAtMostUntilZero col maxSteps), end: Before col }
    |> List.reverse
    |> List.walkWithIndex
        (res1, heat)
        (\(state, currentHeat), newValue, index ->
            heatAtBlock = getHeatAtBlock city row newValue
            newHeat = currentHeat + heatAtBlock
            if index + 1 < minSteps then
                (state, newHeat)
            else
                (state |> List.append (Crucible row newValue Horizontal newHeat), newHeat)
        )
    |> (\(resultA, _) ->
        resultB = resultA |> List.map \Crucible _ _ _ h -> h
        (resultA, resultB)
    )

part1NextDirsOnHorizontal = \city, heat, row, col ->
    (minSteps, maxSteps) =
        when city.part is
            Part1 -> (1, 3)
            Part2 -> (4, 10)

    (res1, _) =
        List.range { start: After row, end: At (Num.min (row + maxSteps) (city.rows - 1)) }
        |> List.walkWithIndex
            (List.withCapacity 6, heat)
            (\(state, currentHeat), newValue, index ->
                heatAtBlock = getHeatAtBlock city newValue col
                newHeat = currentHeat + heatAtBlock
                if index + 1 < minSteps then
                    (state, newHeat)
                else
                    (state |> List.append (Crucible newValue col Vertical newHeat), newHeat)
            )

    List.range { start: At (subtractionAtMostUntilZero row maxSteps), end: Before row }
    |> List.reverse
    |> List.walkWithIndex
        (res1, heat)
        (\(state, currentHeat), newValue, index ->
            heatAtBlock = getHeatAtBlock city newValue col
            newHeat = currentHeat + heatAtBlock
            if index + 1 < minSteps then
                (state, newHeat)
            else
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
    got = solvePart exampleData1 Part1
    got == "102"

part2 =
    solvePart puzzleInput Part2

exampleData2 =
    exampleData1

expect
    got = solvePart exampleData2 Part2
    got == "94"

expect
    input =
        """
        111111111111
        999999999991
        999999999991
        999999999991
        999999999991
        """
    got = solvePart input Part2
    got == "71"
