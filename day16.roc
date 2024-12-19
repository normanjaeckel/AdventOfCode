app [part1, part2] {
    pf: platform "https://github.com/ostcar/roc-aoc-platform/releases/download/v0.0.8/lhFfiil7mQXDOB6wN-jduJQImoT8qRmoiNHDB4DVF9s.tar.br",
    parser: "https://github.com/lukewilliamboswell/roc-parser/releases/download/0.9.0/w8YKp2YAgQt5REYk912HfKAHBjcXsrnvtjI0CBzoAT4.tar.br",
}

import parser.Parser exposing [Parser, flatten, many, map, oneOf, sepBy]
import parser.String exposing [parseStr, string]

example : Str
example =
    """
    ###############
    #.......#....E#
    #.#.###.#.###.#
    #.....#.#...#.#
    #.###.#####.#.#
    #.#.#.......#.#
    #.#.#####.###.#
    #...........#.#
    ###.#.#####.#.#
    #...#.....#.#.#
    #.#.#.###.#.#.#
    #.....#...#.#.#
    #.###.#.#.#.#.#
    #S..#.....#...#
    ###############
    """

expect
    got = part1 example
    expected = Ok "7036"
    got == expected

part1 : Str -> Result Str [ParsingFailure Str, ParsingIncomplete Str, ShortestPathNotFound]
part1 = \rawInput ->
    parseStr puzzleParser (rawInput |> Str.trim)
    |> Result.try
        \mazeMap ->
            mazeMap
            |> toMazeMapGraph
            |> shortestPath? mazeMap
            |> Num.toStr
            |> Ok

MazeMap : { positions : Dict Position Field, maxRowIndex : U64, maxColIndex : U64, start : Position, end : Position }
Position : { row : U64, col : U64 }
Field : [Wall, Start, End, Empty]
Direction : [North, South, West, East]
Node : { position : Position, direction : Direction }
MazeMapGraph : List (Node, List (Node, U64))

puzzleParser : Parser (List U8) MazeMap
puzzleParser =
    lineParser
    |> sepBy (string "\n")
    |> map toMazeMap
    |> flatten

lineParser : Parser (List U8) (List Field)
lineParser =
    many
        (
            oneOf [
                string "#" |> map \_ -> Wall,
                string "." |> map \_ -> Empty,
                string "S" |> map \_ -> Start,
                string "E" |> map \_ -> End,
            ]
        )

toMazeMap : List (List Field) -> Result MazeMap Str
toMazeMap = \rows ->
    result =
        rows
        |> List.walkWithIndex
            { positions: Dict.empty {}, start: { row: 0, col: 0 }, end: { row: 0, col: 0 }, maxRowIndex: 0, maxColIndex: 0 }
            \state, row, rowIndex ->
                row
                |> List.walkWithIndex
                    state
                    \innerState, field, colIndex ->
                        pos = { row: rowIndex, col: colIndex }
                        newInnerState =
                            when field is
                                Start -> { innerState & start: pos }
                                End -> { innerState & end: pos }
                                Wall | Empty -> innerState
                        { newInnerState & positions: innerState.positions |> Dict.insert pos field }
    maxRowIndex = List.len rows - 1
    rows
    |> List.first
    |> Result.map \row -> List.len row - 1 |> \maxColIndex -> { result & maxRowIndex: maxRowIndex, maxColIndex: maxColIndex }
    |> Result.mapErr \_ -> "Invalid input"

rotatePoints = 1000
movePoints = 1

toMazeMapGraph : MazeMap -> MazeMapGraph
toMazeMapGraph = \mazeMap ->
    nodes =
        mazeMap.positions
        |> Dict.walk
            []
            \acc, pos, field ->
                if isANode mazeMap pos field then
                    acc |> List.append pos
                else
                    acc
        |> List.map \position ->
            [North, West, South, East] |> List.map \direction -> { position, direction }
        |> List.join

    nodes |> List.map \node -> (node, node |> getNeighbours mazeMap nodes)

isANode : MazeMap, Position, Field -> Bool
isANode = \mazeMap, { row, col }, field ->
    when field is
        Wall -> Bool.false
        Start | End -> Bool.true
        Empty ->
            north = mazeMap.positions |> Dict.get { row: row - 1, col } |> Result.withDefault Wall
            south = mazeMap.positions |> Dict.get { row: row + 1, col } |> Result.withDefault Wall
            west = mazeMap.positions |> Dict.get { row, col: col - 1 } |> Result.withDefault Wall
            east = mazeMap.positions |> Dict.get { row, col: col + 1 } |> Result.withDefault Wall
            if (north != Wall) || (south != Wall) then
                (west != Wall) || (east != Wall)
            else if (west != Wall) || (east != Wall) then
                (north != Wall) || (south != Wall)
            else
                Bool.false

