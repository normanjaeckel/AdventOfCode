app [part1, part2] {
    pf: platform "https://github.com/ostcar/roc-aoc-platform/releases/download/v0.0.8/lhFfiil7mQXDOB6wN-jduJQImoT8qRmoiNHDB4DVF9s.tar.br",
    parser: "https://github.com/lukewilliamboswell/roc-parser/releases/download/0.9.0/w8YKp2YAgQt5REYk912HfKAHBjcXsrnvtjI0CBzoAT4.tar.br",
}

import parser.Parser exposing [Parser, const, keep, skip, sepBy]
import parser.String exposing [parseStr, string, digits]

example : Str
example =
    """
    5,4
    4,2
    4,5
    3,0
    2,1
    6,3
    2,4
    1,5
    0,6
    3,3
    2,6
    5,1
    1,2
    5,5
    2,5
    6,5
    1,4
    0,4
    6,4
    1,1
    6,1
    1,0
    0,5
    1,6
    2,0
    """

expect
    got = innerPart1 example 12 6
    expected = Ok "22"
    got == expected

part1 : Str -> Result Str [ParsingFailure Str, ParsingIncomplete Str, NotFound]
part1 = \rawInput ->
    innerPart1 rawInput 1024 70

innerPart1 : Str, U64, U64 -> Result Str [ParsingFailure Str, ParsingIncomplete Str, NotFound]
innerPart1 = \rawInput, number, maxIndex ->
    parseStr puzzleParser (rawInput |> Str.trim)
    |> Result.try
        \input ->
            start = Dict.single { x: 0, y: 0 } 0
            allPositions =
                List.range { start: At 0, end: At maxIndex }
                |> List.map \x ->
                    List.range { start: At 0, end: At maxIndex }
                    |> List.map \y ->
                        { x, y }
                |> List.join
                |> List.dropIf \p -> input |> List.takeFirst number |> List.contains p

            when searchShortestPath maxIndex allPositions start is
                Err NotFound -> Err NotFound
                Ok count -> Ok (Num.toStr count)

Position : { x : U64, y : U64 }

puzzleParser : Parser (List U8) (List Position)
puzzleParser =
    lineParser |> sepBy (string "\n")

lineParser : Parser (List U8) Position
lineParser =
    const \x -> \y -> { x, y }
    |> keep digits
    |> skip (string ",")
    |> keep digits

searchShortestPath : U64, List Position, Dict Position U64 -> Result U64 [NotFound]
searchShortestPath = \maxIndex, positions, visited ->
    (smallest, count, newPositions) = getSmallest? positions visited
    if smallest == { x: maxIndex, y: maxIndex } then
        Ok count
        else

    neighbours = getNeigbours smallest positions
    newVisited =
        neighbours
        |> List.walk visited \state, neighbour ->
            state
            |> Dict.update neighbour \value ->
                when value is
                    Err Missing -> Ok (count + 1)
                    Ok v -> Ok (Num.min v (count + 1))
    searchShortestPath maxIndex newPositions newVisited

getSmallest : List Position, Dict Position U64 -> Result (Position, U64, List Position) [NotFound]
getSmallest = \positions, visited ->
    positions
    |> List.walk (Err NotFound) \state, pos ->
        when visited |> Dict.get pos is
            Err KeyNotFound -> state
            Ok count ->
                when state is
                    Err NotFound -> Ok (pos, count)
                    Ok (_, current) ->
                        if current > count then
                            Ok (pos, count)
                        else
                            state
    |> Result.map \(p, c) ->
        newPositions = positions |> List.dropIf \pos -> pos == p
        (p, c, newPositions)

getNeigbours : Position, List Position -> List Position
getNeigbours = \pos, allPositions ->
    xList = if pos.x > 0 then [pos.x - 1, pos.x + 1] else [pos.x + 1]
    yList = if pos.y > 0 then [pos.y - 1, pos.y + 1] else [pos.y + 1]
    xList
    |> List.map \x -> { x, y: pos.y }
    |> List.concat (yList |> List.map \y -> { x: pos.x, y })
    |> List.keepIf \p -> (allPositions |> List.contains p)

expect
    got = innerPart2 example 12 6
    expected = Ok "6,1"
    got == expected

part2 : Str -> Result Str [ParsingFailure Str, ParsingIncomplete Str, NotFound, OutOfBounds]
part2 = \rawInput ->
    innerPart2 rawInput 1024 70

innerPart2 : Str, U64, U64 -> Result Str [ParsingFailure Str, ParsingIncomplete Str, NotFound, OutOfBounds]
innerPart2 = \rawInput, left, maxIndex ->
    parseStr puzzleParser (rawInput |> Str.trim)
    |> Result.try
        \input ->
            right = List.len input
            number = searchIndex input maxIndex left right
            input
            |> List.get (number - 1)
            |> try
            |> \p -> "$(Num.toStr p.x),$(Num.toStr p.y)"
            |> Ok

searchIndex : List Position, U64, U64, U64 -> U64
searchIndex = \positions, maxIndex, left, right ->
    if left + 1 == right then
        right
        else

    number = ((right - left) // 2) + left
    start = Dict.single { x: 0, y: 0 } 0
    allPositions =
        List.range { start: At 0, end: At maxIndex }
        |> List.map \x ->
            List.range { start: At 0, end: At maxIndex }
            |> List.map \y ->
                { x, y }
        |> List.join
        |> List.dropIf \p -> positions |> List.takeFirst number |> List.contains p

    when searchShortestPath maxIndex allPositions start is
        Err NotFound ->
            searchIndex positions maxIndex left number

        Ok _ ->
            searchIndex positions maxIndex number right
