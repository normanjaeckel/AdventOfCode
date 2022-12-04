module Day04 exposing (run)


run : String -> ( String, String )
run puzzleInput =
    ( runPart checkPartOne puzzleInput, runPart checkPartTwo puzzleInput )


runPart : (Maybe IDs -> Maybe IDs -> Int) -> String -> String
runPart fn puzzleInput =
    puzzleInput
        |> String.split "\n"
        |> List.map (parseLine fn)
        |> List.sum
        |> String.fromInt


parseLine : (Maybe IDs -> Maybe IDs -> Int) -> String -> Int
parseLine fn line =
    let
        first : Maybe IDs
        first =
            line
                |> String.split ","
                |> List.head
                |> Maybe.andThen toIDs

        second : Maybe IDs
        second =
            line
                |> String.split ","
                |> List.drop 1
                |> List.head
                |> Maybe.andThen toIDs
    in
    fn first second


toIDs : String -> Maybe IDs
toIDs s =
    Just <|
        IDs
            (s
                |> String.split "-"
                |> List.head
                |> Maybe.andThen String.toInt
                |> Maybe.withDefault 0
            )
            (s
                |> String.split "-"
                |> List.drop 1
                |> List.head
                |> Maybe.andThen String.toInt
                |> Maybe.withDefault 0
            )


type alias IDs =
    { start : Int, end : Int }


checkPartOne : Maybe IDs -> Maybe IDs -> Int
checkPartOne first second =
    case ( first, second ) of
        ( Nothing, Nothing ) ->
            0

        ( Nothing, _ ) ->
            0

        ( _, Nothing ) ->
            0

        ( Just f, Just s ) ->
            if (f.start <= s.start) && (f.end >= s.end) then
                1

            else if (s.start <= f.start) && (s.end >= f.end) then
                1

            else
                0


checkPartTwo : Maybe IDs -> Maybe IDs -> Int
checkPartTwo first second =
    case ( first, second ) of
        ( Nothing, Nothing ) ->
            0

        ( Nothing, _ ) ->
            0

        ( _, Nothing ) ->
            0

        ( Just f, Just s ) ->
            if (f.start <= s.start) && (s.start <= f.end) then
                1

            else if (s.start <= f.start) && (f.start <= s.end) then
                1

            else
                0
