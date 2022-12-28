module Day22 exposing (run)

import Dict
import Parser exposing ((|.), (|=))


run : String -> ( String, String )
run puzzleInput =
    ( runPart PuzzlePartA puzzleInput, runPart PuzzlePartB puzzleInput )


type PuzzlePart
    = PuzzlePartA
    | PuzzlePartB


runPart : PuzzlePart -> String -> String
runPart puzzlePart puzzleInput =
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
                    walk puzzlePart map commands ( startPos, East )
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


walk : PuzzlePart -> Map -> List Command -> ( Position, Direction ) -> ( Position, Direction )
walk puzzlePart map commands ( currentPos, currentDirection ) =
    case currentPos |> always commands of
        [] ->
            ( currentPos, currentDirection )

        TurnRight :: nextCommands ->
            walk puzzlePart map nextCommands ( currentPos, turnRight currentDirection )

        TurnLeft :: nextCommands ->
            walk puzzlePart map nextCommands ( currentPos, turnLeft currentDirection )

        (Walk steps) :: nextCommands ->
            walkStep puzzlePart map steps ( currentPos, currentDirection )
                |> walk puzzlePart map nextCommands


walkStep : PuzzlePart -> Map -> Int -> ( Position, Direction ) -> ( Position, Direction )
walkStep puzzlePart map steps vector =
    if steps == 0 then
        vector

    else
        case nextLocation puzzlePart map vector of
            Nothing ->
                vector

            Just new ->
                walkStep puzzlePart map (steps - 1) new


nextLocation : PuzzlePart -> Map -> ( Position, Direction ) -> Maybe ( Position, Direction )
nextLocation puzzlePart map vector =
    let
        ( nextLoc, nextDir ) =
            nextLocationHelperA map vector
    in
    case map.locations |> Dict.get nextLoc of
        Just Wall ->
            Nothing

        Just Open ->
            Just ( nextLoc, nextDir )

        Nothing ->
            case puzzlePart of
                PuzzlePartA ->
                    nextLocation puzzlePart map ( nextLoc, nextDir )

                PuzzlePartB ->
                    Just <| switchCube (getCube vector) ( nextLoc, nextDir )


nextLocationHelperA : Map -> ( Position, Direction ) -> ( Position, Direction )
nextLocationHelperA map ( ( x, y ), currentDirection ) =
    ( case currentDirection of
        North ->
            ( x, y - 1 |> modBy map.height )

        South ->
            ( x, y + 1 |> modBy map.height )

        West ->
            ( x - 1 |> modBy map.width, y )

        East ->
            ( x + 1 |> modBy map.width, y )
    , currentDirection
    )


type Cube
    = Front
    | Top
    | Bottom
    | Left
    | Right
    | Rear


switchCube : Cube -> ( Position, Direction ) -> ( Position, Direction )
switchCube whereAmI ( ( x, y ), currentDirection ) =
    case ( whereAmI, currentDirection ) of
        ( Front, North ) ->
            ( ( x, y ), North )

        ( Front, South ) ->
            ( ( x, y ), South )

        ( Front, West ) ->
            ( ( y - 50, 100 ), South )

        ( Front, East ) ->
            ( ( y + 50, 49 ), North )

        ( Top, North ) ->
            ( ( 0, x + 100 ), East )

        ( Top, South ) ->
            ( ( x, y ), South )

        ( Top, West ) ->
            ( ( 0, 149 - y ), East )

        ( Top, East ) ->
            ( ( x, y ), East )

        ( Bottom, North ) ->
            ( ( x, y ), North )

        ( Bottom, South ) ->
            ( ( 49, x + 100 ), West )

        ( Bottom, West ) ->
            ( ( x, y ), West )

        ( Bottom, East ) ->
            ( ( 149, 149 - y ), West )

        ( Left, North ) ->
            ( ( 50, x + 50 ), East )

        ( Left, South ) ->
            ( ( x, y ), South )

        ( Left, West ) ->
            ( ( 50, 149 - y ), East )

        ( Left, East ) ->
            ( ( x, y ), East )

        ( Right, North ) ->
            ( ( x - 100, 199 ), North )

        ( Right, South ) ->
            ( ( 99, x - 50 ), West )

        ( Right, West ) ->
            ( ( x, y ), West )

        ( Right, East ) ->
            ( ( 99, 149 - y ), West )

        ( Rear, North ) ->
            ( ( x, y ), North )

        ( Rear, South ) ->
            ( ( x + 100, 0 ), South )

        ( Rear, West ) ->
            ( ( y - 100, 0 ), South )

        ( Rear, East ) ->
            ( ( y - 100, 149 ), North )


getCube : ( Position, Direction ) -> Cube
getCube ( ( x, y ), _ ) =
    if y < 50 then
        if x < 100 then
            Top

        else
            Right

    else if y < 100 then
        Front

    else if y < 150 then
        if x < 50 then
            Left

        else
            Bottom

    else
        Rear


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
