module Day10 exposing (run)

import Array
import Parser exposing ((|.), (|=))


run : String -> ( String, String )
run puzzleInput =
    ( runPartA puzzleInput, runPartB puzzleInput )


runPartA : String -> String
runPartA puzzleInput =
    puzzleInput
        |> String.lines
        |> List.filterMap parseCommand
        |> processCommands
        |> getSignalStrength
        |> String.fromInt


type Command
    = Noop
    | Addx Int


signalStrengthNumber : List Int
signalStrengthNumber =
    [ 20, 60, 100, 140, 180, 220 ]


parseCommand : String -> Maybe Command
parseCommand line =
    let
        p =
            Parser.succeed identity
                |= Parser.oneOf
                    [ Parser.succeed Noop
                        |. Parser.token "noop"
                        |. Parser.end
                    , Parser.succeed Addx
                        |. Parser.token "addx"
                        |. Parser.spaces
                        |= Parser.oneOf
                            [ Parser.succeed negate
                                |. Parser.symbol "-"
                                |= Parser.int
                            , Parser.int
                            ]
                        |. Parser.end
                    ]
    in
    line
        |> Parser.run p
        |> Result.toMaybe


processCommands : List Command -> Array.Array Int
processCommands l =
    let
        fn cmd a =
            let
                parent : Int
                parent =
                    a |> Array.get (Array.length a - 1) |> Maybe.withDefault 0
            in
            case cmd of
                Noop ->
                    a |> Array.push parent

                Addx i ->
                    a |> Array.push parent |> Array.push (parent + i)
    in
    l |> List.foldl fn (Array.fromList [ 1 ])


getSignalStrength : Array.Array Int -> Int
getSignalStrength a =
    signalStrengthNumber
        |> List.map
            (\n ->
                (a
                    |> Array.get (n - 1)
                    |> Maybe.withDefault 0
                )
                    * n
            )
        |> List.sum


runPartB : String -> String
runPartB puzzleInput =
    puzzleInput
        |> String.lines
        |> List.filterMap parseCommand
        |> processCommands
        |> parseScreen


parseScreen : Array.Array Int -> String
parseScreen a =
    List.range 0 239
        |> List.map
            (\n ->
                let
                    sprite : Int
                    sprite =
                        a
                            |> Array.get n
                            |> Maybe.withDefault 0

                    xFromN : Int
                    xFromN =
                        n - ((n // 40) * 40)
                in
                if abs (sprite - xFromN) <= 1 then
                    "#"

                else
                    "."
            )
        |> addNewlines
        |> String.concat


addNewlines : List String -> List String
addNewlines l =
    let
        fn : Int -> List String -> List String
        fn n ll =
            (ll |> List.take n) ++ ("\n" :: (ll |> List.drop n))
    in
    -- We added the newlines to the numbers thats why we have 81 instead of 80
    [ 40, 81, 122, 163, 204 ] |> List.foldl fn l
