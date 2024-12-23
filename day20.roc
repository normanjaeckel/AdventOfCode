app [part1, part2] {
    pf: platform "https://github.com/ostcar/roc-aoc-platform/releases/download/v0.0.8/lhFfiil7mQXDOB6wN-jduJQImoT8qRmoiNHDB4DVF9s.tar.br",
    parser: "https://github.com/lukewilliamboswell/roc-parser/releases/download/0.9.0/w8YKp2YAgQt5REYk912HfKAHBjcXsrnvtjI0CBzoAT4.tar.br",
}

import parser.Parser exposing [Parser, map, oneOf, oneOrMore, sepBy]
import parser.String exposing [parseStr, string]

example : Str
example =
    """
    ###############
    #...#...#.....#
    #.#.#.#.#.###.#
    #S#...#.#.#...#
    #######.#.#.###
    #######.#.#...#
    #######.#.###.#
    ###..E#...#...#
    ###.#######.###
    #...###...#...#
    #.#####.#.###.#
    #.#...#.#.#...#
    #.#.#.#.#.#.###
    #...#...#...###
    ###############
    """

expect
    got = innerPart1 example 20 2
    expected = Ok "5"
    got == expected

part1 : Str -> Result Str [ParsingFailure Str, ParsingIncomplete Str, ListWasEmpty]
part1 = \rawInput ->
    innerPart1 rawInput 100 2

innerPart1 : Str, U64, U64 -> Result Str [ParsingFailure Str, ParsingIncomplete Str, ListWasEmpty]
innerPart1 = \rawInput, saving, availableCheats ->
    parseStr puzzleParser (rawInput |> Str.trim)
    |> Result.try
        \racetrack ->
            walk racetrack saving availableCheats
            |> Num.toStr
            |> Ok

Racetrack : List (Position, U64)
Tile : [Wall, Track, Start, End]
Position : { row : U64, col : U64 }

puzzleParser : Parser (List U8) Racetrack
puzzleParser =
    lineParser
    |> sepBy (string "\n")
    |> map toRacetrack

lineParser : Parser (List U8) (List Tile)
lineParser =
    oneOrMore
        (
            oneOf [
                string "#" |> map \_ -> Wall,
                string "." |> map \_ -> Track,
                string "S" |> map \_ -> Start,
                string "E" |> map \_ -> End,
            ]
        )

toRacetrack : List (List Tile) -> Racetrack
toRacetrack = \rows ->
    initial = { track: [], start: { row: 0, col: 0 } }
    rows
    |> List.walkWithIndex initial \state1, row, rowIndex ->
        row
        |> List.walkWithIndex state1 \state2, tile, colIndex ->
            pos = { row: rowIndex, col: colIndex }
            when tile is
                Start -> { state2 & track: state2.track |> List.append pos, start: pos }
                End | Track -> { state2 & track: state2.track |> List.append pos }
                Wall -> state2
    |> getDistances

getDistances : { track : List Position, start : Position } -> Racetrack
getDistances = \{ track, start } ->
    getDistancesHelper track start 0 []

getDistancesHelper : List Position, Position, U64, List (Position, U64) -> List (Position, U64)
getDistancesHelper = \track, current, count, result ->
    newResult = result |> List.append (current, count)
    when getNextFromTrack track current is
        Err NotFound -> newResult
        Ok next ->
            newTrack = track |> List.dropIf \p -> p == current
            getDistancesHelper newTrack next (count + 1) newResult

getNextFromTrack : List Position, Position -> Result Position [NotFound]
getNextFromTrack = \track, current ->
    track
    |> List.findFirst \elem ->
        (elem.row == current.row && (Num.absDiff elem.col current.col) == 1)
        || (elem.col == current.col && (Num.absDiff elem.row current.row) == 1)

walk : Racetrack, U64, U64 -> U64
walk = \racetrack, saving, availableCheats ->
    racetrack
    |> List.map \(pos, count) ->
        fields = getAllFieldsAvailableFrom pos availableCheats
        possibilities =
            fields
            |> List.walk [] \acc, f ->
                when racetrack |> List.findFirst \r -> r.0 == f.0 is
                    Err NotFound -> acc
                    Ok ra -> acc |> List.append (ra.0, ra.1, f.1)
        possibilities |> List.keepIf (\p -> count + p.2 + saving <= p.1) |> List.len
    |> List.sum

getAllFieldsAvailableFrom : Position, U64 -> List (Position, U64)
getAllFieldsAvailableFrom = \pos, dist ->
    minRow = Num.subSaturated pos.row dist
    minCol = Num.subSaturated pos.col dist
    maxRow = pos.row + dist
    maxCol = pos.col + dist
    List.range { start: At minRow, end: At maxRow }
    |> List.map \row ->
        List.range { start: At minCol, end: At maxCol }
        |> List.walk [] \acc, col ->
            myDist = (Num.absDiff row pos.row) + (Num.absDiff col pos.col)
            if myDist <= dist then
                acc |> List.append ({ row, col }, myDist)
            else
                acc
    |> List.join

expect
    got = innerPart1 example 50 20
    expected = Ok "285"
    got == expected

part2 : Str -> Result Str [ParsingFailure Str, ParsingIncomplete Str, ListWasEmpty]
part2 = \rawInput ->
    innerPart1 rawInput 100 20