getNeighbours : Node, MazeMap, List Node -> List (Node, U64)
getNeighbours = \node, mazeMap, nodes ->
    straight = getNeighboursHelper mazeMap node.position node.direction nodes 0
    neighbours =
        when straight is
            Err DeadEnd -> []
            Ok n -> [n]
    nodes
    |> List.keepIf \n -> n.position == node.position
    |> List.dropIf \n -> n == node
    |> List.walk
        neighbours
        \acc, other ->
            if node.direction == opposite other.direction then
                acc |> List.append (other, 0)
            else
                acc |> List.append (other, rotatePoints)

opposite : Direction -> Direction
opposite = \direction ->
    when direction is
        North -> South
        South -> North
        West -> East
        East -> West

getNeighboursHelper : MazeMap, Position, Direction, List Node, U64 -> Result (Node, U64) [DeadEnd]
getNeighboursHelper = \mazeMap, { row, col }, dir, nodes, len ->
    next =
        when dir is
            North -> { position: { row: row - 1, col }, direction: South }
            South -> { position: { row: row + 1, col }, direction: North }
            West -> { position: { row, col: col - 1 }, direction: East }
            East -> { position: { row, col: col + 1 }, direction: West }
    if nodes |> List.contains next then
        Ok (next, len + movePoints)
    else
        when mazeMap.positions |> Dict.get next.position |> Result.withDefault Wall is
            Wall -> Err DeadEnd
            Start | End | Empty -> getNeighboursHelper mazeMap next.position dir nodes (len + movePoints)

shortestPath : MazeMapGraph, MazeMap -> Result U64 [ShortestPathNotFound]
shortestPath = \graph, mazeMap ->
    initialDistance = Dict.single { position: mazeMap.start, direction: East } 0
    end = [North, South, East, West] |> List.map \direction -> { position: mazeMap.end, direction }
    result = dijkstraHelper graph end initialDistance (Dict.empty {})
    result |> Result.mapErr \_err -> ShortestPathNotFound

dijkstraHelper :
    MazeMapGraph,
    List Node,
    Dict Node U64,
    Dict Node Node
    -> Result U64 [KeyNotFound, SmallestNotFound, PathToEndtailNotFound]
dijkstraHelper = \graph, end, distances, ancestors ->
    if List.isEmpty graph then
        Err PathToEndtailNotFound
        else

    (node, dist, neighbours, newGraph) = getSmallest? graph distances
    if end |> List.contains node then
        Ok dist
        else

    neighbours
    |> List.walk
        { distances, ancestors }
        \state, (n, d) ->
            updateRequired =
                when state.distances |> Dict.get n is
                    Err KeyNotFound -> Bool.true
                    Ok current -> current > (dist + d)
            if updateRequired then
                { state &
                    distances: state.distances |> Dict.insert n (dist + d),
                    ancestors: state.ancestors |> Dict.insert n node,
                }
            else
                state
    |> \state ->
        dijkstraHelper newGraph end state.distances state.ancestors

getSmallest : MazeMapGraph, Dict Node U64 -> Result (Node, U64, List (Node, U64), MazeMapGraph) [SmallestNotFound]
getSmallest = \graph, distances ->
    initialState = {
        smallest: Err SmallestNotFound,
        newGraph: [],
    }
    graph
    |> List.walk initialState \state, (node, neighbours) ->
        when distances |> Dict.get node is
            Err KeyNotFound -> { state & newGraph: state.newGraph |> List.append (node, neighbours) }
            Ok dist ->
                when state.smallest is
                    Err SmallestNotFound -> { state & smallest: Ok (node, dist, neighbours) }
                    Ok (stateNode, stateDistance, stateNeighbours) ->
                        if dist < stateDistance then
                            { state &
                                smallest: Ok (node, dist, neighbours),
                                newGraph: state.newGraph |> List.append (stateNode, stateNeighbours),
                            }
                        else
                            { state & newGraph: state.newGraph |> List.append (node, neighbours) }
    |> \state ->
        when state.smallest is
            Err SmallestNotFound -> Err SmallestNotFound
            Ok value -> Ok (value.0, value.1, value.2, state.newGraph)

expect
    got = part2 example
    expected = Ok ""
    got == expected

part2 : Str -> Result Str [ParsingFailure Str, ParsingIncomplete Str]
part2 = \rawInput ->
    parseStr puzzleParser (rawInput |> Str.trim)
    |> Result.map
        \_input ->
            ""
