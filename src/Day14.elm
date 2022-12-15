module Day14 exposing (run)

import Parser exposing ((|.), (|=))
import Set


run : String -> ( String, String )
run puzzleInput =
    ( runPart puzzleInput PuzzlePartA, runPart puzzleInput PuzzlePartB )


type PuzzlePart
    = PuzzlePartA
    | PuzzlePartB


runPart : String -> PuzzlePart -> String
runPart puzzleInput puzzlePart =
    case puzzleInput |> Parser.run puzzleInputParser of
        Ok rockPaths ->
            let
                rocks : Set.Set Position
                rocks =
                    rockPaths
                        |> toRockPoints
            in
            rocks
                |> dropSand puzzlePart
                |> Tuple.first
                |> String.fromInt

        --|> Tuple.second
        --|> changeToGrid rocks
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
                |> List.foldl pointFunc { res = acc, previous = Nothing }
                |> .res

        pointFunc : Position -> { res : Set.Set Position, previous : Maybe Position } -> { res : Set.Set Position, previous : Maybe Position }
        pointFunc point acc =
            { previous = Just point
            , res =
                case acc.previous of
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


dropSand : PuzzlePart -> Set.Set Position -> ( Int, Set.Set Position )
dropSand puzzlePart rocks =
    let
        lowestRock : Int
        lowestRock =
            rocks
                |> Set.toList
                |> List.map Tuple.second
                |> List.sort
                |> List.reverse
                |> List.head
                |> Maybe.withDefault 0

        newPoints : Set.Set Position
        newPoints =
            walk puzzlePart lowestRock rocks
    in
    ( Set.size newPoints - Set.size rocks, newPoints )


walk : PuzzlePart -> Int -> Set.Set Position -> Set.Set Position
walk puzzlePart lowest points =
    let
        newPoints =
            sandUntil puzzlePart lowest points ( 500, 0 )

        condition =
            case puzzlePart of
                PuzzlePartA ->
                    Set.size newPoints == Set.size points

                PuzzlePartB ->
                    newPoints |> Set.member ( 500, 0 )
    in
    if condition then
        newPoints

    else
        walk puzzlePart lowest newPoints


sandUntil : PuzzlePart -> Int -> Set.Set Position -> Position -> Set.Set Position
sandUntil puzzlePart lowest points ( x, y ) =
    if y > lowest then
        case puzzlePart of
            PuzzlePartA ->
                points

            PuzzlePartB ->
                points |> Set.insert ( x, y )

    else if points |> Set.member ( x, y + 1 ) |> not then
        sandUntil puzzlePart lowest points ( x, y + 1 )

    else if points |> Set.member ( x - 1, y + 1 ) |> not then
        sandUntil puzzlePart lowest points ( x - 1, y + 1 )

    else if points |> Set.member ( x + 1, y + 1 ) |> not then
        sandUntil puzzlePart lowest points ( x + 1, y + 1 )

    else if y == 0 then
        points |> Set.insert ( x, y )

    else
        points |> Set.insert ( x, y )



-- Draw
-- changeToGrid : Set.Set Position -> Set.Set Position -> String
-- changeToGrid rocks points =
--     let
--         border : { xMin : Int, xMax : Int, yMin : Int, yMax : Int }
--         border =
--             points |> Set.foldl fn { xMin = 0, xMax = 0, yMin = 0, yMax = 0 }
--         fn ( x, y ) acc =
--             { xMin = min x acc.xMin
--             , xMax = max x acc.xMax
--             , yMin = min y acc.yMin
--             , yMax = max y acc.yMax
--             }
--     in
--     List.range border.yMin border.yMax
--         |> List.foldl
--             (\y acc1 ->
--                 (List.range border.xMin border.xMax
--                     |> List.foldl
--                         (\x acc2 ->
--                             acc2
--                                 ++ (if Set.member ( x, y ) rocks then
--                                         "#"
--                                     else if Set.member ( x, y ) points then
--                                         "o"
--                                     else
--                                         "."
--                                    )
--                         )
--                         ""
--                 )
--                     :: acc1
--             )
--             []
--         |> List.reverse
--         |> String.join "\n"
