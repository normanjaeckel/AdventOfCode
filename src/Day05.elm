module Day05 exposing (run)

import Dict
import Parser exposing ((|.), (|=))


run : String -> ( String, String )
run puzzleInput =
    ( runPartA puzzleInput applyStepsOnCratesA, runPartA puzzleInput applyStepsOnCratesB )


runPartA : String -> (List Step -> Crates -> String) -> String
runPartA puzzleInput applyFn =
    let
        crates : Maybe Crates
        crates =
            puzzleInput |> String.split "\n\n" |> List.head |> Maybe.andThen (Just << parseCrates)

        steps : Maybe (List Step)
        steps =
            puzzleInput |> String.split "\n\n" |> List.drop 1 |> List.head |> Maybe.andThen (Just << parseSteps)
    in
    case ( crates, steps ) of
        ( Just c, Just s ) ->
            applyFn s c

        _ ->
            "Error"



-- Crates


type alias Crates =
    Dict.Dict Int (List Char)


parseCrates : String -> Crates
parseCrates input =
    let
        newCrates =
            Dict.empty

        fn : CratesLine -> Crates -> Crates
        fn cratesLine acc1 =
            cratesLine
                |> Dict.toList
                |> List.foldl
                    (\( i, el ) acc2 ->
                        case el of
                            Just ch ->
                                let
                                    current =
                                        acc2 |> Dict.get i |> Maybe.withDefault []
                                in
                                acc2 |> Dict.insert i (ch :: current)

                            Nothing ->
                                acc2
                    )
                    acc1

        lines =
            input
                |> String.split "\n"
    in
    lines
        |> List.take (List.length lines - 1)
        |> List.map parseCratesLine
        |> List.reverse
        |> List.foldl fn newCrates


type alias CratesLine =
    Dict.Dict Int (Maybe Char)


type alias ParseHelper =
    { chars : List Char
    , allChars : List (List Char)
    , count : Int
    }


parseCratesLine : String -> CratesLine
parseCratesLine input =
    let
        fn1 : Char -> ParseHelper -> ParseHelper
        fn1 ch ph =
            if ph.count <= 4 then
                ParseHelper (ph.chars ++ [ ch ]) ph.allChars (ph.count + 1)

            else
                ParseHelper [ ch ] (ph.allChars ++ [ ph.chars ]) 2

        fn2 : List Char -> Maybe Char
        fn2 el =
            case Parser.run cratesObjParser (String.fromList el) of
                Ok v ->
                    Just v

                Err _ ->
                    Nothing

        ll : List (Maybe Char)
        ll =
            (" " ++ input ++ " ")
                |> String.toList
                |> List.foldl fn1 (ParseHelper [] [] 1)
                |> .allChars
                |> List.map fn2

        fn3 : Maybe Char -> Int -> ( Int, Maybe Char )
        fn3 a b =
            ( b, a )
    in
    List.length ll
        |> List.range 1
        |> List.map2 fn3 ll
        |> Dict.fromList


cratesObjParser : Parser.Parser Char
cratesObjParser =
    Parser.succeed (String.toList >> List.head >> Maybe.withDefault '?')
        |. Parser.spaces
        |. Parser.symbol "["
        |= (Parser.chompIf Char.isAlpha |> Parser.getChompedString)
        |. Parser.symbol "]"
        |. Parser.end



-- Steps


parseSteps : String -> List Step
parseSteps input =
    input
        |> String.split "\n"
        |> List.map parseStepLine


type alias Step =
    { howMany : Int
    , from : Int
    , to : Int
    }


parseStepLine : String -> Step
parseStepLine l =
    let
        p =
            Parser.succeed Step
                |. Parser.token "move"
                |. Parser.spaces
                |= Parser.int
                |. Parser.spaces
                |. Parser.token "from"
                |. Parser.spaces
                |= Parser.int
                |. Parser.spaces
                |. Parser.token "to"
                |. Parser.spaces
                |= Parser.int
                |. Parser.end
    in
    case Parser.run p l of
        Ok v ->
            v

        Err _ ->
            Step 0 0 0



-- Moving


applyStepsOnCratesA : List Step -> Crates -> String
applyStepsOnCratesA steps crates =
    let
        from : Int -> Crates -> ( Char, Crates )
        from i c =
            case
                c
                    |> Dict.get i
                    |> Maybe.withDefault []
            of
                ch :: rest ->
                    ( ch, c |> Dict.insert i rest )

                [] ->
                    ( '?', c )

        to : Int -> ( Char, Crates ) -> Crates
        to i ( ch, c ) =
            c
                |> Dict.insert i
                    (ch :: (c |> Dict.get i |> Maybe.withDefault []))

        fn : Step -> Crates -> Crates
        fn step acc1 =
            let
                fnInner _ accInner =
                    to step.to (from step.from accInner)
            in
            List.range 1 step.howMany |> List.foldl fnInner acc1
    in
    steps |> List.foldl fn crates |> extractTop


extractTop : Crates -> String
extractTop crates =
    crates
        |> Dict.values
        |> List.map (List.head >> Maybe.withDefault '?')
        |> List.map String.fromChar
        |> String.join ""


applyStepsOnCratesB : List Step -> Crates -> String
applyStepsOnCratesB steps crates =
    let
        from : Int -> Int -> Crates -> ( List Char, Crates )
        from i howMany c =
            let
                stack : List Char
                stack =
                    c
                        |> Dict.get i
                        |> Maybe.withDefault []
            in
            ( stack |> List.take howMany
            , c |> Dict.insert i (stack |> List.drop howMany)
            )

        to : Int -> ( List Char, Crates ) -> Crates
        to i ( chs, c ) =
            c
                |> Dict.insert i
                    (chs ++ (c |> Dict.get i |> Maybe.withDefault []))

        fn : Step -> Crates -> Crates
        fn step acc =
            to step.to (from step.from step.howMany acc)
    in
    steps |> List.foldl fn crates |> extractTop
