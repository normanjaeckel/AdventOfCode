module Day06 exposing (run)

import Set


run : String -> ( String, String )
run puzzleInput =
    ( runPartA puzzleInput 4, runPartA puzzleInput 14 )


runPartA : String -> Int -> String
runPartA puzzleInput count =
    let
        l : List ( Int, Char )
        l =
            puzzleInput
                |> String.toList
                |> List.indexedMap Tuple.pair

        fn : ( Int, Char ) -> List ( Int, Char ) -> List ( Int, Char )
        fn element partList =
            if allUniqueIn partList then
                partList

            else if List.length partList == count then
                (partList |> List.drop 1) ++ [ element ]

            else
                partList ++ [ element ]

        allUniqueIn : List ( Int, Char ) -> Bool
        allUniqueIn partList =
            (partList |> List.map Tuple.second |> Set.fromList |> Set.size) == count
    in
    l
        |> List.foldl fn []
        |> List.drop (count - 1)
        |> List.head
        |> Maybe.withDefault ( 0, '?' )
        |> Tuple.first
        |> (+) 1
        |> String.fromInt
