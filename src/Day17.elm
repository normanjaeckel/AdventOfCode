module Day17 exposing (run)

import Array
import Dict
import Set


run : String -> ( String, String )
run puzzleInput =
    if puzzleInput == "" then
        ( "No input", "No input" )

    else
        ( runPartA puzzleInput, runPartB puzzleInput )


runPartA : String -> String
runPartA puzzleInput =
    let
        allJets : Array.Array Char
        allJets =
            puzzleInput |> String.trim |> String.toList |> Array.fromList

        startCave : Set.Set Position
        startCave =
            [ ( 1, 0 ), ( 2, 0 ), ( 3, 0 ), ( 4, 0 ), ( 5, 0 ), ( 6, 0 ), ( 7, 0 ) ]
                |> Set.fromList

        lastRockIndex : Int
        lastRockIndex =
            2022 - 1
    in
    rocksDown allJets lastRockIndex { rockIndex = 0, hotGasIndex = 0, cave = startCave }
        |> .cave
        |> Set.toList
        |> List.map Tuple.second
        |> List.maximum
        |> Maybe.withDefault 0
        |> String.fromInt


type RockShape
    = Minus
    | Plus
    | Nook
    | Bar
    | Box


type alias Position =
    ( Int, Int )


rockType : Int -> RockShape
rockType i =
    case i of
        0 ->
            Minus

        1 ->
            Plus

        2 ->
            Nook

        3 ->
            Bar

        _ ->
            -- Hint: We do not catch greater numbers here.
            Box


newRock : RockShape -> Int -> Set.Set Position
newRock rock row =
    Set.fromList
        (case rock of
            Minus ->
                [ ( 3, row ), ( 4, row ), ( 5, row ), ( 6, row ) ]

            Plus ->
                [ ( 4, row ), ( 3, row + 1 ), ( 4, row + 1 ), ( 5, row + 1 ), ( 4, row + 2 ) ]

            Nook ->
                [ ( 3, row ), ( 4, row ), ( 5, row ), ( 5, row + 1 ), ( 5, row + 2 ) ]

            Bar ->
                [ ( 3, row ), ( 3, row + 1 ), ( 3, row + 2 ), ( 3, row + 3 ) ]

            Box ->
                [ ( 3, row ), ( 4, row ), ( 3, row + 1 ), ( 4, row + 1 ) ]
        )


rocksDown : Array.Array Char -> Int -> Accumulator -> Accumulator
rocksDown allJets lastRock acc =
    if acc.rockIndex > lastRock then
        acc

    else
        let
            newAcc =
                rockInCave allJets acc
        in
        rocksDown allJets lastRock newAcc


type alias Accumulator =
    { rockIndex : Int, hotGasIndex : Int, cave : Set.Set Position }


rockInCave : Array.Array Char -> Accumulator -> Accumulator
rockInCave allJets acc =
    let
        nextRock : RockShape
        nextRock =
            acc.rockIndex |> modBy 5 |> rockType

        rockPos : Set.Set Position
        rockPos =
            newRock nextRock (heightOf acc.cave + 4)
    in
    rockFalls allJets acc.rockIndex acc.hotGasIndex rockPos acc.cave


rockFalls : Array.Array Char -> Int -> Int -> Set.Set Position -> Set.Set Position -> Accumulator
rockFalls allJets rockNum hotGasIndex rock cave =
    let
        nextDirection : Char
        nextDirection =
            allJets |> Array.get (hotGasIndex |> modBy (Array.length allJets)) |> Maybe.withDefault '?'

        newRockA : Set.Set Position
        newRockA =
            rock |> blowTo cave nextDirection

        newRockB : Set.Set Position
        newRockB =
            newRockA |> Set.map (\( x, y ) -> ( x, y - 1 ))
    in
    if newRockB |> collidesWith cave then
        { rockIndex = rockNum + 1, hotGasIndex = hotGasIndex + 1, cave = cave |> Set.union newRockA }

    else
        rockFalls allJets rockNum (hotGasIndex + 1) newRockB cave


