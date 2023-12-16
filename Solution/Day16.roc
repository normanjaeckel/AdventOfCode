interface Solution.Day16
    exposes [
        part1,
        part2,
    ]
    imports [
        "Day16.input" as puzzleInput : Str,
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
    maxRow = List.len contraption
    maxCol =
        when contraption |> List.first is
            Err _ -> crash "impossible (in start beam)"
            Ok row ->
                List.len row
    beamHelper contraption maxRow maxCol [Beam East 1 0] []

beamHelper = \contraption, maxRow, maxCol, beams, energized ->
    beams
    |> List.walk
        ([], energized)
        (\(newBeams, newEnergized), Beam direction row col ->
            when direction is
                East ->
                    if col == maxCol then
                        (newBeams, newEnergized)
                    else if alreadyEnergized newEnergized (Beam direction row (col + 1)) then
                        (newBeams, newEnergized)
                    else
                        next = getTile contraption row (col + 1)
                        when next is
                            EmptySpace ->
                                new = Beam East row (col + 1)
                                (newBeams |> List.append new, newEnergized |> List.append new)

                            Mirror m ->
                                when m is
                                    Slash ->
                                        new = Beam North row (col + 1)
                                        (newBeams |> List.append new, newEnergized |> List.append new)

                                    Backslash ->
                                        new = Beam South row (col + 1)
                                        (newBeams |> List.append new, newEnergized |> List.append new)

                            Splitter s ->
                                when s is
                                    Horizontal ->
                                        new = Beam East row (col + 1)
                                        (newBeams |> List.append new, newEnergized |> List.append new)

                                    Vertical ->
                                        new = [Beam North row (col + 1), Beam South row (col + 1)]
                                        (newBeams |> List.concat new, newEnergized |> List.concat new)

                West ->
                    if col == 1 then
                        (newBeams, newEnergized)
                    else if alreadyEnergized newEnergized (Beam direction row (col - 1)) then
                        (newBeams, newEnergized)
                    else
                        next = getTile contraption row (col - 1)
                        when next is
                            EmptySpace ->
                                new = Beam West row (col - 1)
                                (newBeams |> List.append new, newEnergized |> List.append new)

                            Mirror m ->
                                when m is
                                    Slash ->
                                        new = Beam South row (col - 1)
                                        (newBeams |> List.append new, newEnergized |> List.append new)

                                    Backslash ->
                                        new = Beam North row (col - 1)
                                        (newBeams |> List.append new, newEnergized |> List.append new)

                            Splitter s ->
                                when s is
                                    Horizontal ->
                                        new = Beam West row (col - 1)
                                        (newBeams |> List.append new, newEnergized |> List.append new)

                                    Vertical ->
                                        new = [Beam North row (col - 1), Beam South row (col - 1)]
                                        (newBeams |> List.concat new, newEnergized |> List.concat new)

                South ->
                    if row == maxRow then
                        (newBeams, newEnergized)
                    else if alreadyEnergized newEnergized (Beam direction (row + 1) col) then
                        (newBeams, newEnergized)
                    else
                        next = getTile contraption (row + 1) col
                        when next is
                            EmptySpace ->
                                new = Beam South (row + 1) col
                                (newBeams |> List.append new, newEnergized |> List.append new)

                            Mirror m ->
                                when m is
                                    Slash ->
                                        new = Beam West (row + 1) col
                                        (newBeams |> List.append new, newEnergized |> List.append new)

                                    Backslash ->
                                        new = Beam East (row + 1) col
                                        (newBeams |> List.append new, newEnergized |> List.append new)

                            Splitter s ->
                                when s is
                                    Vertical ->
                                        new = Beam South (row + 1) col
                                        (newBeams |> List.append new, newEnergized |> List.append new)

                                    Horizontal ->
                                        new = [Beam West (row + 1) col, Beam East (row + 1) col]
                                        (newBeams |> List.concat new, newEnergized |> List.concat new)

                North ->
                    if row == 1 then
                        (newBeams, newEnergized)
                    else if alreadyEnergized newEnergized (Beam direction (row - 1) col) then
                        (newBeams, newEnergized)
                    else
                        next = getTile contraption (row - 1) col
                        when next is
                            EmptySpace ->
                                new = Beam North (row - 1) col
                                (newBeams |> List.append new, newEnergized |> List.append new)

                            Mirror m ->
                                when m is
                                    Slash ->
                                        new = Beam East (row - 1) col
                                        (newBeams |> List.append new, newEnergized |> List.append new)

                                    Backslash ->
                                        new = Beam West (row - 1) col
                                        (newBeams |> List.append new, newEnergized |> List.append new)

                            Splitter s ->
                                when s is
                                    Vertical ->
                                        new = Beam North (row - 1) col
                                        (newBeams |> List.append new, newEnergized |> List.append new)

                                    Horizontal ->
                                        new = [Beam West (row - 1) col, Beam East (row - 1) col]
                                        (newBeams |> List.concat new, newEnergized |> List.concat new)
        )
    |> (\(newBeams, newEnergized) ->
        if List.isEmpty newBeams then
            newEnergized
        else
            beamHelper contraption maxRow maxCol newBeams newEnergized
    )

getTile = \contraption, row, col ->
    when contraption |> List.get (row - 1) is
        Err _ -> crash "impossible (getTile 1)"
        Ok line ->
            when line |> List.get (col - 1) is
                Err _ -> crash "impossible (getTile 2)"
                Ok element ->
                    element

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
