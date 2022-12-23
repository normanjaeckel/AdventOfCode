module Day20 exposing (run)

import Array exposing (Array)
import Parser exposing ((|.), (|=))


run : String -> ( String, String )
run puzzleInput =
    ( runPartA puzzleInput, "No solution" )


runPartA : String -> String
runPartA puzzleInput =
    case puzzleInput |> Parser.run puzzleParser of
        Ok encryptedData ->
            if List.isEmpty encryptedData then
                "No input"

            else
                encryptedData
                    |> decryptWith [ 1000, 2000, 3000 ]
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


decryptWith : List Int -> List Int -> Int
decryptWith indices encryptedData =
    let
        len : Int
        len =
            List.length encryptedData

        newData : Array Int
        newData =
            encryptedData |> List.foldl fn (encryptedData |> Array.fromList)

        fn : Int -> Array Int -> Array Int
        fn value data =
            let
                oldIndex =
                    data |> Debug.log "data" |> findIndexFor value

                newIndex =
                    (oldIndex + value) |> modBy len
            in
            (if (oldIndex |> Debug.log "oldIndex") < (newIndex |> Debug.log "newIndex") then
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
                        (data |> Array.slice 0 (newIndex + 1) |> Array.push value)
                        (data |> Array.slice (newIndex + 1) oldIndex)
                    )
                    (data |> Array.slice (oldIndex + 1) len)
            )
                |> Debug.log "result"

        startIndex : Int
        startIndex =
            newData |> findIndexFor 0
    in
    indices
        |> List.map (\i -> (startIndex + i) |> modBy len)
        |> List.filterMap (\i -> newData |> Array.get i)
        |> List.sum


findIndexFor : Int -> Array Int -> Int
findIndexFor value data =
    data
        |> Array.toIndexedList
        |> List.filter (\( _, v ) -> v == value)
        |> List.map Tuple.first
        |> List.head
        |> Maybe.withDefault 0
