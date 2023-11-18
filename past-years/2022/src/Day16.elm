module Day16 exposing (run)

import Dict
import Parser exposing ((|.), (|=))
import Set


type PuzzlePart
    = PuzzlePartA
    | PuzzlePartB


run : String -> ( String, String )
run puzzleInput =
    ( runPart puzzleInput PuzzlePartA
    , runPart puzzleInput PuzzlePartB
    )


runPart : String -> PuzzlePart -> String
runPart puzzleInput puzzlePart =
    case puzzleInput |> Parser.run puzzleParser of
        Ok valves ->
            let
                distances =
                    calcDistances valves
            in
            valves
                |> Dict.filter (\_ valve -> valve.rate > 0)
                |> searchBest distances puzzlePart
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


globalTime : PuzzlePart -> Int
globalTime part =
    case part of
        PuzzlePartA ->
            30

        PuzzlePartB ->
            26


globalStartValveID : String
globalStartValveID =
    "AA"


type alias Presure =
    Int


type alias TeamMember =
    { valveID : ValveID
    , time : Int
    , presure : Presure
    }


type alias Team =
    { inGame : List TeamMember
    , out : List TeamMember
    , bestPresure : Presure
    }


searchBest : Distances -> PuzzlePart -> Valves -> Presure
searchBest distances puzzlePart valves =
    let
        allRelevantValves : Set.Set ValveID
        allRelevantValves =
            valves
                |> Dict.filter (\_ valve -> valve.rate > 0)
                |> Dict.keys
                |> Set.fromList

        startingTeam : Team
        startingTeam =
            let
                oneMember =
                    { valveID = globalStartValveID
                    , time = globalTime puzzlePart
                    , presure = 0
                    }
            in
            case puzzlePart of
                PuzzlePartA ->
                    { inGame = [ oneMember ], out = [], bestPresure = 0 }

                PuzzlePartB ->
                    { inGame = [ oneMember, oneMember ], out = [], bestPresure = 0 }

        rateOfStart =
            valves |> getRate globalStartValveID
    in
    if rateOfStart == 0 then
        walk
            valves
            distances
            startingTeam
            allRelevantValves
            |> .bestPresure

    else
        0


walk :
    Valves
    -> Distances
    -> Team
    -> Set.Set ValveID
    -> Team
walk valves distances team unVisited =
    let
        fn : ValveID -> Team -> Team
        fn u innerTeam =
            let
                fn2 : Int -> { team : Team, found : Bool } -> { team : Team, found : Bool }
                fn2 _ acc =
                    if acc.found then
                        acc

                    else
                        case acc.team.inGame of
                            [] ->
                                acc

                            onTurn :: rest ->
                                case tryToGoTo valves distances onTurn u of
                                    Nothing ->
                                        { team =
                                            { inGame = rest
                                            , out = onTurn :: acc.team.out
                                            , bestPresure = acc.team.bestPresure
                                            }
                                        , found = False
                                        }

                                    Just ( newTime, newPresure ) ->
                                        { team =
                                            { inGame = rest ++ [ { onTurn | valveID = u, time = newTime, presure = newPresure } ]
                                            , out = acc.team.out
                                            , bestPresure = acc.team.bestPresure
                                            }
                                        , found = True
                                        }

                container : { team : Team, found : Bool }
                container =
                    List.range 1 (List.length innerTeam.inGame)
                        |> List.foldl fn2 { team = innerTeam, found = False }

                --|> Debug.log "container"
            in
            if container.found then
                -- Walk in with new team
                let
                    bp : Presure
                    bp =
                        walk
                            valves
                            distances
                            container.team
                            (unVisited |> Set.remove u)
                            |> .bestPresure
                in
                { innerTeam | bestPresure = bp }

            else
                -- Take current presure of team and put it into bestPresure of team if it is greater, then return team
                { innerTeam
                    | bestPresure =
                        max
                            ((innerTeam.inGame ++ innerTeam.out) |> List.map .presure |> List.sum)
                            innerTeam.bestPresure
                }
    in
    if Set.isEmpty unVisited then
        -- Take current presure of team and put it into bestPresure of team if it is greater, then return team
        { team
            | bestPresure =
                max
                    ((team.inGame ++ team.out) |> List.map .presure |> List.sum)
                    team.bestPresure
        }

    else
        unVisited |> Set.foldl fn team


tryToGoTo : Valves -> Distances -> TeamMember -> ValveID -> Maybe ( Int, Presure )
tryToGoTo valves distances teamMember targetValveID =
    let
        newTime =
            teamMember.time - (distances |> Dict.get ( teamMember.valveID, targetValveID ) |> Maybe.withDefault 0) - 1

        newPresure =
            teamMember.presure + (newTime * (valves |> getRate targetValveID))
    in
    if newTime <= 0 then
        Nothing

    else
        Just ( newTime, newPresure )



--     comparePathAndPresure : Path -> Presure -> Path -> Presure -> ( Path, Presure )
--     comparePathAndPresure path1 presure1 path2 presure2 =
--         if presure1 > presure2 then
--             ( path1, presure1 )
--         else
--             ( path2, presure2 )
