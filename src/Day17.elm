module Day17 exposing (run)

import Set


run : String -> ( String, String )
run puzzleInput =
    ( runPartA puzzleInput, "No solution" )


runPartA : String -> String
runPartA puzzleInput =
    let
        allJets : List Char
        allJets =
            puzzleInput |> String.trim |> String.toList

        cave : Set.Set Position
        cave =
            [ ( 1, 0 ), ( 2, 0 ), ( 3, 0 ), ( 4, 0 ), ( 5, 0 ), ( 6, 0 ), ( 7, 0 ) ]
                |> Set.fromList
    in
    List.range 0 (2022 - 1)
        |> List.foldl (rockInCave allJets) { hotGas = allJets, cave = cave }
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


type alias Accumulator =
    { hotGas : List Char, cave : Set.Set Position }


rockInCave : List Char -> Int -> Accumulator -> Accumulator
rockInCave allJets i acc =
    let
        nextRock : RockShape
        nextRock =
            i |> modBy 5 |> rockType

        height : Int
        height =
            acc.cave
                |> Set.toList
                |> List.map Tuple.second
                |> List.maximum
                |> Maybe.withDefault 0

        newCave : Set.Set Position
        newCave =
            acc.cave

        rockPos : Set.Set Position
        rockPos =
            newRock nextRock (height + 4)
    in
    rockFalls allJets acc.hotGas rockPos newCave


rockFalls : List Char -> List Char -> Set.Set Position -> Set.Set Position -> Accumulator
rockFalls allJets hotGas rock cave =
    let
        nextDirection : ( Char, List Char )
        nextDirection =
            case hotGas of
                ch :: rest ->
                    ( ch, rest )

                [] ->
                    ( allJets |> List.head |> Maybe.withDefault '?', allJets |> List.drop 1 )

        newHotGas : List Char
        newHotGas =
            Tuple.second nextDirection

        newRockA : Set.Set Position
        newRockA =
            rock |> blowTo cave (Tuple.first nextDirection)

        newRockB : Set.Set Position
        newRockB =
            newRockA |> Set.map (\( x, y ) -> ( x, y - 1 ))
    in
    if newRockB |> collidesWith cave then
        { hotGas = newHotGas, cave = cave |> Set.union newRockA }

    else
        rockFalls allJets newHotGas newRockB cave


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
