module Day14 exposing (run)

import Parser exposing ((|.), (|=))
import Set


run : String -> ( String, String )
run puzzleInput =
    ( runPartA puzzleInput, "No solution" )


runPartA : String -> String
runPartA puzzleInput =
    case puzzleInput |> Parser.run puzzleInputParser of
        Ok rockPaths ->
            rockPaths
                |> toRockPoints
                |> dropSand
                |> String.fromInt

        Err _ ->
            "Error"


type alias RockPath =
    List Position


type alias Position =
    ( Int, Int )


puzzleInputParser : Parser.Parser (List RockPath)
puzzleInputParser =
    Parser.loop []
        (\rockPathList ->
            Parser.oneOf
                [ rockPathParser
                    |> Parser.map (\rp -> Parser.Loop (rp :: rockPathList))
                , (Parser.succeed () |. Parser.end)
                    |> Parser.map (\_ -> Parser.Done (List.reverse rockPathList))
                ]
        )


rockPathParser : Parser.Parser RockPath
rockPathParser =
    Parser.sequence
        { start = ""
        , separator = "->"
        , end = "\n"
        , spaces = Parser.chompWhile (\c -> c == ' ')
        , item =
            Parser.succeed (\a b -> ( a, b ))
                |= Parser.int
                |. Parser.symbol ","
                |= Parser.int
        , trailing = Parser.Forbidden
        }


toRockPoints : List RockPath -> Set.Set Position
toRockPoints rockPaths =
    let
        pathFunc : RockPath -> Set.Set Position -> Set.Set Position
        pathFunc path acc =
            path
                |> List.foldl pointFunc { res = acc, current = Nothing }
                |> .res

        pointFunc : Position -> { res : Set.Set Position, current : Maybe Position } -> { res : Set.Set Position, current : Maybe Position }
        pointFunc point acc =
            { current = Just point
            , res =
                case acc.current of
                    Nothing ->
                        acc.res |> Set.insert point

                    Just oldPoint ->
                        acc.res |> Set.union (rockLine oldPoint point)
            }
    in
    rockPaths |> List.foldl pathFunc Set.empty


rockLine : Position -> Position -> Set.Set Position
rockLine ( x1, y1 ) ( x2, y2 ) =
    (if x1 == x2 then
        (if y1 < y2 then
            List.range y1 y2

         else
            List.range y2 y1
        )
            |> List.map (\y -> ( x1, y ))

     else if y1 == y2 then
        (if x1 < x2 then
            List.range x1 x2

         else
            List.range x2 x1
        )
            |> List.map (\x -> ( x, y1 ))

     else
        []
    )
        |> Set.fromList


dropSand : Set.Set Position -> Int
dropSand rocks =
    let
        lowestRock : Int
        lowestRock =
            rocks
                |> Set.toList
                |> List.map (\( _, y ) -> y)
                |> List.sort
                |> List.reverse
                |> List.head
                |> Maybe.withDefault 0
    in
    Set.size (walk lowestRock rocks) - Set.size rocks


walk : Int -> Set.Set Position -> Set.Set Position
walk lowest points =
    sandUntil lowest points ( 500, 0 )


sandUntil : Int -> Set.Set Position -> Position -> Set.Set Position
sandUntil lowest points ( x, y ) =
    if y > lowest then
        points

    else if points |> Set.member ( x, y + 1 ) |> not then
        sandUntil lowest points ( x, y + 1 )

    else if points |> Set.member ( x - 1, y + 1 ) |> not then
        sandUntil lowest points ( x - 1, y + 1 )

    else if points |> Set.member ( x + 1, y + 1 ) |> not then
        sandUntil lowest points ( x + 1, y + 1 )

    else
        points |> Set.insert ( x, y ) |> walk lowest
