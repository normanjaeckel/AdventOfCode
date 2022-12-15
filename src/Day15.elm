module Day15 exposing (run)

import Parser exposing ((|.), (|=))
import Set


run : String -> ( String, String )
run puzzleInput =
    ( runPartA puzzleInput 2000000, "No solution" )


runPartA : String -> Int -> String
runPartA puzzleInput row =
    case puzzleInput |> Parser.run puzzleParser of
        Ok l ->
            l
                |> List.map (\( sensor, beacon ) -> toField sensor beacon)
                |> calcForRow row
                |> String.fromInt

        Err _ ->
            "Error"


type alias Position =
    ( Int, Int )



-- Parse


puzzleParser : Parser.Parser (List ( Position, Position ))
puzzleParser =
    Parser.loop []
        (\all ->
            Parser.oneOf
                [ parserLine |> Parser.map (\line -> line :: all |> Parser.Loop)
                , Parser.succeed () |> Parser.map (\_ -> Parser.Done (List.reverse all))
                ]
        )


parserLine : Parser.Parser ( Position, Position )
parserLine =
    Parser.succeed (\x1 y1 x2 y2 -> ( ( x1, y1 ), ( x2, y2 ) ))
        |. Parser.token "Sensor at x="
        |= myInt
        |. Parser.token ", y="
        |= myInt
        |. Parser.token ": closest beacon is at x="
        |= myInt
        |. Parser.token ", y="
        |= myInt
        |. Parser.symbol "\n"


myInt : Parser.Parser Int
myInt =
    Parser.oneOf
        [ Parser.succeed negate
            |. Parser.symbol "-"
            |= Parser.int
        , Parser.int
        ]



-- Build and calc


type alias Field =
    { sensor : Position
    , beacon : Position
    , distance : Int
    }


toField : Position -> Position -> Field
toField ( x1, y1 ) ( x2, y2 ) =
    { sensor = ( x1, y1 )
    , beacon = ( x2, y2 )
    , distance = abs (x1 - x2) + abs (y1 - y2)
    }


calcForRow : Int -> List Field -> Int
calcForRow row fields =
    let
        beaconsInRow : Int
        beaconsInRow =
            fields
                |> List.foldl (\field set -> set |> Set.insert field.beacon) Set.empty
                |> Set.filter (\beacon -> Tuple.second beacon == row)
                |> Set.size

        fn field result =
            result |> Set.union (calcForField row field)
    in
    (fields
        |> List.foldl fn Set.empty
        |> Set.size
    )
        - beaconsInRow


calcForField : Int -> Field -> Set.Set Position
calcForField row field =
    let
        xField : Int
        xField =
            field.sensor |> Tuple.first

        yField : Int
        yField =
            field.sensor |> Tuple.second

        xSideStep : Int
        xSideStep =
            field.distance - abs (row - yField)
    in
    List.range 0 xSideStep
        |> List.foldl
            (\x set ->
                set
                    |> Set.insert ( xField + x, row )
                    |> Set.insert ( xField - x, row )
            )
            Set.empty
