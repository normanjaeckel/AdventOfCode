module Day01 exposing (run)

import List


run : String -> ( String, String )
run content =
    ( runA content, runB content )


runA : String -> String
runA content =
    content
        |> String.split "\n\n"
        |> List.map
            (String.split "\n"
                >> List.map (String.toInt >> Maybe.withDefault 0)
                >> List.foldl (+) 0
            )
        |> List.maximum
        |> Maybe.withDefault 0
        |> String.fromInt


runB : String -> String
runB content =
    content
        |> String.split "\n\n"
        |> List.map
            (String.split "\n"
                >> List.map (String.toInt >> Maybe.withDefault 0)
                >> List.foldl (+) 0
            )
        |> List.sort
        |> List.foldr
            (\value tmpRes ->
                if tmpRes.numElves <= 2 then
                    TmpResult (tmpRes.sum + value) (tmpRes.numElves + 1)

                else
                    tmpRes
            )
            (TmpResult 0 0)
        |> .sum
        |> String.fromInt


type alias TmpResult =
    { sum : Int
    , numElves : Int
    }
