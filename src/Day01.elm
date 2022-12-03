module Day01 exposing (run)

import List


run : String -> ( String, String )
run content =
    ( innerRun content 1, innerRun content 3 )


innerRun : String -> Int -> String
innerRun puzzleInput count =
    puzzleInput
        |> String.split "\n\n"
        |> List.map
            (String.split "\n"
                >> List.map (String.toInt >> Maybe.withDefault 0)
                >> List.foldl (+) 0
            )
        |> List.sort
        |> List.reverse
        |> List.take count
        |> List.sum
        |> String.fromInt
