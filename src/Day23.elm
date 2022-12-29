module Day23 exposing (run)

import Parser exposing ((|.), (|=))
import Set


run : String -> ( String, String )
run puzzleInput =
    ( runPartA puzzleInput, "No solution" )


runPartA : String -> String
runPartA puzzleInput =
    case puzzleInput |> Parser.run puzzleParser of
        Ok elves ->
            let
                movedElves =
                    elves |> moveElves 10

                xValues : List Int
                xValues =
                    movedElves |> Set.toList |> List.map Tuple.first

                yValues : List Int
                yValues =
                    movedElves |> Set.toList |> List.map Tuple.second

                diff : List Int -> Int
                diff values =
                    let
                        max : Maybe Int
                        max =
                            List.maximum values

                        min : Maybe Int
                        min =
                            List.minimum values
                    in
                    case ( max, min ) of
                        ( Just maxi, Just mini ) ->
                            maxi - mini + 1

                        _ ->
                            0
            in
            ((diff xValues * diff yValues) - (movedElves |> Set.size))
                |> String.fromInt

        Err _ ->
            "Error"


type alias Elves =
    Set.Set Position


type alias Position =
    ( Int, Int )


puzzleParser : Parser.Parser Elves
puzzleParser =
    Parser.loop Set.empty
        (\elves ->
            Parser.oneOf
                [ Parser.backtrackable <|
                    Parser.succeed (\( row, col ) -> elves |> Set.insert ( col, row ) |> Parser.Loop)
                        |. Parser.chompWhile (\c -> c /= '#')
                        |= Parser.getPosition
                        |. Parser.symbol "#"
                , (Parser.succeed ()
                    |. Parser.chompWhile (\c -> c /= '#')
                    |. Parser.end
                  )
                    |> Parser.map (\_ -> Parser.Done elves)
                ]
        )


moveElves : Int -> Elves -> Elves
moveElves rounds elves =
    List.range 0 (rounds - 1)
        |> List.foldl moveOneRound elves


type alias MovingElves =
    { north : Elves
    , south : Elves
    , west : Elves
    , east : Elves
    , dontMove : Elves
    }


emptyMove : MovingElves
emptyMove =
    { north = Set.empty
    , south = Set.empty
    , west = Set.empty
    , east = Set.empty
    , dontMove = Set.empty
    }


type Action
    = DontMove
    | Move Move


type Move
    = North
    | South
    | West
    | East


type Direction
    = N
    | NE
    | NW
    | S
    | SE
    | SW
    | W
    | E


actionPriority : Int -> List Action
actionPriority round =
    case round |> modBy 4 of
        0 ->
            [ DontMove, Move North, Move South, Move West, Move East ]

        1 ->
            [ DontMove, Move South, Move West, Move East, Move North ]

        2 ->
            [ DontMove, Move West, Move East, Move North, Move South ]

        3 ->
            [ DontMove, Move East, Move North, Move South, Move West ]

        _ ->
            [ DontMove ]


moveOneRound : Int -> Elves -> Elves
moveOneRound round elves =
    elves
        |> Set.foldl (whereToMove elves (actionPriority round)) emptyMove
        |> checkCollision
        |> processMove


whereToMove : Elves -> List Action -> Position -> MovingElves -> MovingElves
whereToMove elves actions elve movingElves =
    case actions of
        [] ->
            { movingElves | dontMove = movingElves.dontMove |> Set.insert elve }

        action :: nextActions ->
            case action of
                DontMove ->
                    if elve |> free elves [ N, NW, NE, S, SE, SW, W, E ] then
                        { movingElves | dontMove = movingElves.dontMove |> Set.insert elve }

                    else
                        whereToMove elves nextActions elve movingElves

                Move North ->
                    if elve |> free elves [ N, NW, NE ] then
                        { movingElves | north = movingElves.north |> Set.insert elve }

                    else
                        whereToMove elves nextActions elve movingElves

                Move South ->
                    if elve |> free elves [ S, SE, SW ] then
                        { movingElves | south = movingElves.south |> Set.insert elve }

                    else
                        whereToMove elves nextActions elve movingElves

                Move West ->
                    if elve |> free elves [ W, NW, SW ] then
                        { movingElves | west = movingElves.west |> Set.insert elve }

                    else
                        whereToMove elves nextActions elve movingElves

                Move East ->
                    if elve |> free elves [ E, NE, SE ] then
                        { movingElves | east = movingElves.east |> Set.insert elve }

                    else
                        whereToMove elves nextActions elve movingElves


free : Elves -> List Direction -> Position -> Bool
free elves directions ( x, y ) =
    directions
        |> List.any
            (\dir ->
                elves
                    |> Set.member
                        (case dir of
                            N ->
                                ( x, y - 1 )

                            NE ->
                                ( x + 1, y - 1 )

                            NW ->
                                ( x - 1, y - 1 )

                            S ->
                                ( x, y + 1 )

                            SE ->
                                ( x + 1, y + 1 )

                            SW ->
                                ( x - 1, y + 1 )

                            W ->
                                ( x - 1, y )

                            E ->
                                ( x + 1, y )
                        )
            )
        |> not


checkCollision : MovingElves -> MovingElves
checkCollision movingElves =
    let
        foldFn : Move -> Position -> ( Elves, Elves ) -> ( Elves, Elves )
        foldFn move ( x, y ) ( new, rest ) =
            case move of
                North ->
                    if movingElves.south |> Set.member ( x, y - 2 ) then
                        ( new, rest |> Set.insert ( x, y ) )

                    else
                        ( new |> Set.insert ( x, y ), rest )

                South ->
                    if movingElves.north |> Set.member ( x, y + 2 ) then
                        ( new, rest |> Set.insert ( x, y ) )

                    else
                        ( new |> Set.insert ( x, y ), rest )

                West ->
                    if movingElves.east |> Set.member ( x - 2, y ) then
                        ( new, rest |> Set.insert ( x, y ) )

                    else
                        ( new |> Set.insert ( x, y ), rest )

                East ->
                    if movingElves.west |> Set.member ( x + 2, y ) then
                        ( new, rest |> Set.insert ( x, y ) )

                    else
                        ( new |> Set.insert ( x, y ), rest )

        ( newNorth, restFromNorth ) =
            movingElves.north |> Set.foldl (foldFn North) ( Set.empty, Set.empty )

        ( newSouth, restFromSouth ) =
            movingElves.south |> Set.foldl (foldFn South) ( Set.empty, Set.empty )

        ( newWest, restFromWest ) =
            movingElves.west |> Set.foldl (foldFn West) ( Set.empty, Set.empty )

        ( newEast, restFromEast ) =
            movingElves.east |> Set.foldl (foldFn East) ( Set.empty, Set.empty )
    in
    { north = newNorth
    , south = newSouth
    , west = newWest
    , east = newEast
    , dontMove =
        movingElves.dontMove
            |> Set.union restFromNorth
            |> Set.union restFromSouth
            |> Set.union restFromWest
            |> Set.union restFromEast
    }


processMove : MovingElves -> Elves
processMove movingElves =
    let
        n : Elves
        n =
            movingElves.north |> Set.map (\( x, y ) -> ( x, y - 1 ))

        s : Elves
        s =
            movingElves.south |> Set.map (\( x, y ) -> ( x, y + 1 ))

        w : Elves
        w =
            movingElves.west |> Set.map (\( x, y ) -> ( x - 1, y ))

        e : Elves
        e =
            movingElves.east |> Set.map (\( x, y ) -> ( x + 1, y ))
    in
    movingElves.dontMove
        |> Set.union n
        |> Set.union s
        |> Set.union w
        |> Set.union e
