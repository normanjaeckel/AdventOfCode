module Day20 exposing (run)

import Array exposing (Array)
import Parser exposing ((|.), (|=))


run : String -> ( String, String )
run puzzleInput =
    ( runPartA puzzleInput, runPartB puzzleInput )


runPartA : String -> String
runPartA puzzleInput =
    case puzzleInput |> Parser.run puzzleParser of
        Ok encryptedData ->
            if List.isEmpty encryptedData then
                "No input"

            else
                encryptedData
                    |> decryptWith 1 [ 1000, 2000, 3000 ]
                    |> String.fromInt

        Err _ ->
            "Error"


runPartB : String -> String
runPartB puzzleInput =
    case puzzleInput |> Parser.run puzzleParser of
        Ok encryptedData ->
            if List.isEmpty encryptedData then
                "No input"

            else
                encryptedData
                    |> List.map ((*) 811589153)
                    |> decryptWith 10 [ 1000, 2000, 3000 ]
                    |> String.fromInt

        Err _ ->
            "Error"


puzzleParser : Parser.Parser (List Int)
puzzleParser =
    Parser.loop []
        (\l ->
            Parser.oneOf
                [ Parser.succeed (\i -> i :: l |> Parser.Loop)
                    |= myIntParser
                    |. Parser.spaces
                , (Parser.succeed ()
                    |. Parser.end
                  )
                    |> Parser.map (\_ -> List.reverse l |> Parser.Done)
                ]
        )


myIntParser : Parser.Parser Int
myIntParser =
    Parser.oneOf
        [ Parser.succeed negate
            |. Parser.symbol "-"
            |= Parser.int
        , Parser.int
        ]


type alias ValueWithIndex =
    Array ( Int, Int )


decryptWith : Int -> List Int -> List Int -> Int
decryptWith rounds indices encryptedData =
    let
        len : Int
        len =
            List.length encryptedData

        indexEncryptedData : List ( Int, Int )
        indexEncryptedData =
            encryptedData |> List.indexedMap Tuple.pair

        mixedData : ValueWithIndex
        mixedData =
            List.repeat rounds ()
                |> List.foldl
                    (\s innerMixedData -> s |> always indexEncryptedData |> List.foldl fn innerMixedData)
                    (indexEncryptedData |> Array.fromList)

        fn : ( Int, Int ) -> ValueWithIndex -> ValueWithIndex
        fn value data =
            let
                oldIndex : Int
                oldIndex =
                    data |> findIndexFor value

                newIndex : Int
                newIndex =
                    (oldIndex + Tuple.second value) |> modBy (len - 1)
            in
            if oldIndex < newIndex then
                Array.append
                    (Array.append
                        (data |> Array.slice 0 oldIndex)
                        (data |> Array.slice (oldIndex + 1) (newIndex + 1))
                        |> Array.push value
                    )
                    (data |> Array.slice (newIndex + 1) len)

            else
                Array.append
                    (Array.append
                        (data |> Array.slice 0 newIndex |> Array.push value)
                        (data |> Array.slice newIndex oldIndex)
                    )
                    (data |> Array.slice (oldIndex + 1) len)

        startIndex : Int
        startIndex =
            mixedData |> Array.map Tuple.second |> findIndexFor 0
    in
    indices
        |> List.map (\i -> (startIndex + i) |> modBy len)
        |> List.filterMap (\i -> mixedData |> Array.get i)
        |> List.map Tuple.second
        |> List.sum


findIndexFor : a -> Array a -> Int
findIndexFor value data =
    data
        |> Array.toIndexedList
        |> List.filter (\( _, v ) -> v == value)
        |> List.map Tuple.first
        |> List.head
        |> Maybe.withDefault 0
