module Day13 exposing (run)

import Parser


run : String -> ( String, String )
run puzzleInput =
    ( runPartA puzzleInput, "No solution" )


runPartA : String -> String
runPartA puzzleInput =
    puzzleInput
        |> String.split "\n\n"
        |> List.filterMap parsePairs
        |> List.indexedMap (\i p -> ( i + 1, p ))
        |> List.filter
            (\( _, p ) ->
                case inRightOrder p of
                    Correct ->
                        True

                    _ ->
                        False
            )
        |> List.map Tuple.first
        |> List.sum
        |> String.fromInt


type alias Pair =
    { left : List Element
    , right : List Element
    }


type Element
    = Single Int
    | Multi (List Element)


parsePairs : String -> Maybe Pair
parsePairs s =
    case s |> String.split "\n" |> List.take 2 of
        left :: right :: _ ->
            Maybe.map2
                (\l r -> { left = l, right = r })
                (parseList left)
                (parseList right)

        _ ->
            Nothing


parseList : String -> Maybe (List Element)
parseList s =
    s |> Parser.run parserListElement |> Result.toMaybe


parserListElement : Parser.Parser (List Element)
parserListElement =
    Parser.sequence
        { start = "["
        , separator = ","
        , end = "]"
        , spaces = Parser.spaces
        , item = parserElement
        , trailing = Parser.Forbidden
        }


parserElement : Parser.Parser Element
parserElement =
    Parser.oneOf
        [ Parser.int |> Parser.map Single
        , Parser.lazy (\_ -> parserListElement) |> Parser.map Multi
        ]


type PacketOrder
    = Correct
    | Incorrect
    | Undecided


inRightOrder : Pair -> PacketOrder
inRightOrder pair =
    case pair.left of
        [] ->
            if List.length pair.right == 0 then
                Undecided

            else
                Correct

        l1 :: restLeft ->
            case pair.right of
                [] ->
                    Incorrect

                r1 :: restRight ->
                    case ( l1, r1 ) of
                        ( Single a, Single b ) ->
                            if a < b then
                                Correct

                            else if a > b then
                                Incorrect

                            else
                                inRightOrder { left = restLeft, right = restRight }

                        ( Single a, Multi _ ) ->
                            inRightOrder { left = Multi [ Single a ] :: restLeft, right = pair.right }

                        ( Multi _, Single b ) ->
                            inRightOrder { left = pair.left, right = Multi [ Single b ] :: restRight }

                        ( Multi a, Multi b ) ->
                            case inRightOrder { left = a, right = b } of
                                Correct ->
                                    Correct

                                Incorrect ->
                                    Incorrect

                                Undecided ->
                                    inRightOrder { left = restLeft, right = restRight }
