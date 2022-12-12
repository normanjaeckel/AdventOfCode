module Day12 exposing (run)

import Dict
import Html exposing (p)
import Parser exposing ((|.), (|=))
import Set


run : String -> ( String, String )
run puzzleInput =
    ( solvePuzzle puzzleInput PartA, solvePuzzle puzzleInput PartB )


type PuzzlePart
    = PartA
    | PartB


solvePuzzle : String -> PuzzlePart -> String
solvePuzzle puzzleInput part =
    case puzzleInput |> Parser.run gridParser of
        Ok grid ->
            if grid |> Dict.isEmpty then
                "empty grid"

            else
                grid
                    |> searchShortestPath part
                    |> String.fromInt

        Err _ ->
            "Error"



-- Parsing


type alias Grid =
    Dict.Dict Position Square


type alias Position =
    ( Int, Int )


type Square
    = Start
    | End
    | OnTheWay Int


gridParser : Parser.Parser Grid
gridParser =
    Parser.loop Dict.empty gridParserHelper


gridParserHelper : Grid -> Parser.Parser (Parser.Step Grid Grid)
gridParserHelper grid =
    Parser.oneOf
        [ Parser.succeed (\p s -> grid |> Dict.insert p s |> Parser.Loop)
            |= Parser.getPosition
            |= Parser.oneOf
                [ Parser.succeed Start
                    |. Parser.symbol "S"
                , Parser.succeed End
                    |. Parser.symbol "E"
                , Parser.succeed OnTheWay
                    |= heightParser
                ]
            |. Parser.spaces
        , (Parser.succeed () |. Parser.end) |> Parser.map (\_ -> Parser.Done grid)
        ]


heightParser : Parser.Parser Int
heightParser =
    let
        fn : String -> Parser.Parser Int
        fn s =
            case s |> String.toList |> List.head of
                Nothing ->
                    Parser.problem "invalid case which can not appear"

                Just ch ->
                    Parser.succeed (ch |> Char.toCode)
    in
    Parser.chompIf Char.isLower
        |> Parser.getChompedString
        |> Parser.andThen fn



-- Search


searchShortestPath : PuzzlePart -> Grid -> Int
searchShortestPath part grid =
    grid
        |> getStartPositions part
        |> walk grid Set.empty


getStartPositions : PuzzlePart -> Grid -> Set.Set Position
getStartPositions part grid =
    let
        filterFn =
            case part of
                PartA ->
                    \_ squ ->
                        case squ of
                            Start ->
                                True

                            _ ->
                                False

                PartB ->
                    \_ squ ->
                        case squ of
                            Start ->
                                True

                            OnTheWay h ->
                                h == Char.toCode 'a'

                            End ->
                                False
    in
    grid
        |> Dict.filter filterFn
        |> Dict.keys
        |> Set.fromList


walk : Grid -> Set.Set Position -> Set.Set Position -> Int
walk grid visited positions =
    if positions |> foundEnd grid then
        0

    else
        let
            newVisited =
                Set.union visited positions
        in
        (positions |> nextLayer grid newVisited |> walk grid newVisited) + 1


nextLayer : Grid -> Set.Set Position -> Set.Set Position -> Set.Set Position
nextLayer grid visited current =
    let
        fn : Position -> Set.Set Position -> Set.Set Position
        fn position all =
            case grid |> Dict.get position of
                Just (OnTheWay h) ->
                    Set.diff (Set.union all (position |> getNeighbours grid h)) visited

                Just Start ->
                    Set.diff (Set.union all (position |> getNeighbours grid (Char.toCode 'a'))) visited

                _ ->
                    Set.empty
    in
    current |> Set.foldl fn Set.empty


getNeighbours : Grid -> Int -> Position -> Set.Set Position
getNeighbours grid height ( x, y ) =
    let
        filterFn pos =
            case grid |> Dict.get pos of
                Just End ->
                    (height + 1) >= Char.toCode 'z'

                Just (OnTheWay i) ->
                    (height + 1) >= i

                _ ->
                    False
    in
    [ ( x - 1, y ), ( x + 1, y ), ( x, y - 1 ), ( x, y + 1 ) ]
        |> List.filter filterFn
        |> Set.fromList


foundEnd : Grid -> Set.Set Position -> Bool
foundEnd grid positions =
    positions
        |> Set.toList
        |> List.any
            (\pos ->
                case grid |> Dict.get pos of
                    Just End ->
                        True

                    _ ->
                        False
            )
