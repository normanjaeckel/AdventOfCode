app [part1, part2] {
    pf: platform "https://github.com/ostcar/roc-aoc-platform/releases/download/v0.0.8/lhFfiil7mQXDOB6wN-jduJQImoT8qRmoiNHDB4DVF9s.tar.br",
    parser: "https://github.com/lukewilliamboswell/roc-parser/releases/download/0.9.0/w8YKp2YAgQt5REYk912HfKAHBjcXsrnvtjI0CBzoAT4.tar.br",
}

import parser.Parser exposing [Parser, flatten, many, map, oneOf, sepBy]
import parser.String exposing [parseStr, string]

example : Str
example =
    """
    ....#.....
    .........#
    ..........
    ..#.......
    .......#..
    ..........
    .#..^.....
    ........#.
    #.........
    ......#...
    """

expect
    got = part1 example
    expected = Ok "41"
    got == expected

part1 : Str -> Result Str [ParsingFailure Str, ParsingIncomplete Str]
part1 = \rawInput ->
    parseStr puzzleParser (rawInput |> Str.trim)
    |> Result.map
        \(lab, guard) ->
            startWalking lab guard
            |> Set.len
            |> Num.toStr

Position : (U64, U64)
Obstacles : List Position
Lab : { maxRow : U64, maxCol : U64, obstacles : Obstacles }

puzzleParser : Parser (List U8) (Lab, Position)
puzzleParser =
    lineParser
    |> sepBy (string "\n")
    |> map
        \lines ->
            maxRow = List.len lines - 1
            maxCol = (lines |> List.first |> Result.withDefault [] |> List.len) - 1
            lines
            |> List.walkWithIndex
                { obstacles: [], guard: Err NotFound }
                \state1, line, row ->
                    line
                    |> List.walkWithIndex
                        state1
                        \state2, point, col ->
                            when point is
                                Guard -> { state2 & guard: Ok (row, col) }
                                Obstacle -> { state2 & obstacles: state2.obstacles |> List.append (row, col) }
                                Empty -> state2
            |> \state ->
                when state.guard is
                    Ok guard -> Ok ({ maxRow: maxRow, maxCol: maxCol, obstacles: state.obstacles }, guard)
                    Err NotFound -> Err "Guard not found"
    |> flatten

lineParser : Parser (List U8) (List [Empty, Obstacle, Guard])
lineParser =
    many
        (
            oneOf [
                string "." |> map \_ -> Empty,
                string "#" |> map \_ -> Obstacle,
                string "^" |> map \_ -> Guard,
            ]
        )

Direction : [North, East, South, West]

startWalking : Lab, Position -> Set Position
startWalking = \lab, guard ->
    walkingHelper lab guard North []
    |> Set.fromList

walkingHelper : Lab, Position, Direction, List Position -> List Position
walkingHelper = \lab, (guardRow, guardCol), direction, visited ->
    nextPos =
        when direction is
            North ->
                if guardRow == 0 then
                    Err OutsideLab
                else
                    Ok (guardRow - 1, guardCol)

            East ->
                if guardCol == lab.maxCol then
                    Err OutsideLab
                else
                    Ok (guardRow, guardCol + 1)

            South ->
                if guardRow == lab.maxRow then
                    Err OutsideLab
                else
                    Ok (guardRow + 1, guardCol)

            West ->
                if guardCol == 0 then
                    Err OutsideLab
                else
                    Ok (guardRow, guardCol - 1)

    when nextPos is
        Err OutsideLab ->
            visited |> List.append (guardRow, guardCol)

        Ok pos ->
            if lab.obstacles |> List.contains pos then
                newDirection = turnGuard direction
                walkingHelper lab (guardRow, guardCol) newDirection visited
            else
                walkingHelper lab pos direction (visited |> List.append (guardRow, guardCol))

turnGuard : Direction -> Direction
turnGuard = \dir ->
    when dir is
        North -> East
        East -> South
        South -> West
        West -> North

expect
    got = part2 example
    expected = Ok "6"
    got == expected

part2 : Str -> Result Str [ParsingFailure Str, ParsingIncomplete Str]
part2 = \rawInput ->
    parseStr puzzleParser (rawInput |> Str.trim)
    |> Result.map
        \(lab, guard) ->
            startWalking lab guard
            |> Set.remove guard
            |> addObstacle lab guard
            |> Num.toStr

addObstacle : Set Position, Lab, Position -> U64
addObstacle = \variants, lab, guard ->
    variants
    |> Set.walk
        { loops: 0, index: 0 }
        \state, pos ->
            dbg state
            if isLoop lab pos guard then
                { loops: state.loops + 1, index: state.index + 1 }
            else
                { state & index: state.index + 1 }
    |> .loops

isLoop : Lab, Position, Position -> Bool
isLoop = \lab, pos, guard ->
    newLab = { lab & obstacles: lab.obstacles |> List.append pos }
    isLoopHelper newLab guard North []

isLoopHelper : Lab, Position, Direction, List (Position, Direction) -> Bool
isLoopHelper = \lab, (guardRow, guardCol), direction, visited ->
    nextPos =
        when direction is
            North ->
                if guardRow == 0 then
                    Err OutsideLab
                else
                    Ok (guardRow - 1, guardCol)

            East ->
                if guardCol == lab.maxCol then
                    Err OutsideLab
                else
                    Ok (guardRow, guardCol + 1)

            South ->
                if guardRow == lab.maxRow then
                    Err OutsideLab
                else
                    Ok (guardRow + 1, guardCol)

            West ->
                if guardCol == 0 then
                    Err OutsideLab
                else
                    Ok (guardRow, guardCol - 1)

    when nextPos is
        Err OutsideLab ->
            Bool.false

        Ok pos ->
            if visited |> List.contains (pos, direction) then
                Bool.true
            else if lab.obstacles |> List.contains pos then
                newDirection = turnGuard direction
                isLoopHelper lab (guardRow, guardCol) newDirection (visited |> List.append ((guardRow, guardCol), direction))
            else
                isLoopHelper lab pos direction (visited |> List.append ((guardRow, guardCol), direction))