collidesWith : Set.Set Position -> Set.Set Position -> Bool
collidesWith cave rock =
    Set.intersect cave rock |> Set.isEmpty |> not


blowTo : Set.Set Position -> Char -> Set.Set Position -> Set.Set Position
blowTo cave direction rock =
    let
        dirFn : Int -> Int
        dirFn =
            case direction of
                '<' ->
                    \i -> i - 1

                '>' ->
                    (+) 1

                _ ->
                    identity

        movedRock : Set.Set Position
        movedRock =
            rock |> Set.map (\( x, y ) -> ( dirFn x, y ))
    in
    if
        (movedRock |> Set.toList |> List.any (\( x, _ ) -> x < 1 || x > 7))
            || (movedRock |> collidesWith cave)
    then
        rock

    else
        movedRock


heightOf : Set.Set Position -> Int
heightOf cave =
    cave
        |> Set.toList
        |> List.map Tuple.second
        |> List.maximum
        |> Maybe.withDefault 0


runPartB : String -> String
runPartB puzzleInput =
    let
        allJets : Array.Array Char
        allJets =
            puzzleInput |> String.trim |> String.toList |> Array.fromList

        startCave : Set.Set Position
        startCave =
            [ ( 1, 0 ), ( 2, 0 ), ( 3, 0 ), ( 4, 0 ), ( 5, 0 ), ( 6, 0 ), ( 7, 0 ) ]
                |> Set.fromList

        offsetRocksIndex : Int
        offsetRocksIndex =
            100 - 1

        accAfterOffset : Accumulator
        accAfterOffset =
            rocksDown allJets offsetRocksIndex { rockIndex = 0, hotGasIndex = 0, cave = startCave }

        pattern : Pattern
        pattern =
            findPattern allJets accAfterOffset

        a : Int
        a =
            1000000000000 - pattern.startRockIndex

        b : Int
        b =
            (a |> toFloat) / (pattern.numberOfRocks |> toFloat) |> floor

        c : Int
        c =
            b * pattern.height

        d : Int
        d =
            a |> remainderBy pattern.numberOfRocks

        e : Int
        e =
            rocksDown
                allJets
                (pattern.startRockIndex - 1 + d)
                { rockIndex = 0
                , hotGasIndex = 0
                , cave = startCave
                }
                |> .cave
                |> heightOf
    in
    (c + e) |> String.fromInt


type alias Pattern =
    { acc : Accumulator
    , startRockIndex : Int
    , numberOfRocks : Int
    , height : Int
    }


findPattern : Array.Array Char -> Accumulator -> Pattern
findPattern allJets acc =
    walk allJets Dict.empty acc


walk : Array.Array Char -> Dict.Dict Int ( Int, Int ) -> Accumulator -> Pattern
walk allJets container acc =
    case container |> Dict.get (acc.hotGasIndex |> modBy (Array.length allJets)) of
        Nothing ->
            let
                newContainer : Dict.Dict Int ( Int, Int )
                newContainer =
                    container |> Dict.insert (acc.hotGasIndex |> modBy (Array.length allJets)) ( acc.rockIndex, heightOf acc.cave )

                newAcc : Accumulator
                newAcc =
                    rockInCave allJets acc
            in
            walk allJets newContainer newAcc

        Just ( startRockIndex, heightAtStartRockIndex ) ->
            if (acc.rockIndex |> modBy 5) == (startRockIndex |> modBy 5) then
                { acc = acc
                , startRockIndex = startRockIndex
                , numberOfRocks = acc.rockIndex - startRockIndex
                , height = heightOf acc.cave - heightAtStartRockIndex
                }

            else
                let
                    newContainer : Dict.Dict Int ( Int, Int )
                    newContainer =
                        container |> Dict.insert (acc.hotGasIndex |> modBy (Array.length allJets)) ( acc.rockIndex, heightOf acc.cave )

                    newAcc : Accumulator
                    newAcc =
                        rockInCave allJets acc
                in
                walk allJets newContainer newAcc
