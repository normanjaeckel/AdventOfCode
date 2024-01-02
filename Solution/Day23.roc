interface Solution.Day23
    exposes [
        part1,
        part2,
    ]
    imports [
        "Day23.input" as puzzleInput : Str,
        parser.String.{ parseStr, string },
        parser.Core.{ sepBy, oneOrMore, oneOf, map },
    ]

part1 =
    solvePart1 puzzleInput

solvePart1 = \input ->
    trails = input |> Str.trim |> parsePuzzleInput
    numOfRows = List.len trails
    numOfCols =
        when trails |> List.first is
            Err ListWasEmpty -> crash "invalid trails"
            Ok r -> List.len r
    start = (0, 1)
    goal = (numOfRows - 1, numOfCols - 2)

    walkThroughTrails trails goal [[start]] 0
    |> Num.toStr

Trails : List (List Shape)
Shape : [Path, Forest, Slope Direction]
Direction : [East, West, North, South]
Position : (Nat, Nat)

parsePuzzleInput : Str -> Trails
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
                string "." |> map \_ -> Path,
                string "#" |> map \_ -> Forest,
                string ">" |> map \_ -> Slope East,
                string "<" |> map \_ -> Slope West,
                string "^" |> map \_ -> Slope North,
                string "v" |> map \_ -> Slope South,
            ]
        )

walkThroughTrails : Trails, Position, List (List Position), Nat -> Nat
walkThroughTrails = \trails, goal, paths, result ->
    if List.isEmpty paths then
        result
    else
        paths
        |> List.walk
            ([], result)
            \(newPaths, newResult), path ->
                nextSteps = getNextSteps trails path
                if nextSteps |> List.contains goal then
                    # We ignore all other next steps because they can not reach the goal any more. The field before goal is blocked.
                    (newPaths, Num.max newResult (List.len path))
                else
                    (
                        newPaths |> List.concat (nextSteps |> List.map \n -> path |> List.append n),
                        newResult,
                    )
        |> \(finalNewPaths, finalNewResult) ->
            walkThroughTrails trails goal finalNewPaths finalNewResult

getNextSteps : Trails, List Position -> List Position
getNextSteps = \trails, path ->
    (row, col) =
        when path |> List.last is
            Err ListWasEmpty -> crash "path must not be empty"
            Ok p -> p
    if row == 0 then
        # We are at the start. just go south and don't check anything else
        [(1, 1)]
    else
        possibleNext = [(row + 1, col), (row - 1, col), (row, col + 1), (row, col - 1)]
        possibleNext
        |> List.dropIf \p -> path |> List.contains p
        |> List.keepIf
            \(r, c) ->
                when getShape trails (r, c) is
                    Path -> Bool.true
                    Forest -> Bool.false
                    Slope direction ->
                        when direction is
                            North -> r < row
                            South -> r > row
                            West -> c < col
                            East -> c > col

getShape : Trails, Position -> Shape
getShape = \trails, (row, col) ->
    when trails |> List.get row is
        Err OutOfBounds -> crash "shape not found in trail (bad row)"
        Ok l ->
            when l |> List.get col is
                Err OutOfBounds -> crash "shape not found in trail (bad col)"
                Ok shape -> shape

expect
    trails =
        """
        #.###
        #...#
        ###.#
        """
    got = solvePart1 trails
    got == "4"

exampleData1 =
    """
    #.#####################
    #.......#########...###
    #######.#########.#.###
    ###.....#.>.>.###.#.###
    ###v#####.#v#.###.#.###
    ###.>...#.#.#.....#...#
    ###v###.#.#.#########.#
    ###...#.#.#.......#...#
    #####.#.#.#######.#.###
    #.....#.#.#.......#...#
    #.#####.#.#.#########v#
    #.#...#...#...###...>.#
    #.#.#v#######v###.###v#
    #...#.>.#...>.>.#.###.#
    #####v#.#.###v#.#.###.#
    #.....#...#...#.#.#...#
    #.#########.###.#.#.###
    #...###...#...#...#.###
    ###.###.#.###v#####v###
    #...#...#.#.>.>.#.>.###
    #.###.###.#.###.#.#v###
    #.....###...###...#...#
    #####################.#
    """

expect
    got = solvePart1 exampleData1
    got == "94"

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
