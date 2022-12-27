module Day22 exposing (run)

import Dict
import Parser exposing ((|.), (|=))


run : String -> ( String, String )
run puzzleInput =
    ( runPartA puzzleInput, "No solution" )


runPartA : String -> String
runPartA puzzleInput =
    case puzzleInput |> Parser.run puzzleParser of
        Ok ( map, commands ) ->
            let
                startPos =
                    map.locations
                        |> Dict.keys
                        |> List.filter (\( _, line ) -> line == 0)
                        |> List.head
                        |> Maybe.withDefault ( 0, 0 )

                ( ( x, y ), direction ) =
                    startPos |> walk map East commands
            in
            ((y + 1) * 1000) + ((x + 1) * 4) + (direction |> directionToFacing) |> String.fromInt

        Err _ ->
            "Error"



-- Parse


type Location
    = Open
    | Wall


type alias Position =
    ( Int, Int )


type alias Map =
    { locations : Dict.Dict Position Location
    , width : Int
    , height : Int
    }


type Command
    = TurnRight
    | TurnLeft
    | Walk Int


puzzleParser : Parser.Parser ( Map, List Command )
puzzleParser =
    Parser.succeed Tuple.pair
        |= mapParser
        |= commandListParser


mapParser : Parser.Parser Map
mapParser =
    Parser.loop Dict.empty
        (\dict ->
            Parser.oneOf
                [ Parser.symbol "\n\n" |> Parser.map (\() -> Parser.Done (locationsToMap dict))
                , Parser.oneOf [ Parser.symbol " ", Parser.symbol "\n" ]
                    |> Parser.map (\_ -> Parser.Loop dict)
                , Parser.succeed (\( line, column ) location -> Parser.Loop (Dict.insert ( column - 1, line - 1 ) location dict))
                    |= Parser.getPosition
                    |= Parser.oneOf
                        [ Parser.succeed Wall
                            |. Parser.symbol "#"
                        , Parser.succeed Open
                            |. Parser.symbol "."
                        ]
                ]
        )


locationsToMap : Dict.Dict Position Location -> Map
locationsToMap locations =
    let
        ( width, height ) =
            locations
                |> Dict.keys
                |> List.foldl
                    (\( x, y ) ( w, h ) -> ( max x w, max y h ))
                    ( 0, 0 )
    in
    { locations = locations, width = width + 1, height = height + 1 }


commandListParser : Parser.Parser (List Command)
commandListParser =
    Parser.loop []
        (\list ->
            Parser.oneOf
                [ commandParser |> Parser.map (\c -> Parser.Loop (c :: list))
                , Parser.oneOf
                    [ Parser.symbol "\n", Parser.end ]
                    |> Parser.map (\() -> Parser.Done (List.reverse list))
                ]
        )


commandParser : Parser.Parser Command
commandParser =
    Parser.oneOf
        [ Parser.succeed TurnRight
            |. Parser.symbol "R"
        , Parser.succeed TurnLeft
            |. Parser.symbol "L"
        , Parser.succeed (\i -> Walk i)
            |= Parser.int
        ]



-- Run


walk : Map -> Direction -> List Command -> Position -> ( Position, Direction )
walk map currentDirection commands currentPos =
    case currentPos |> always commands of
        [] ->
            ( currentPos, currentDirection )

        TurnRight :: nextCommands ->
            walk map (turnRight currentDirection) nextCommands currentPos

        TurnLeft :: nextCommands ->
            walk map (turnLeft currentDirection) nextCommands currentPos

        (Walk steps) :: nextCommands ->
            walkStep map currentDirection steps currentPos
                |> walk map currentDirection nextCommands


walkStep : Map -> Direction -> Int -> Position -> Position
walkStep map currentDirection steps currentPos =
    if steps == 0 then
        currentPos

    else
        case nextLocation map currentDirection currentPos of
            Nothing ->
                currentPos

            Just newPos ->
                walkStep map currentDirection (steps - 1) newPos


nextLocation : Map -> Direction -> Position -> Maybe Position
nextLocation ({ locations, width, height } as map) currentDirection ( x, y ) =
    let
        nextLoc =
            case currentDirection of
                North ->
                    ( x, y - 1 |> modBy height )

                South ->
                    ( x, y + 1 |> modBy height )

                West ->
                    ( x - 1 |> modBy width, y )

                East ->
                    ( x + 1 |> modBy width, y )
    in
    case locations |> Dict.get nextLoc of
        Just Wall ->
            Nothing

        Just Open ->
            Just nextLoc

        Nothing ->
            nextLocation map currentDirection nextLoc


type Direction
    = North
    | South
    | West
    | East


directionToFacing : Direction -> Int
directionToFacing dir =
    case dir of
        North ->
            3

        South ->
            1

        West ->
            2

        East ->
            0


turnRight : Direction -> Direction
turnRight dir =
    case dir of
        North ->
            East

        South ->
            West

        West ->
            North

        East ->
            South


turnLeft : Direction -> Direction
turnLeft dir =
    case dir of
        North ->
            West

        South ->
            East

        West ->
            South

        East ->
            North
