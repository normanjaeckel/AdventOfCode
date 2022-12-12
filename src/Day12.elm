module Day12 exposing (run)

import Dict
import Parser exposing ((|.), (|=))
import Set


run : String -> ( String, String )
run puzzleInput =
    ( runPartA puzzleInput, "No solution" )


runPartA : String -> String
runPartA puzzleInput =
    case puzzleInput |> Parser.run gridParser of
        Ok grid ->
            grid
                |> searchShortestPath
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
    Parser.loop Dict.empty areaParserHelper


areaParserHelper : Grid -> Parser.Parser (Parser.Step Grid Grid)
areaParserHelper area =
    Parser.oneOf
        [ Parser.succeed (\p s -> area |> Dict.insert p s |> Parser.Loop)
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
        , (Parser.succeed ()
            |. Parser.end
          )
            |> Parser.map (\_ -> Parser.Done area)
        ]


heightParser : Parser.Parser Int
heightParser =
    let
        fn : String -> Int
        fn s =
            s
                |> String.toList
                |> List.head
                |> Maybe.withDefault 'a'
                |> Char.toCode

        --|> (+) -96
    in
    Parser.chompIf Char.isLower
        |> Parser.getChompedString
        |> Parser.map fn



-- Search


searchShortestPath : Grid -> Int
searchShortestPath grid =
    [ grid |> getStartPosition ] |> Set.fromList |> walk grid Set.empty


getStartPosition : Grid -> Position
getStartPosition grid =
    grid
        |> Dict.filter
            (\_ s ->
                case s of
                    Start ->
                        True

                    _ ->
                        False
            )
        |> Dict.toList
        |> List.head
        |> Maybe.withDefault ( ( 0, 0 ), Start )
        |> Tuple.first


walk : Grid -> Set.Set Position -> Set.Set Position -> Int
walk grid visited pos =
    if pos |> foundEnd grid then
        0

    else
        let
            newVisited =
                Set.union visited pos
        in
        (pos |> nextLayer grid newVisited |> walk grid newVisited) + 1


nextLayer : Grid -> Set.Set Position -> Set.Set Position -> Set.Set Position
nextLayer grid visited current =
    let
        fn : Position -> Set.Set Position -> Set.Set Position
        fn pos all =
            let
                squ : Square
                squ =
                    grid |> Dict.get pos |> Maybe.withDefault End
            in
            case squ of
                End ->
                    Set.empty

                OnTheWay h ->
                    Set.diff (Set.union all (pos |> getNeighbours grid h)) visited

                Start ->
                    Set.diff (Set.union all (pos |> getNeighbours grid (Char.toCode 'a'))) visited
    in
    current |> Set.foldl fn Set.empty


getNeighbours : Grid -> Int -> Position -> Set.Set Position
getNeighbours grid height ( x, y ) =
    let
        filterFn pos =
            case grid |> Dict.get pos |> Maybe.withDefault Start of
                Start ->
                    False

                End ->
                    (height + 1) >= Char.toCode 'z'

                OnTheWay i ->
                    (height + 1) >= i
    in
    [ ( x - 1, y ), ( x + 1, y ), ( x, y - 1 ), ( x, y + 2 ) ]
        |> List.filter filterFn
        |> Set.fromList


foundEnd : Grid -> Set.Set Position -> Bool
foundEnd grid pos =
    pos
        |> Set.toList
        |> List.any
            (\p ->
                case grid |> Dict.get p |> Maybe.withDefault Start of
                    End ->
                        True

                    _ ->
                        False
            )
