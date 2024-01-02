interface Solution.Day21
    exposes [
        part1,
        part2,
    ]
    imports [
        "Day21.input" as puzzleInput : Str,
        parser.String.{ parseStr, string },
        parser.Core.{ sepBy, oneOrMore, oneOf, map },
    ]

part1 =
    solvePart1 puzzleInput 64

solvePart1 = \input, steps ->
    garden = input |> Str.trim |> parsePuzzleInput

    (numOfRows, numofCols) = getDimensions garden
    start = findStart garden

    walkGarden { garden, numOfRows, numofCols } steps (Set.single start)
    |> Set.len
    |> Num.toStr

parsePuzzleInput = \input ->
    when parseStr puzzleParser input is
        Ok v -> v
        Err _ -> crash "parsing failed"

puzzleParser =
    lineParser |> sepBy (string "\n")

lineParser =
    oneOrMore
        (
            oneOf [
                string "S" |> map \_ -> Start,
                string "." |> map \_ -> GardenPlot,
                string "#" |> map \_ -> Rock,
            ]
        )

getDimensions = \garden ->
    rows = List.len garden
    cols =
        when garden |> List.first is
            Err ListWasEmpty -> crash "bad garden"
            Ok row -> List.len row
    (rows, cols)

findStart = \garden ->
    garden
    |> List.walkWithIndex
        NotFound
        \state, row, rowIndex ->
            when state is
                Found _ -> state
                NotFound ->
                    row
                    |> List.walkWithIndex
                        NotFound
                        \state2, col, colIndex ->
                            when state2 is
                                Found _ -> state2
                                NotFound ->
                                    when col is
                                        Start -> Found (rowIndex, colIndex)
                                        _ -> NotFound
    |> \finalState ->
        when finalState is
            NotFound -> crash "not start found"
            Found v -> v

walkGarden = \garden, steps, reached ->
    if steps == 0 then
        reached
    else
        newSteps = steps - 1

        newReached =
            reached
            |> Set.walk
                (Set.empty {})
                \state, (row, col) ->
                    state |> Set.union (getNextElements garden row col)

        walkGarden garden newSteps newReached

getNextElements = \garden, row, col ->
    positions =
        if row == 0 then
            if col == 0 then
                [(row + 1, col), (row, col + 1)]
            else if col == garden.numofCols - 1 then
                [(row + 1, col), (row, col - 1)]
            else
                [(row + 1, col), (row, col + 1), (row, col - 1)]
        else if row == garden.numOfRows - 1 then
            if col == 0 then
                [(row - 1, col), (row, col + 1)]
            else if col == garden.numofCols - 1 then
                [(row - 1, col), (row, col - 1)]
            else
                [(row - 1, col), (row, col + 1), (row, col - 1)]
        else if col == 0 then
            [(row + 1, col), (row - 1, col), (row, col + 1)]
        else if col == garden.numofCols - 1 then
            [(row + 1, col), (row - 1, col), (row, col - 1)]
        else
            [(row + 1, col), (row - 1, col), (row, col + 1), (row, col - 1)]

    positions
    |> List.keepIf
        \(r, c) ->
            when getType garden.garden r c is
                GardenPlot | Start -> Bool.true
                Rock -> Bool.false
    |> Set.fromList

getType = \garden, row, col ->
    when garden |> List.get row |> Result.try (\r -> r |> List.get col) is
        Err _ -> crash "bad garden"
        Ok v -> v

exampleData1 =
    """
    ...........
    .....###.#.
    .###.##..#.
    ..#.#...#..
    ....#.#....
    .##..S####.
    .##..#...#.
    .......##..
    .##.#.####.
    .##..##.##.
    ...........
    """

expect
    got = solvePart1 exampleData1 6
    got == "16"

part2 =
    solvePart2 puzzleInput

solvePart2 = \_input ->
    # TODO: Solution is still missing.
    ""

exampleData2 =
    """
    """

expect
    got = solvePart2 exampleData2
    got == ""
