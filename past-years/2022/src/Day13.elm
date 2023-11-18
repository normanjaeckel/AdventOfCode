module Day13 exposing (run)

import Parser


run : String -> ( String, String )
run puzzleInput =
    ( runPartA puzzleInput, runPartB puzzleInput )


runPartA : String -> String
runPartA puzzleInput =
    puzzleInput
        |> String.split "\n\n"
        |> List.filterMap parsePairs
        |> List.indexedMap (\i p -> ( i + 1, p ))
        |> List.filter
            (\( _, p ) ->
                case inRightOrder p of
                    LT ->
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


inRightOrder : Pair -> Order
inRightOrder pair =
    case pair.left of
        [] ->
            if List.length pair.right == 0 then
                EQ

            else
                LT

        l1 :: restLeft ->
            case pair.right of
                [] ->
                    GT

                r1 :: restRight ->
                    case ( l1, r1 ) of
                        ( Single a, Single b ) ->
                            if a < b then
                                LT

                            else if a > b then
                                GT

                            else
                                inRightOrder { left = restLeft, right = restRight }

                        ( Single a, Multi _ ) ->
                            inRightOrder { left = Multi [ Single a ] :: restLeft, right = pair.right }

                        ( Multi _, Single b ) ->
                            inRightOrder { left = pair.left, right = Multi [ Single b ] :: restRight }

                        ( Multi a, Multi b ) ->
                            case inRightOrder { left = a, right = b } of
                                LT ->
                                    LT

                                GT ->
                                    GT

                                EQ ->
                                    inRightOrder { left = restLeft, right = restRight }


dividerPacketA : String
dividerPacketA =
    "[[2]]"


dividerPacketATransformed : List Element
dividerPacketATransformed =
    [ Multi [ Single 2 ] ]


dividerPacketB : String
dividerPacketB =
    "[[6]]"


dividerPacketBTransformed : List Element
dividerPacketBTransformed =
    [ Multi [ Single 6 ] ]


runPartB : String -> String
runPartB puzzleInput =
    dividerPacketA
        :: (dividerPacketB :: (puzzleInput |> String.split "\n"))
        |> List.filterMap parseList
        |> List.sortWith
            (\a b ->
                inRightOrder { left = a, right = b }
            )
        |> List.indexedMap (\i p -> ( i + 1, p ))
        |> List.foldl
            (\( i, e ) res ->
                if e == dividerPacketATransformed || e == dividerPacketBTransformed then
                    i * res

                else
                    res
            )
            1
        |> String.fromInt
