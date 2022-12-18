module Day16 exposing (run)

import Dict
import Html.Attributes exposing (disabled)
import Parser exposing ((|.), (|=))
import Set


run : String -> ( String, String )
run puzzleInput =
    ( runPartA puzzleInput, "No solution" )


runPartA : String -> String
runPartA puzzleInput =
    case puzzleInput |> Parser.run puzzleParser of
        Ok valves ->
            let
                distances =
                    calcDistances valves
            in
            valves
                |> Dict.filter (\_ valve -> valve.rate > 0)
                |> searchBestPath distances
                |> String.fromInt

        Err _ ->
            "Error"


type alias ValveID =
    String


type alias Valve =
    { rate : Int
    , next : List ValveID
    }


type alias Valves =
    Dict.Dict ValveID Valve


globalTime : Int
globalTime =
    30


getRate : ValveID -> Valves -> Int
getRate valveID valves =
    valves
        |> Dict.get valveID
        |> Maybe.andThen (Just << .rate)
        |> Maybe.withDefault 0



-- Parse


puzzleParser : Parser.Parser Valves
puzzleParser =
    Parser.loop Dict.empty
        (\all ->
            Parser.oneOf
                [ Parser.succeed (\( id, valve ) -> all |> Dict.insert id valve |> Parser.Loop)
                    |= valveParser
                    |. Parser.symbol "\n"
                , (Parser.succeed ()
                    |. Parser.end
                  )
                    |> Parser.map (always <| Parser.Done all)
                ]
        )


valveParser : Parser.Parser ( ValveID, Valve )
valveParser =
    Parser.succeed (\valveID rate nextValves -> ( valveID, { rate = rate, next = nextValves } ))
        |. Parser.token "Valve"
        |. Parser.spaces
        |= valveIDParser
        |. Parser.spaces
        |. Parser.token "has flow rate="
        |= Parser.int
        |. Parser.symbol ";"
        |. Parser.spaces
        |. Parser.oneOf [ Parser.token "tunnels lead to valves", Parser.token "tunnel leads to valve" ]
        |= Parser.sequence
            { start = ""
            , separator = ","
            , end = ""
            , spaces = Parser.chompWhile ((==) ' ')
            , item = valveIDParser
            , trailing = Parser.Forbidden
            }


valveIDParser : Parser.Parser ValveID
valveIDParser =
    Parser.getChompedString <|
        Parser.succeed ()
            |. Parser.chompWhile Char.isUpper



-- Calc (https://en.wikipedia.org/wiki/Floyd%E2%80%93Warshall_algorithm)


type alias Distances =
    Dict.Dict ( ValveID, ValveID ) Int


startingDistances : Valves -> Distances
startingDistances valves =
    let
        fn : ValveID -> Valve -> Distances -> Distances
        fn valveID1 valve distances =
            valve.next
                |> List.map (\valveID2 -> ( ( valveID1, valveID2 ), 1 ))
                |> Dict.fromList
                |> Dict.union distances
    in
    valves |> Dict.foldl fn Dict.empty


calcDistances : Valves -> Distances
calcDistances valves =
    let
        valveIDs : List ValveID
        valveIDs =
            valves |> Dict.keys

        fnForInBetween : ValveID -> Distances -> Distances
        fnForInBetween inBetweenValveID distances =
            valveIDs |> List.foldl (fnForStartValveIDs inBetweenValveID) distances

        fnForStartValveIDs : ValveID -> ValveID -> Distances -> Distances
        fnForStartValveIDs inBetween startValveID distances =
            valveIDs
                |> List.filter (not << (==) startValveID)
                |> List.foldl (fnForEndValveIDs inBetween startValveID) distances

        fnForEndValveIDs : ValveID -> ValveID -> ValveID -> Distances -> Distances
        fnForEndValveIDs inBetween startValveID endValveID distances =
            let
                full : Maybe Int
                full =
                    distances |> Dict.get ( startValveID, endValveID )

                half1 : Maybe Int
                half1 =
                    distances |> Dict.get ( startValveID, inBetween )

                half2 : Maybe Int
                half2 =
                    distances |> Dict.get ( inBetween, endValveID )
            in
            case full of
                Nothing ->
                    case ( half1, half2 ) of
                        ( Just d2, Just d3 ) ->
                            distances
                                |> Dict.insert
                                    ( startValveID, endValveID )
                                    (d2 + d3)

                        _ ->
                            distances

                Just d1 ->
                    case ( half1, half2 ) of
                        ( Just d2, Just d3 ) ->
                            if d1 > (d2 + d3) then
                                distances
                                    |> Dict.insert
                                        ( startValveID, endValveID )
                                        (d2 + d3)

                            else
                                distances

                        _ ->
                            distances
    in
    valveIDs |> List.foldl fnForInBetween (startingDistances valves)


searchBestPath : Distances -> Valves -> Int
searchBestPath distances valves =
    let
        unVisited =
            valves
                |> Dict.filter (\_ valve -> valve.rate > 0)
                |> Dict.keys
                |> Set.fromList

        rateOfStart =
            valves |> getRate "AA"
    in
    if rateOfStart == 0 then
        walk valves distances "AA" unVisited globalTime 0 0

    else
        0


type alias Time =
    Int


walk : Valves -> Distances -> ValveID -> Set.Set ValveID -> Time -> Int -> Int -> Int
walk valves distances valveID unVisited time bestCase currentPresure =
    let
        fn u bestCaseInner =
            let
                newTime =
                    time - (distances |> Dict.get ( valveID, u ) |> Maybe.withDefault 0) - 1

                newPresure =
                    currentPresure + (newTime * (valves |> getRate u))
            in
            if newTime <= 0 then
                max bestCaseInner currentPresure

            else
                walk valves distances u (unVisited |> Set.remove u) newTime bestCaseInner newPresure
    in
    if Set.isEmpty unVisited then
        max bestCase currentPresure

    else
        unVisited |> Set.foldl fn bestCase
