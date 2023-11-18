module Day15 exposing (run)

import Parser exposing ((|.), (|=))
import Set


run : String -> ( String, String )
run puzzleInput =
    let
        ( row, cave ) =
            if puzzleInput |> String.startsWith "Sensor at x=2," then
                ( 10, 20 )

            else
                ( 2000000, 4000000 )
    in
    ( runPartA puzzleInput row, runPartB puzzleInput cave )


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
toField sensor beacon =
    { sensor = sensor
    , beacon = beacon
    , distance = distanceBetween sensor beacon
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



-- Part B


runPartB : String -> Int -> String
runPartB puzzleInput cave =
    case puzzleInput |> Parser.run puzzleParser of
        Ok l ->
            l
                |> List.map (\( sensor, beacon ) -> toField sensor beacon)
                |> solvePartB cave
                |> (\( x, y ) -> x * 4000000 + y)
                |> String.fromInt

        Err _ ->
            "Error"


solvePartB : Int -> List Field -> Position
solvePartB cave fields =
    walk fields cave fields |> Maybe.withDefault ( 0, 0 )


walk : List Field -> Int -> List Field -> Maybe Position
walk allFields cave fields =
    case fields of
        field :: rest ->
            case field |> getBorderPoints |> checkIsOutside allFields cave of
                Just point ->
                    Just point

                Nothing ->
                    walk allFields cave rest

        [] ->
            Nothing


getBorderPoints : Field -> Set.Set Position
getBorderPoints field =
    let
        x =
            Tuple.first field.sensor

        y =
            Tuple.second field.sensor

        north =
            ( x, y - field.distance - 1 )

        south =
            ( x, y + field.distance + 1 )

        west =
            ( x - field.distance - 1, y )

        east =
            ( x + field.distance + 1, y )
    in
    getLine RightDown north east
        |> Set.union (getLine RightUp south east)
        |> Set.union (getLine RightDown west south)
        |> Set.union (getLine RightUp west north)


type Diagonal
    = RightDown
    | RightUp


getLine : Diagonal -> Position -> Position -> Set.Set Position
getLine diagonal ( x1, y1 ) ( x2, y2 ) =
    let
        i =
            abs (x1 - x2)
    in
    List.range 0 i
        |> List.map
            (\n ->
                case diagonal of
                    RightDown ->
                        ( x1 + n, y1 + n )

                    RightUp ->
                        ( x1 + n, y1 - n )
            )
        |> Set.fromList


checkIsOutside : List Field -> Int -> Set.Set Position -> Maybe Position
checkIsOutside allFields cave points =
    let
        fn point result =
            case result of
                Just found ->
                    Just found

                Nothing ->
                    if
                        (Tuple.first point < 0)
                            || (Tuple.first point > cave)
                            || (Tuple.second point < 0)
                            || (Tuple.second point > cave)
                    then
                        Nothing

                    else if allFields |> List.any (\field -> field.distance >= distanceBetween field.sensor point) then
                        Nothing

                    else
                        Just point
    in
    points |> Set.foldl fn Nothing


distanceBetween : Position -> Position -> Int
distanceBetween ( x1, y1 ) ( x2, y2 ) =
    abs (x1 - x2) + abs (y1 - y2)
