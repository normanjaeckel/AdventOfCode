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
            |> .distance
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
                        when field is
                            Start -> { innerState & positions: innerState.positions |> Dict.insert pos field, start: pos }
                            End -> { innerState & positions: innerState.positions |> Dict.insert pos field, end: pos }
                            Empty -> { innerState & positions: innerState.positions |> Dict.insert pos field }
                            Wall -> innerState
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
                acc |> List.concat (toNodes mazeMap pos field)
    nodes |> List.map \node -> (node, node |> getNeighbours mazeMap nodes)

toNodes : MazeMap, Position, Field -> List Node
toNodes = \mazeMap, { row, col }, field ->
    when field is
        Wall -> []
        Start | End | Empty ->
            position = { row, col }
            north = mazeMap.positions |> Dict.get { row: row - 1, col } |> Result.withDefault Wall
            south = mazeMap.positions |> Dict.get { row: row + 1, col } |> Result.withDefault Wall
            west = mazeMap.positions |> Dict.get { row, col: col - 1 } |> Result.withDefault Wall
            east = mazeMap.positions |> Dict.get { row, col: col + 1 } |> Result.withDefault Wall
            a = if (north != Wall) && ((west != Wall) || (east != Wall)) then [{ position, direction: North }] else []
            b = if (south != Wall) && ((west != Wall) || (east != Wall)) then [{ position, direction: South }] else []
            c = if (west != Wall) && ((north != Wall) || (south != Wall)) then [{ position, direction: West }] else []
            d = if (east != Wall) && ((north != Wall) || (south != Wall)) then [{ position, direction: East }] else []
            List.join [a, b, c, d]

getNeighbours : Node, MazeMap, List Node -> List (Node, U64)
getNeighbours = \node, mazeMap, nodes ->
    straight = getNeighboursHelper mazeMap node.position node.direction nodes 0
    neighbours =
        when straight is
            Err DeadEnd -> []
            Ok (n, d) ->
                oppo = { position: n.position, direction: opposite n.direction }
                if nodes |> List.contains oppo then
                    [(n, d), (oppo, d)]
                else
                    [(n, d)]
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

Path : { tail : Set Position, distance : U64 }

shortestPath : MazeMapGraph, MazeMap -> Result Path [ShortestPathNotFound]
shortestPath = \graph, mazeMap ->
    initial = Dict.single { position: mazeMap.start, direction: East } { tail: Set.empty {}, distance: 0 }
    end = [South, West] |> List.map \direction -> { position: mazeMap.end, direction }
    result = dijkstraHelper graph end initial
    result |> Result.mapErr \_err -> ShortestPathNotFound

dijkstraHelper :
    MazeMapGraph,
    List Node,
    Dict Node Path
    -> Result Path [KeyNotFound, SmallestNotFound, PathToEndtileNotFound]
dijkstraHelper = \graph, end, visited ->
    if List.isEmpty graph then
        Err PathToEndtileNotFound
        else

    (node, element, neighbours, newGraph) = getSmallest? graph visited

    if end |> List.contains node then
        Ok element
        else

    newVisited =
        neighbours
        |> List.walk
            visited
            \state, (neighbour, d) ->
                state
                |> Dict.update neighbour \value ->
                    when value is
                        Err Missing ->
                            Ok { tail: element.tail |> updateTail node neighbour, distance: element.distance + d }

                        Ok v ->
                            if (element.distance + d) == v.distance then
                                t1 = element.tail |> updateTail node neighbour
                                t2 = v.tail
                                Ok { tail: Set.union t1 t2, distance: v.distance }
                            else if (element.distance + d) < v.distance then
                                Ok { tail: element.tail |> updateTail node neighbour, distance: element.distance + d }
                            else
                                Ok v
    dijkstraHelper newGraph end newVisited

updateTail : Set Position, Node, Node -> Set Position
updateTail = \tail, start, end ->
    if start.position == end.position then
        tail |> Set.insert end.position
        else

    new =
        when start.direction is
            North | South ->
                List.range { start: At start.position.row, end: At end.position.row }
                |> List.map \row -> { row, col: start.position.col }
                |> Set.fromList

            West | East ->
                List.range { start: At start.position.col, end: At end.position.col }
                |> List.map \col -> { row: start.position.row, col }
                |> Set.fromList

    Set.union tail new

getSmallest :
    MazeMapGraph,
    Dict Node Path
    -> Result (Node, Path, List (Node, U64), MazeMapGraph) [SmallestNotFound]
getSmallest = \graph, visited ->
    initialState = {
        smallest: Err SmallestNotFound,
        newGraph: [],
    }
    graph
    |> List.walk initialState \state, (node, neighbours) ->
        when visited |> Dict.get node is
            Err KeyNotFound -> { state & newGraph: state.newGraph |> List.append (node, neighbours) }
            Ok element ->
                when state.smallest is
                    Err SmallestNotFound -> { state & smallest: Ok (node, element, neighbours) }
                    Ok (stateNode, stateElement, stateNeighbours) ->
                        if element.distance < stateElement.distance then
                            { state &
                                smallest: Ok (node, element, neighbours),
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
    expected = Ok "45"
    got == expected

part2 : Str -> Result Str [ParsingFailure Str, ParsingIncomplete Str, ShortestPathNotFound]
part2 = \rawInput ->
    parseStr puzzleParser (rawInput |> Str.trim)
    |> Result.try
        \mazeMap ->
            mazeMap
            |> toMazeMapGraph
            |> shortestPath? mazeMap
            |> .tail
            |> Set.len
            |> Num.toStr
            |> Ok
