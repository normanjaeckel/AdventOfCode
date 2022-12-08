module Day08 exposing (run)

import Browser.Events exposing (Visibility)


run : String -> ( String, String )
run forrest =
    ( solvePartA forrest, solvePartB forrest )


type alias Forrest =
    List (List Tree)


type alias Tree =
    { height : Int
    , visibility : Visibility
    , scenicScore : Int
    }


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


solvePartB : String -> String
solvePartB forrest =
    forrest
        |> String.lines
        |> List.map transformLine
        |> scenicScoreFromLeft
        |> scenicScoreFromRight
        |> transpose
        |> scenicScoreFromLeft
        |> scenicScoreFromRight
        |> maxScenicScore
        |> String.fromInt


transformLine : String -> List Tree
transformLine line =
    let
        transformTree : String -> Tree
        transformTree s =
            { height = s |> String.toInt |> Maybe.withDefault 0
            , visibility = Invisible
            , scenicScore = 1
            }
    in
    line
        |> String.split ""
        |> List.map transformTree


visibilityFromLeft : Forrest -> Forrest
visibilityFromLeft forrest =
    forrest |> List.map (walkInLineA -1)


visibilityFromRight : Forrest -> Forrest
visibilityFromRight forrest =
    forrest |> List.map (List.reverse >> walkInLineA -1 >> List.reverse)


walkInLineA : Int -> List Tree -> List Tree
walkInLineA currentHeight line =
    case line of
        [] ->
            line

        tree :: rest ->
            if tree.height > currentHeight then
                { tree | visibility = Visible } :: walkInLineA tree.height rest

            else
                tree :: walkInLineA currentHeight rest


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
        fn1 : List Tree -> Int -> Int
        fn1 line count =
            line |> List.foldl fn2 count

        fn2 : Tree -> Int -> Int
        fn2 tree count =
            case tree.visibility of
                Visible ->
                    count + 1

                Invisible ->
                    count
    in
    forrest |> List.foldl fn1 0


scenicScoreFromLeft : Forrest -> Forrest
scenicScoreFromLeft forrest =
    forrest |> List.map (walkInLineB [])


scenicScoreFromRight : Forrest -> Forrest
scenicScoreFromRight forrest =
    forrest |> List.map (List.reverse >> walkInLineB [] >> List.reverse)


walkInLineB : List Int -> List Tree -> List Tree
walkInLineB lastTrees line =
    case line of
        [] ->
            line

        tree :: rest ->
            { tree | scenicScore = tree.scenicScore * haveALook tree.height lastTrees 0 } :: walkInLineB (tree.height :: lastTrees) rest


haveALook : Int -> List Int -> Int -> Int
haveALook height lastTrees count =
    case lastTrees of
        l :: rest ->
            if height <= l then
                count + 1

            else
                haveALook height rest (count + 1)

        [] ->
            count


maxScenicScore : Forrest -> Int
maxScenicScore forrest =
    let
        fn : List Tree -> Int -> Int
        fn line count =
            let
                maxInThisLine =
                    line
                        |> List.map .scenicScore
                        |> List.maximum
                        |> Maybe.withDefault 0
            in
            if count < maxInThisLine then
                maxInThisLine

            else
                count
    in
    forrest |> List.foldl fn 0
