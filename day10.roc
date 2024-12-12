app [part1, part2] {
    pf: platform "https://github.com/ostcar/roc-aoc-platform/releases/download/v0.0.8/lhFfiil7mQXDOB6wN-jduJQImoT8qRmoiNHDB4DVF9s.tar.br",
    parser: "https://github.com/lukewilliamboswell/roc-parser/releases/download/0.9.0/w8YKp2YAgQt5REYk912HfKAHBjcXsrnvtjI0CBzoAT4.tar.br",
}

import parser.Parser exposing [Parser, many, sepBy]
import parser.String exposing [parseStr, digit, string]

example : Str
example =
    """
    89010123
    78121874
    87430965
    96549874
    45678903
    32019012
    01329801
    10456732
    """

expect
    got = part1 example
    expected = Ok "36"
    got == expected

part1 : Str -> Result Str [ParsingFailure Str, ParsingIncomplete Str]
part1 = \rawInput ->
    parseStr puzzleParser (rawInput |> Str.trim)
    |> Result.map
        \map ->
            map
            |> mapToGraph
            |> countTrails
            |> Num.toStr

puzzleParser : Parser (List U8) (List (List U64))
puzzleParser =
    lineParser |> sepBy (string "\n")

lineParser : Parser (List U8) (List U64)
lineParser =
    many digit

Graph : Dict NodeId Node
NodeId : (U64, U64)
Node : { num : U64, paths : List NodeId }
MaybeElement : [NoElement, Element U64]
Orientation : [Horizontally, Vertically]

mapToGraph : List (List U64) -> Graph
mapToGraph = \map ->
    numOfCols = map |> List.first |> Result.withDefault [] |> List.len

    noElementList =
        List.repeat NoElement numOfCols

    helper : List U64, U64, MaybeElement, U64, { graph : Graph, previousUpperElements : List MaybeElement } -> { graph : Graph, previousUpperElements : List MaybeElement }
    helper =
        \elems, rowIndex, left, colIndex, state ->
            when elems is
                [] ->
                    state

                [currentElem, .. as rest] ->
                    newGraph1 =
                        when left is
                            NoElement ->
                                state.graph

                            Element leftElem ->
                                updateGraph state.graph Horizontally (rowIndex, colIndex) leftElem currentElem

                    newGraph2 =
                        upper = List.first state.previousUpperElements |> Result.withDefault NoElement
                        when upper is
                            NoElement ->
                                newGraph1

                            Element upperElem ->
                                updateGraph newGraph1 Vertically (rowIndex, colIndex) upperElem currentElem

                    newGraph3 =
                        if currentElem == 9 then
                            newGraph2 |> Dict.insert (rowIndex, colIndex) { num: currentElem, paths: [] }
                        else
                            newGraph2

                    nextLeft = Element currentElem
                    nextPrevUpperElems = state.previousUpperElements |> List.dropFirst 1 |> List.append (Element currentElem)
                    helper rest rowIndex nextLeft (colIndex + 1) { graph: newGraph3, previousUpperElements: nextPrevUpperElems }

    map
    |> List.walkWithIndex
        { graph: Dict.empty {}, previousUpperElements: noElementList }
        \state, row, rowIndex ->
            helper row rowIndex NoElement 0 state
    |> .graph

updateGraph : Graph, Orientation, NodeId, U64, U64 -> Graph
updateGraph = \graph, orientation, (row, col), prev, current ->
    currentNodeId = (row, col)
    prevNodeId =
        when orientation is
            Horizontally -> (row, col - 1)
            Vertically -> (row - 1, col)
    if current + 1 == prev then
        graph
        |> Dict.update
            currentNodeId
            \v -> v
                |> Result.withDefault { num: current, paths: [] }
                |> \node -> { node & paths: node.paths |> List.append prevNodeId } |> Ok
    else if prev + 1 == current then
        graph
        |> Dict.update
            prevNodeId
            \v -> v
                |> Result.withDefault { num: prev, paths: [] }
                |> \node -> { node & paths: node.paths |> List.append currentNodeId } |> Ok
    else
        graph

countTrails : Graph -> U64
countTrails = \graph ->
    graph
    |> Dict.toList
    |> List.keepIf
        \(_, node) -> node.num == 0
    |> List.map
        \(nodeId, _node) ->
            searchPaths nodeId graph
    |> List.sum

searchPaths : NodeId, Graph -> U64
searchPaths = \nodeId, graph ->
    helper : { nextNodeIds : List NodeId, result : Set NodeId } -> U64
    helper =
        \state ->
            if List.isEmpty state.nextNodeIds then
                state.result |> Set.len
            else
                state.nextNodeIds
                |> List.walk
                    { nextNodeIds: [], result: state.result }
                    \acc, innerNodeId ->
                        node =
                            when graph |> Dict.get innerNodeId is
                                Err KeyNotFound ->
                                    { num: 100, paths: [] }

                                Ok v -> v
                        {
                            nextNodeIds: acc.nextNodeIds |> List.concat node.paths,
                            result: if node.num == 9 then acc.result |> Set.insert innerNodeId else acc.result,
                        }
                |> helper

    helper { nextNodeIds: [nodeId], result: Set.empty {} }

expect
    got = part2 example
    expected = Ok "81"
    got == expected

part2 : Str -> Result Str [ParsingFailure Str, ParsingIncomplete Str]
part2 = \rawInput ->
    parseStr puzzleParser (rawInput |> Str.trim)
    |> Result.map
        \map ->
            map
            |> mapToGraph
            |> countTrails2
            |> Num.toStr

countTrails2 : Graph -> U64
countTrails2 = \graph ->
    graph
    |> Dict.toList
    |> List.keepIf
        \(_, node) -> node.num == 0
    |> List.map
        \(nodeId, _node) ->
            searchPaths2 nodeId graph
    |> List.sum

searchPaths2 : NodeId, Graph -> U64
searchPaths2 = \nodeId, graph ->
    helper : { nextNodeIds : List NodeId, result : List NodeId } -> U64
    helper =
        \state ->
            if List.isEmpty state.nextNodeIds then
                state.result |> List.len
            else
                state.nextNodeIds
                |> List.walk
                    { nextNodeIds: [], result: state.result }
                    \acc, innerNodeId ->
                        node =
                            when graph |> Dict.get innerNodeId is
                                Err KeyNotFound ->
                                    { num: 100, paths: [] }

                                Ok v -> v
                        {
                            nextNodeIds: acc.nextNodeIds |> List.concat node.paths,
                            result: if node.num == 9 then acc.result |> List.append innerNodeId else acc.result,
                        }
                |> helper

    helper { nextNodeIds: [nodeId], result: [] }
