module Day03 exposing (run)

import Dict
import Set


run : String -> ( String, String )
run puzzleInput =
    let
        c =
            puzzleInput
                |> String.split "\n"
    in
    ( innerRunPartA c, innerRunPartB c )


innerRunPartA : List String -> String
innerRunPartA content =
    content
        |> List.map fnPartA
        |> List.sum
        |> String.fromInt


fnPartA : String -> Int
fnPartA line =
    let
        half : Int
        half =
            String.length line // 2

        left : Set.Set String
        left =
            line |> String.dropRight half |> String.split "" |> Set.fromList

        right : Set.Set String
        right =
            line |> String.dropLeft half |> String.split "" |> Set.fromList
    in
    Dict.get
        (Set.intersect left right
            |> Set.toList
            |> List.head
            |> Maybe.withDefault ""
        )
        prio
        |> Maybe.withDefault 0


innerRunPartB : List String -> String
innerRunPartB content =
    walk content
        |> String.fromInt


walk : List String -> Int
walk all =
    case all of
        first :: second :: third :: rest ->
            parseGroup first second third + walk rest

        _ ->
            0


parseGroup : String -> String -> String -> Int
parseGroup first second third =
    let
        s : String -> Set.Set String
        s =
            String.split "" >> Set.fromList
    in
    Dict.get
        (Set.intersect (s first) (s second)
            |> Set.intersect (s third)
            |> Set.toList
            |> List.head
            |> Maybe.withDefault ""
        )
        prio
        |> Maybe.withDefault 0



-- Shared


prio : Dict.Dict String Int
prio =
    let
        alphas : List String
        alphas =
            "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" |> String.split ""

        nums : List Int
        nums =
            List.range 1 52
    in
    List.map2 Tuple.pair alphas nums |> Dict.fromList
