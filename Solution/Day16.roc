interface Solution.Day16
    exposes [
        part1,
        part2,
    ]
    imports [
        "Day16.input" as puzzleInput : Str,
        "Day16.example.input" as exampleDataFromFile : Str,
        parser.String.{ parseStr, string, codeunit },
        parser.Core.{ sepBy, many, oneOf, map },
    ]

part1 =
    solvePart1 puzzleInput

solvePart1 = \input ->
    input
    |> Str.trim
    |> parsePuzzleInput
    |> startBeam
    |> reduceEnergized
    |> List.len
    |> Num.toStr

parsePuzzleInput = \input ->
    when parseStr puzzleParser input is
        Ok v -> v
        Err _ -> crash "parsing failed"

puzzleParser =
    lineParser |> sepBy (string "\n")

lineParser =
    many
        (
            oneOf [
                (codeunit '.' |> map (\_ -> EmptySpace)),
                (codeunit '/' |> map (\_ -> Mirror Slash)),
                (codeunit '\\' |> map (\_ -> Mirror Backslash)),
                (codeunit '|' |> map (\_ -> Splitter Vertical)),
                (codeunit '-' |> map (\_ -> Splitter Horizontal)),
            ]
        )

startBeam = \contraption ->
    beamHelper contraption [Beam East 0 0] [Beam East 0 0]

beamHelper = \contraption, beams, energized ->
    beams
    |> List.walk
        ([], energized)
        (\(newBeams, newEnergized), Beam direction row col ->
            nextBeams =
                when getTile contraption row col is
                    EmptySpace ->
                        newDirection = direction
                        [getNextBeam contraption (Beam newDirection row col)]

                    Mirror Slash ->
                        newDirection =
                            when direction is
                                East -> North
                                North -> East
                                West -> South
                                South -> West
                        [getNextBeam contraption (Beam newDirection row col)]

                    Mirror Backslash ->
                        newDirection =
                            when direction is
                                East -> South
                                North -> West
                                West -> North
                                South -> East
                        [getNextBeam contraption (Beam newDirection row col)]

                    Splitter Horizontal ->
                        when direction is
                            East | West ->
                                newDirection = direction
                                [getNextBeam contraption (Beam newDirection row col)]

                            North | South ->
                                [
                                    getNextBeam contraption (Beam East row col),
                                    getNextBeam contraption (Beam West row col),
                                ]

                    Splitter Vertical ->
                        when direction is
                            North | South ->
                                newDirection = direction
                                [getNextBeam contraption (Beam newDirection row col)]

                            East | West ->
                                [
                                    getNextBeam contraption (Beam North row col),
                                    getNextBeam contraption (Beam South row col),
                                ]

            nextBeamsFiltered =
                nextBeams
                |> List.walk
                    []
                    (\state, n ->
                        when n is
                            Ok value -> state |> List.append value
                            Err _ -> state
                    )
                |> List.dropIf (\n -> alreadyEnergized newEnergized n)

            (newBeams |> List.concat nextBeamsFiltered, newEnergized |> List.concat nextBeamsFiltered)

        )
    |> (\(newBeams, newEnergized) ->
        if List.isEmpty newBeams then
            newEnergized
        else
            beamHelper contraption newBeams newEnergized
    )

getTile = \contraption, row, col ->
    when contraption |> List.get row is
        Err _ -> crash "impossible  (getTile 1)"
        Ok line ->
            when line |> List.get col is
                Err _ -> crash "impossible (getTile 2)"
                Ok element ->
                    element

getNextBeam = \contraption, Beam direction row col ->
    numRows = List.len contraption
    numCols =
        when contraption |> List.first is
            Err _ -> crash "impossible (in start beam)"
            Ok r -> List.len r

    when direction is
        East ->
            if col == (numCols - 1) then
                Err OutOfBounds
            else
                Ok (Beam direction row (col + 1))

        West ->
            if col == 0 then
                Err OutOfBounds
            else
                Ok (Beam direction row (col - 1))

        North ->
            if row == 0 then
                Err OutOfBounds
            else
                Ok (Beam direction (row - 1) col)

        South ->
            if row == (numRows - 1) then
                Err OutOfBounds
            else
                Ok (Beam direction (row + 1) col)

alreadyEnergized = \energized, beam ->
    energized |> List.contains beam

reduceEnergized = \energized ->
    energized
    |> List.walk
        []
        (\state, Beam _ row col ->
            if state |> List.contains (row, col) then
                state
            else
                state |> List.append (row, col)
        )

exampleData1 =
    """
    .|...\u(5C)....
    |.-.\u(5C).....
    .....|-...
    ........|.
    ..........
    .........\u(5C)
    ..../.\u(5C)\u(5C)..
    .-.-/..|..
    .|....-|.\u(5C)
    ..//.|....
    """

expect
    got = solvePart1 "\\...\n...."
    got == "2"

expect
    got = solvePart1 "\\\\..\n\\/.."
    got == "4"

expect
    got = solvePart1 exampleDataFromFile
    got == "26"

expect
    got = solvePart1 exampleData1
    got == "46"

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

# magicFn = \grid, energized ->
#     grid
#     |> List.mapWithIndex
#         (\line, rowIndex ->
#             line
#             |> List.mapWithIndex
#                 (\element, colIndex ->
#                     energized
#                     |> List.walkUntil
#                         NotFound
#                         (\_, Beam _ row col ->
#                             if col == colIndex && row == rowIndex then
#                                 Break (Found '#')
#                             else
#                                 Continue NotFound
#                         )
#                     |> (\i ->
#                         when i is
#                             Found f -> f
#                             NotFound ->
#                                 when element is
#                                     EmptySpace -> '.'
#                                     Mirror Slash -> '/'
#                                     Mirror Backslash -> '\\'
#                                     Splitter Vertical -> '|'
#                                     Splitter Horizontal -> '-'
#                     )
#                 )
#             |> Str.fromUtf8
#             |> Result.withDefault "ERROR"
#         )
#     |> Str.joinWith "\n"
