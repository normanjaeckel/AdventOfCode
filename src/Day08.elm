module Day08 exposing (run)

import Browser.Events exposing (Visibility)


run : String -> ( String, String )
run forrest =
    ( solvePartA forrest, "No solution" )


type alias Forrest =
    List (List ( Int, Visibility ))


type Visibility
    = Visible
    | Invisible


solvePartA : String -> String
solvePartA forrest =
    forrest
        |> String.lines
        |> List.map transformLine
        |> visibilityFromLeft
        |> visibilityFromRight
        |> transpose
        |> visibilityFromLeft
        |> visibilityFromRight
        |> countVisibils
        |> String.fromInt


transformLine : String -> List ( Int, Visibility )
transformLine line =
    let
        transformTree : String -> ( Visibility, Int )
        transformTree s =
            s
                |> String.toInt
                |> Maybe.withDefault 0
                |> Tuple.pair Invisible
    in
    line
        |> String.split ""
        |> List.map transformTree
        |> List.map (\( a, b ) -> ( b, a ))


visibilityFromLeft : Forrest -> Forrest
visibilityFromLeft forrest =
    forrest |> List.map (walkInLine -1)


visibilityFromRight : Forrest -> Forrest
visibilityFromRight forrest =
    forrest |> List.map (List.reverse >> walkInLine -1 >> List.reverse)


transpose : List (List a) -> List (List a)
transpose l =
    case l of
        (x :: xs) :: xxs ->
            let
                heads =
                    xxs |> List.filterMap List.head

                tails =
                    xxs |> List.filterMap List.tail
            in
            (x :: heads) :: transpose (xs :: tails)

        [] :: xxs ->
            transpose xxs

        [] ->
            []


countVisibils : Forrest -> Int
countVisibils forrest =
    let
        fn1 : List ( Int, Visibility ) -> Int -> Int
        fn1 line count =
            line |> List.foldl fn2 count

        fn2 : ( Int, Visibility ) -> Int -> Int
        fn2 tree count =
            case tree |> Tuple.second of
                Visible ->
                    count + 1

                Invisible ->
                    count
    in
    forrest |> List.foldl fn1 0


walkInLine : Int -> List ( Int, Visibility ) -> List ( Int, Visibility )
walkInLine currentHeight line =
    case line of
        [] ->
            line

        tree :: rest ->
            let
                treeHeight =
                    Tuple.first tree
            in
            if treeHeight > currentHeight then
                ( treeHeight, Visible ) :: walkInLine treeHeight rest

            else
                tree :: walkInLine currentHeight rest
