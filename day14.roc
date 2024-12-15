app [part1, part2] {
    pf: platform "https://github.com/ostcar/roc-aoc-platform/releases/download/v0.0.8/lhFfiil7mQXDOB6wN-jduJQImoT8qRmoiNHDB4DVF9s.tar.br",
    parser: "https://github.com/lukewilliamboswell/roc-parser/releases/download/0.9.0/w8YKp2YAgQt5REYk912HfKAHBjcXsrnvtjI0CBzoAT4.tar.br",
}

import parser.Parser exposing [Parser, const, keep, skip, sepBy, maybe, map]
import parser.String exposing [parseStr, string, digits]

example : Str
example =
    """
    p=0,4 v=3,-3
    p=6,3 v=-1,-3
    p=10,3 v=-1,2
    p=2,0 v=2,-1
    p=0,0 v=1,3
    p=3,0 v=-2,-2
    p=7,6 v=-1,-3
    p=3,0 v=-1,-2
    p=9,3 v=2,3
    p=7,3 v=-1,2
    p=2,4 v=2,-3
    p=9,5 v=-3,-3
    """

expect
    got = solvePart1 example 11 7
    expected = Ok "12"
    got == expected

part1 : Str -> Result Str [ParsingFailure Str, ParsingIncomplete Str]
part1 = \rawInput ->
    solvePart1 rawInput 101 103

solvePart1 : Str, I64, I64 -> Result Str [ParsingFailure Str, ParsingIncomplete Str]
solvePart1 = \rawInput, width, height ->
    parseStr puzzleParser (rawInput |> Str.trim)
    |> Result.map
        \robots ->
            robots
            |> List.map \r -> robotMove r width height
            |> List.map \r -> toQuadrant r width height
            |> List.walk
                { q1: 0, q2: 0, q3: 0, q4: 0 }
                \state, q ->
                    when q is
                        NoQuadrant -> state
                        Q1 -> { state & q1: state.q1 + 1 }
                        Q2 -> { state & q2: state.q2 + 1 }
                        Q3 -> { state & q3: state.q3 + 1 }
                        Q4 -> { state & q4: state.q4 + 1 }
            |> \state ->
                state.q1 * state.q2 * state.q3 * state.q4
            |> Num.toStr

Robot : { startX : I64, startY : I64, velocityX : I64, velocityY : I64 }
Quadrant : [Q1, Q2, Q3, Q4, NoQuadrant]

puzzleParser : Parser (List U8) (List Robot)
puzzleParser =
    robotParser |> sepBy (string "\n")

robotParser : Parser (List U8) Robot
robotParser =
    const \startX -> \startY -> \velocityX -> \velocityY -> { startX, startY, velocityX, velocityY }
    |> skip (string "p=")
    |> keep (digits |> map Num.toI64)
    |> skip (string ",")
    |> keep (digits |> map Num.toI64)
    |> skip (string " v=")
    |> keep digitsI64
    |> skip (string ",")
    |> keep digitsI64

digitsI64 : Parser (List U8) I64
digitsI64 =
    const
        \minusSign -> \num ->
                when minusSign is
                    Ok _ -> -1 * Num.toI64 num
                    Err Nothing -> Num.toI64 num
    |> keep (maybe (string "-"))
    |> keep digits

robotMove : Robot, I64, I64 -> (I64, I64)
robotMove = \robot, width, height ->
    steps = 100
    newX = (robot.startX + (robot.velocityX * steps)) % width
    newY = (robot.startY + (robot.velocityY * steps)) % height
    newX2 = if newX < 0 then newX + width else newX
    newY2 = if newY < 0 then newY + height else newY
    (newX2, newY2)

toQuadrant : (I64, I64), I64, I64 -> Quadrant
toQuadrant = \(x, y), width, height ->
    if x == (width // 2) || y == (height // 2) then
        NoQuadrant
    else if x < width // 2 then
        if y < height // 2 then
            Q1
        else
            Q3
    else if y < height // 2 then
        Q2
    else
        Q4

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
