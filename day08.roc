app [part1, part2] {
    pf: platform "https://github.com/ostcar/roc-aoc-platform/releases/download/v0.0.8/lhFfiil7mQXDOB6wN-jduJQImoT8qRmoiNHDB4DVF9s.tar.br",
    parser: "https://github.com/lukewilliamboswell/roc-parser/releases/download/0.9.0/w8YKp2YAgQt5REYk912HfKAHBjcXsrnvtjI0CBzoAT4.tar.br",
}

import parser.Parser exposing [Parser, chompWhile, map, sepBy]
import parser.String exposing [parseStr, string]

example : Str
example =
    """
    ............
    ........0...
    .....0......
    .......0....
    ....0.......
    ......A.....
    ............
    ............
    ........A...
    .........A..
    ............
    ............
    """

expect
    got = part1 example
    expected = Ok "14"
    got == expected

Part : [Part1, Part2]

part1 : Str -> Result Str [ParsingFailure Str, ParsingIncomplete Str]
part1 = \rawInput ->
    parseStr puzzleParser (rawInput |> Str.trim)
    |> Result.map
        \city ->
            city.signals
            |> groupSignals
            |> Dict.walk
                (Set.empty {})
                \acc, _frequency, sigs ->
                    acc |> Set.union (sigs |> calcAntinodes city.maxRow city.maxCol Part1)
            |> Set.len
            |> Num.toStr

Position : { row : U64, col : U64 }
Signal : { position : Position, frequency : U8 }
City : { maxRow : U64, maxCol : U64, signals : List Signal }

puzzleParser : Parser (List U8) City
puzzleParser =
    lineParser
    |> sepBy (string "\n")
    |> map
        \lines ->
            maxRow = List.len lines - 1
            maxCol = (lines |> List.first |> Result.withDefault ([], 0)) |> .1 # Get the second value of a tuple
            lines
            |> List.walkWithIndex
                []
                \acc, (line, _maxCol), row ->
                    acc
                    |> List.concat
                        (
                            line
                            |> List.map \(col, frequency) -> { position: { row, col }, frequency }
                        )
            |> \signals -> { maxRow, maxCol, signals }

lineParser : Parser (List U8) (List (U64, U8), U64)
lineParser =
    chompWhile (\char -> char != '\n')
    |> map
        \line ->
            maxCol = List.len line - 1
            sigs =
                line
                |> List.walkWithIndex
                    []
                    \acc, char, col ->
                        if ('0' <= char && char <= '9') || ('A' <= char && char <= 'Z') || ('a' <= char && char <= 'z') then
                            acc |> List.append (col, char)
                        else
                            acc
            (sigs, maxCol)

groupSignals : List Signal -> Dict U8 (List Signal)
groupSignals = \signals ->
    signals
    |> List.walk
        (Dict.empty {})
        \acc, signal ->
            acc
            |> Dict.update signal.frequency \v -> v |> Result.withDefault [] |> List.append signal |> Ok

calcAntinodes : List Signal, U64, U64, Part -> Set Position
calcAntinodes = \signals, maxRow, maxCol, part ->
    calcAntinodesHelper (Set.empty {}) signals [] maxRow maxCol part

calcAntinodesHelper : Set Position, List Signal, List Signal, U64, U64, Part -> Set Position
calcAntinodesHelper = \result, signals, presentSignals, maxRow, maxCol, part ->
    when signals is
        [] ->
            result

        [currentSignal, .. as rest] ->
            presentSignals
            |> List.walk
                result
                \state, presentSignal ->
                    newAntinodes = getNewAntinodes currentSignal presentSignal maxRow maxCol part
                    state |> Set.union newAntinodes
            |> calcAntinodesHelper rest (presentSignals |> List.append currentSignal) maxRow maxCol part

getNewAntinodes : Signal, Signal, U64, U64, Part -> Set Position
getNewAntinodes = \sig1, sig2, maxRow, maxCol, part ->
    when part is
        Part1 ->
            diffRow = Num.toI64 sig1.position.row - Num.toI64 sig2.position.row
            diffCol = Num.toI64 sig1.position.col - Num.toI64 sig2.position.col
            antinode1 = (Num.toI64 sig1.position.row + diffRow, Num.toI64 sig1.position.col + diffCol) |> checkOutOfBounds maxRow maxCol
            antinode2 = (Num.toI64 sig2.position.row - diffRow, Num.toI64 sig2.position.col - diffCol) |> checkOutOfBounds maxRow maxCol
            Set.union antinode1 antinode2

        Part2 ->
            dRow = Num.toI64 sig1.position.row - Num.toI64 sig2.position.row
            dCol = Num.toI64 sig1.position.col - Num.toI64 sig2.position.col
            modRow = Num.remChecked (Num.toI64 sig1.position.row) dRow |> Result.withDefault (Num.toI64 sig1.position.row)
            modCol = Num.remChecked (Num.toI64 sig1.position.col) dCol |> Result.withDefault (Num.toI64 sig1.position.col)
            offsetCol = Num.toI64 sig1.position.col - (Num.toI64 sig1.position.row // dRow) * dCol - modCol
            List.range { start: At 0, end: At (Num.toI64 maxRow // dRow) }
            |> List.walk
                (Set.empty {})
                \state, n ->
                    r = n * dRow + modRow
                    c = n * dCol + modCol + offsetCol
                    if r >= 0 && r <= Num.toI64 maxRow && c >= 0 && c <= Num.toI64 maxCol then
                        state |> Set.insert { row: Num.toU64 r, col: Num.toU64 c }
                    else
                        state

checkOutOfBounds : (I64, I64), U64, U64 -> Set Position
checkOutOfBounds = \(row, col), maxRow, maxCol ->
    if row < 0 || Num.toU64 row > maxRow || col < 0 || Num.toU64 col > maxCol then
        Set.empty {}
    else
        Set.single { row: Num.toU64 row, col: Num.toU64 col }

expect
    got = part2 example
    expected = Ok "34"
    got == expected

part2 : Str -> Result Str [ParsingFailure Str, ParsingIncomplete Str]
part2 = \rawInput ->
    parseStr puzzleParser (rawInput |> Str.trim)
    |> Result.map
        \city ->
            city.signals
            |> groupSignals
            |> Dict.walk
                (Set.empty {})
                \acc, _frequency, sigs ->
                    acc |> Set.union (sigs |> calcAntinodes city.maxRow city.maxCol Part2)
            |> Set.len
            |> Num.toStr

example2 =
    """
    T....#....
    ...T......
    .T....#...
    .........#
    ..#.......
    ..........
    ...#......
    ..........
    ....#.....
    ..........
    """

expect
    got = part2 example2
    expected = Ok "9"
    got == expected
