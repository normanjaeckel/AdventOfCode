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

solvePart2 = \input ->
    trails = input |> Str.trim |> parsePuzzleInput
    numOfRows = List.len trails
    numOfCols =
        when trails |> List.first is
            Err ListWasEmpty -> crash "invalid trails"
            Ok r -> List.len r
    start = (0, 1)
    goal = (numOfRows - 1, numOfCols - 2)

    trailPositions = getTrailPositions trails numOfRows numOfCols

    crossings = getCrossings trailPositions start goal

    nodes = getNodes trailPositions crossings

    walkThroughNodes nodes goal [start] 0 0
    |> Num.toStr

TrailPositions : List Position
Crossings : List (Position, List Direction)
Nodes : Dict Position (List (Direction, Nat, Direction, Position))

getTrailPositions : Trails, Nat, Nat -> TrailPositions
getTrailPositions = \trailPositions, numOfRows, numOfCols ->
    trailPositions
    |> List.walkWithIndex
        (List.withCapacity (numOfRows * numOfCols))
        \state, line, rowIndex ->
            line
            |> List.walkWithIndex
                state
                \innerState, shape, colIndex ->
                    when shape is
                        Path | Slope _ -> innerState |> List.append (rowIndex, colIndex)
                        Forest -> innerState

getCrossings : TrailPositions, Position, Position -> Crossings
getCrossings = \trailPositions, start, goal ->
    trailPositions
    |> List.walk
        [(start, List.single South), (goal, List.single North)]
        \state, position ->
            if position == start || position == goal then
                # Skip start and goal, we already have them in initial state
                state
            else
                neighbours = getNeighbours trailPositions position
                l = List.len neighbours
                if l == 3 || l == 4 then
                    state |> List.append (position, neighbours)
                else if l == 1 || l == 2 then
                    # One neighbour is for start and goal. This can be ignores.
                    # Two neighbour is a normal path and not a crossing.
                    state
                else
                    crash "position with zero or more than four neighbours is impossible"

getNeighbours : TrailPositions, Position -> List Direction
getNeighbours = \trailPositions, (row, col) ->
    north = if trailPositions |> List.contains (row - 1, col) then [North] else []
    south = if trailPositions |> List.contains (row + 1, col) then [South] else []
    west = if trailPositions |> List.contains (row, col - 1) then [West] else []
    east = if trailPositions |> List.contains (row, col + 1) then [East] else []
    List.join [north, south, west, east]

getNodes : TrailPositions, Crossings -> Nodes
getNodes = \trailPositions, crossings ->
    crossings
    |> List.walk
        (Dict.withCapacity (List.len crossings))
        \state, (position, directions) ->
            paths =
                directions
                |> List.map
                    \direction ->
                        (num, dir, dest) =
                            when weAlreadyFoundAPath state position direction is
                                Ok found ->
                                    found

                                Err NoPathFound ->
                                    findPath trailPositions crossings position direction
                        (direction, num, dir, dest)
            state |> Dict.insert position paths

weAlreadyFoundAPath : Nodes, Position, Direction -> Result (Nat, Direction, Position) [NoPathFound]
weAlreadyFoundAPath = \nodes, position, direction ->
    nodes
    |> Dict.toList
    |> List.walkUntil
        NotFound
        \state, (pos, list) ->
            when
                list
                |> List.findFirst
                    \(_dir1, _num, dir2, dest) ->
                        dir2 == direction && dest == position
            is
                Err NotFound -> Continue state
                Ok (dir1, num, _dir2, _dest) -> Break (Found (num, dir1, pos))
    |> \res ->
        when res is
            NotFound -> Err NoPathFound
            Found found -> Ok found

findPath : TrailPositions, Crossings, Position, Direction -> (Nat, Direction, Position)
findPath = \trailPositions, crossings, (row, col), direction ->
    next =
        when direction is
            North -> (row - 1, col)
            South -> (row + 1, col)
            West -> (row, col - 1)
            East -> (row, col + 1)
    findPathHelper trailPositions crossings [(row, col), next]

findPathHelper : TrailPositions, Crossings, List Position -> (Nat, Direction, Position)
findPathHelper = \trailPositions, crossings, path ->
    currentPosition =
        when List.last path is
            Err ListWasEmpty -> crash "paths must not be empty"
            Ok l -> l
    (row, col) = currentPosition

    (nextRow, nextCol) =
        trailPositions
        |> List.findFirst
            \trailPosition ->
                if path |> List.contains trailPosition then
                    Bool.false
                else
                    currentPosition |> isNeighbourOf trailPosition
        |> \res ->
            when res is
                Err NotFound ->
                    crash "bad path finding: there is no next step here"

                Ok next -> next

    if crossings |> List.any \(c, _) -> c == (nextRow, nextCol) then
        directionAtCrossing =
            if row < nextRow then
                North
            else if row > nextRow then
                South
            else if col < nextCol then
                West
            else if col > nextCol then
                East
            else
                crash "impossible"
        (List.len path, directionAtCrossing, (nextRow, nextCol))
    else
        findPathHelper trailPositions crossings (path |> List.append (nextRow, nextCol))

isNeighbourOf : Position, Position -> Bool
isNeighbourOf = \(r1, c1), (r2, c2) ->
    if r1 == r2 then
        c1 - 1 == c2 || c1 + 1 == c2
    else if c1 == c2 then
        r1 - 1 == r2 || r1 + 1 == r2
    else
        Bool.false

walkThroughNodes : Nodes, Position, List Position, Nat, Nat -> Nat
walkThroughNodes = \nodes, goal, path, currentWeight, bestWeight ->
    dbg (path, bestWeight)
    last =
        when path |> List.last is
            Err ListWasEmpty -> crash "empty path is impossible"
            Ok l -> l
    neighbours =
        when nodes |> Dict.get last is
            Err KeyNotFound -> crash "node not found"
            Ok found -> found

    neighbours
    |> List.walk
        bestWeight
        \state, (_dir1, weight, _dir2, neighbour) ->
            if path |> List.contains neighbour then
                state
            else
                newWeight = currentWeight + weight
                if neighbour == goal then
                    Num.max state newWeight
                else
                    walkThroughNodes nodes goal (path |> List.append neighbour) newWeight state

exampleData2 =
    exampleData1

expect
    got = solvePart2 exampleData2
    got == "154"
