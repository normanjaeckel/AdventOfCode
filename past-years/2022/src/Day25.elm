module Day25 exposing (run)

import Parser exposing ((|.), (|=))


run : String -> ( String, String )
run puzzleInput =
    ( runPartA puzzleInput, "No solution" )


runPartA : String -> String
runPartA puzzleInput =
    case puzzleInput |> Parser.run puzzleParser of
        Err _ ->
            "Error"

        Ok numbers ->
            numbers
                |> List.foldl addSNAFU [ Zero ]
                |> fromSNAFUToString


type SNAFUDigit
    = MinusTwo
    | MinusOne
    | Zero
    | One
    | Two


type alias SNAFUNumber =
    List SNAFUDigit


toSNAFUDigit : Char -> Maybe SNAFUDigit
toSNAFUDigit ch =
    case ch of
        '=' ->
            Just MinusTwo

        '-' ->
            Just MinusOne

        '0' ->
            Just Zero

        '1' ->
            Just One

        '2' ->
            Just Two

        _ ->
            Nothing


fromSNAFUToDigit : SNAFUDigit -> Char
fromSNAFUToDigit s =
    case s of
        MinusTwo ->
            '='

        MinusOne ->
            '-'

        Zero ->
            '0'

        One ->
            '1'

        Two ->
            '2'


toSNAFUNumber : Maybe SNAFUNumber -> List Char -> Maybe SNAFUNumber
toSNAFUNumber mbnum chars =
    mbnum
        |> Maybe.andThen
            (\num ->
                case chars of
                    [] ->
                        Just <| List.reverse num

                    one :: rest ->
                        toSNAFUNumber (one |> toSNAFUDigit |> Maybe.andThen (\ch -> Just (ch :: num))) rest
            )


fromSNAFUToString : SNAFUNumber -> String
fromSNAFUToString num =
    num
        |> List.map fromSNAFUToDigit
        |> List.foldl (\ch s -> s ++ String.fromChar ch) ""


puzzleParser : Parser.Parser (List SNAFUNumber)
puzzleParser =
    Parser.loop []
        (\list ->
            Parser.oneOf
                [ Parser.succeed
                    (\s ->
                        case s |> String.toList |> toSNAFUNumber (Just []) of
                            Just num ->
                                (num :: list) |> Parser.Loop

                            Nothing ->
                                list |> Parser.Loop
                    )
                    |= (Parser.getChompedString <|
                            Parser.succeed ()
                                |. Parser.chompWhile (\c -> [ '=', '-', '0', '1', '2' ] |> List.any ((==) c))
                       )
                    |. Parser.symbol "\n"
                , Parser.succeed () |> Parser.map (\_ -> list |> List.reverse |> Parser.Done)
                ]
        )


addSNAFU : SNAFUNumber -> SNAFUNumber -> SNAFUNumber
addSNAFU a b =
    let
        lenA : Int
        lenA =
            List.length a

        lenB : Int
        lenB =
            List.length b

        offset : List SNAFUDigit
        offset =
            Zero |> List.repeat (abs (lenA - lenB))

        aAndB : List ( SNAFUDigit, SNAFUDigit )
        aAndB =
            List.map2 Tuple.pair
                (a |> List.append offset |> List.reverse)
                (b |> List.append offset |> List.reverse)

        ( sum, carry ) =
            aAndB |> List.foldl fn ( [], Zero )
    in
    case carry of
        Zero ->
            sum

        _ ->
            carry :: sum


type alias Carry =
    SNAFUDigit


fn : ( SNAFUDigit, SNAFUDigit ) -> ( SNAFUNumber, Carry ) -> ( SNAFUNumber, Carry )
fn ( a, b ) ( sum, carry ) =
    let
        ( s1, c1 ) =
            addSNAFUDigits a carry

        ( s2, c2 ) =
            addSNAFUDigits s1 b
    in
    ( s2 :: sum, addSNAFUDigits c1 c2 |> Tuple.first )


addSNAFUDigits : SNAFUDigit -> SNAFUDigit -> ( SNAFUDigit, Carry )
addSNAFUDigits a b =
    case a of
        MinusTwo ->
            case b of
                MinusTwo ->
                    ( One, MinusOne )

                MinusOne ->
                    ( Two, MinusOne )

                Zero ->
                    ( MinusTwo, Zero )

                One ->
                    ( MinusOne, Zero )

                Two ->
                    ( Zero, Zero )

        MinusOne ->
            case b of
                MinusTwo ->
                    ( Two, MinusOne )

                MinusOne ->
                    ( MinusTwo, Zero )

                Zero ->
                    ( MinusOne, Zero )

                One ->
                    ( Zero, Zero )

                Two ->
                    ( One, Zero )

        Zero ->
            ( b, Zero )

        One ->
            case b of
                MinusTwo ->
                    ( MinusOne, Zero )

                MinusOne ->
                    ( Zero, Zero )

                Zero ->
                    ( One, Zero )

                One ->
                    ( Two, Zero )

                Two ->
                    ( MinusTwo, One )

        Two ->
            case b of
                MinusTwo ->
                    ( Zero, Zero )

                MinusOne ->
                    ( One, Zero )

                Zero ->
                    ( Two, Zero )

                One ->
                    ( MinusTwo, One )

                Two ->
                    ( MinusOne, One )
