module Day09 exposing (run)

import Dict
import List exposing (length)
import Set


run : String -> ( String, String )
run puzzleInput =
    ( runInner puzzleInput 2, runInner puzzleInput 10 )


runInner : String -> Int -> String
runInner puzzleInput length =
    puzzleInput
        |> parseMoves
        |> List.foldl (move length) (startGrid length)
        |> .visited
        |> Set.size
        |> String.fromInt


type Move
    = Right Int
    | Left Int
    | Up Int
    | Down Int


parseMoves : String -> List Move
parseMoves puzzleInput =
    puzzleInput
        |> String.lines
        |> List.filterMap
            (\line ->
                let
                    elements : List String
                    elements =
                        line |> String.split " "

                    getNum : Maybe Int
                    getNum =
                        elements
                            |> List.drop 1
                            |> List.head
                            |> Maybe.andThen String.toInt

                    getChar : Maybe String
                    getChar =
                        elements
                            |> List.head
                in
                getNum
                    |> Maybe.andThen
                        (\num ->
                            getChar
                                |> Maybe.andThen
                                    (\char ->
                                        case char of
                                            "R" ->
                                                Just <| Right num

                                            "L" ->
                                                Just <| Left num

                                            "U" ->
                                                Just <| Up num

                                            "D" ->
                                                Just <| Down num

                                            _ ->
                                                Nothing
                                    )
                        )
            )


type alias Grid =
    { visited : Set.Set Position
    , rope : Rope
    }


type alias Position =
    ( Int, Int )


type alias Rope =
    Dict.Dict Int Position


startGrid : Int -> Grid
startGrid length =
    let
        newRope : Rope
        newRope =
            List.range 0 (length - 1)
                |> List.map (Tuple.pair ( 0, 0 ))
                |> List.map (\( a, b ) -> ( b, a ))
                |> Dict.fromList
    in
    { visited = Set.empty
    , rope = newRope
    }


move : Int -> Move -> Grid -> Grid
move length m grid =
    case m of
        Right i ->
            List.repeat i () |> List.foldl (singleMove length toRight) grid

        Left i ->
            List.repeat i () |> List.foldl (singleMove length toLeft) grid

        Up i ->
            List.repeat i () |> List.foldl (singleMove length toUp) grid

        Down i ->
            List.repeat i () |> List.foldl (singleMove length toDown) grid


toRight : Position -> Position
toRight ( x, y ) =
    ( x + 1, y )


toLeft : Position -> Position
toLeft ( x, y ) =
    ( x - 1, y )


toUp : Position -> Position
toUp ( x, y ) =
    ( x, y + 1 )


toDown : Position -> Position
toDown ( x, y ) =
    ( x, y - 1 )


singleMove : Int -> (Position -> Position) -> () -> Grid -> Grid
singleMove length moveFunc _ grid =
    let
        newRope : Rope
        newRope =
            List.range 0 (length - 1) |> List.foldl (innerMove moveFunc) grid.rope

        newVisited =
            case newRope |> Dict.get (length - 1) of
                Just pos ->
                    grid.visited |> Set.insert pos

                Nothing ->
                    grid.visited
    in
    { grid | rope = newRope, visited = newVisited }


innerMove : (Position -> Position) -> Int -> Rope -> Rope
innerMove moveFunc id rope =
    case rope |> Dict.get id of
        Nothing ->
            rope

        Just element ->
            case rope |> Dict.get (id - 1) of
                Nothing ->
                    -- If there is no parent we handle the head of the rope.
                    rope |> Dict.insert id (element |> moveFunc)

                Just parent ->
                    if element |> isAdjacentTo parent then
                        -- We do not have to change anything in this case.
                        rope

                    else if element |> isInLineWith parent then
                        -- Make the same move in line.
                        rope |> Dict.insert id (directMove element parent)

                    else
                        rope |> Dict.insert id (diagonalMove element parent)


isAdjacentTo : Position -> Position -> Bool
isAdjacentTo ( x1, y1 ) ( x2, y2 ) =
    (abs (x1 - x2) <= 1) && (abs (y1 - y2) <= 1)


isInLineWith : Position -> Position -> Bool
isInLineWith ( x1, y1 ) ( x2, y2 ) =
    (x1 == x2) || (y1 == y2)


directMove : Position -> Position -> Position
directMove ( x1, y1 ) ( x2, y2 ) =
    if x1 == x2 then
        ( x1
        , if y2 > y1 then
            y1 + 1

          else
            y1 - 1
        )

    else
        ( if x2 > x1 then
            x1 + 1

          else
            x1 - 1
        , y1
        )


diagonalMove : Position -> Position -> Position
diagonalMove ( x1, y1 ) ( x2, y2 ) =
    ( if x2 > x1 then
        x1 + 1

      else
        x1 - 1
    , if y2 > y1 then
        y1 + 1

      else
        y1 - 1
    )
