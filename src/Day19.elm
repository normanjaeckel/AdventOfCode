module Day19 exposing (run)

import Dict
import Parser exposing ((|.), (|=))


run : String -> ( String, String )
run puzzleInput =
    ( runPartA puzzleInput, "No solution" )


runPartA : String -> String
runPartA puzzleInput =
    case puzzleInput |> Parser.run puzzleParser of
        Ok blueprints ->
            blueprints
                |> Dict.map (\_ bp -> walk bp 0 startingTime startingRobots [] startingResources)
                |> Dict.foldl (\k v totalQualityLevel -> (k * v) + totalQualityLevel) 0
                |> String.fromInt

        Err _ ->
            "Error"


puzzleParser : Parser.Parser (Dict.Dict Int Blueprint)
puzzleParser =
    Parser.loop Dict.empty
        (\blueprints ->
            Parser.oneOf
                [ Parser.succeed (\( id, bp ) -> blueprints |> Dict.insert id bp |> Parser.Loop)
                    |= blueprintParser
                , (Parser.succeed ()
                    |. Parser.end
                  )
                    |> Parser.map (always <| Parser.Done blueprints)
                ]
        )


blueprintParser : Parser.Parser ( Int, Blueprint )
blueprintParser =
    Parser.succeed
        (\id a b c d e f ->
            ( id
            , { oreRobot = a
              , clayRobot = b
              , obsidianRobot = ( c, d )
              , geodeRobot = ( e, f )
              }
            )
        )
        |. Parser.token "Blueprint"
        |. Parser.spaces
        |= Parser.int
        |. Parser.symbol ":"
        |. Parser.spaces
        |. Parser.token "Each ore robot costs"
        |. Parser.spaces
        |= Parser.int
        |. Parser.spaces
        |. Parser.token "ore."
        |. Parser.spaces
        |. Parser.token "Each clay robot costs"
        |. Parser.spaces
        |= Parser.int
        |. Parser.spaces
        |. Parser.token "ore."
        |. Parser.spaces
        |. Parser.token "Each obsidian robot costs"
        |. Parser.spaces
        |= Parser.int
        |. Parser.spaces
        |. Parser.token "ore and"
        |. Parser.spaces
        |= Parser.int
        |. Parser.spaces
        |. Parser.token "clay."
        |. Parser.spaces
        |. Parser.token "Each geode robot costs"
        |. Parser.spaces
        |= Parser.int
        |. Parser.spaces
        |. Parser.token "ore and"
        |. Parser.spaces
        |= Parser.int
        |. Parser.spaces
        |. Parser.token "obsidian."
        |. Parser.spaces


type alias Blueprint =
    { oreRobot : Int
    , clayRobot : Int
    , obsidianRobot : ( Int, Int )
    , geodeRobot : ( Int, Int )
    }


type Robot
    = Ore
    | Clay
    | Obsidian
    | Geode


type alias Robots =
    { ore : Int
    , clay : Int
    , obsidian : Int
    , geode : Int
    }


startingRobots : Robots
startingRobots =
    { ore = 1, clay = 0, obsidian = 0, geode = 0 }


type alias Resources =
    { ore : Int
    , clay : Int
    , obsidian : Int
    , geode : Int
    }


startingResources : Resources
startingResources =
    { ore = 0, clay = 0, obsidian = 0, geode = 0 }


startingTime : Int
startingTime =
    30


type Option
    = Skip
    | Build Robot


walk : Blueprint -> Int -> Int -> Robots -> List Robot -> Resources -> Int
walk blueprint bestCase time robots forbidden resources =
    if time == 1 then
        resources |> produceWith robots |> .geode

    else if maxProductionInTimeWith robots.geode time + resources.geode <= bestCase then
        0

    else
        let
            robotsList : List Robot
            robotsList =
                resources
                    |> whatCanIProduce blueprint

            optionList : List Option
            optionList =
                robotsList
                    |> List.filter (\robot -> forbidden |> List.member robot |> not)
                    |> mapToOptionWithSkip
                    |> onlyGeodeRobotIfPresent

            fn opt bc =
                case opt of
                    Build robot ->
                        resources
                            |> produceRobot blueprint robot
                            |> produceWith robots
                            |> walk blueprint bc (time - 1) (robots |> addOne robot) []

                    Skip ->
                        resources
                            |> produceWith robots
                            |> walk blueprint bc (time - 1) robots robotsList
        in
        optionList |> List.foldl fn bestCase


produceWith : Robots -> Resources -> Resources
produceWith robots resources =
    { ore = resources.ore + robots.ore
    , clay = resources.clay + robots.clay
    , obsidian = resources.obsidian + robots.obsidian
    , geode = resources.geode + robots.geode
    }


whatCanIProduce : Blueprint -> Resources -> List Robot
whatCanIProduce blueprint resources =
    [ Ore, Clay, Obsidian, Geode ]
        |> List.filter
            (\r ->
                case r of
                    Ore ->
                        blueprint.oreRobot <= resources.ore

                    Clay ->
                        blueprint.clayRobot <= resources.ore

                    Obsidian ->
                        blueprint.obsidianRobot |> (\( a, b ) -> (a <= resources.ore) && (b <= resources.clay))

                    Geode ->
                        blueprint.geodeRobot |> (\( a, b ) -> (a <= resources.ore) && (b <= resources.obsidian))
            )


produceRobot : Blueprint -> Robot -> Resources -> Resources
produceRobot blueprint robot resources =
    case robot of
        Ore ->
            { resources
                | ore = resources.ore - blueprint.oreRobot
            }

        Clay ->
            { resources
                | ore = resources.ore - blueprint.clayRobot
            }

        Obsidian ->
            { resources
                | ore = resources.ore - (blueprint.obsidianRobot |> Tuple.first)
                , clay = resources.clay - (blueprint.obsidianRobot |> Tuple.second)
            }

        Geode ->
            { resources
                | ore = resources.ore - (blueprint.geodeRobot |> Tuple.first)
                , obsidian = resources.obsidian - (blueprint.geodeRobot |> Tuple.second)
            }


mapToOptionWithSkip : List Robot -> List Option
mapToOptionWithSkip robots =
    Skip :: (robots |> List.map Build)


onlyGeodeRobotIfPresent : List Option -> List Option
onlyGeodeRobotIfPresent options =
    if options |> List.member (Build Geode) then
        [ Build Geode ]

    else
        options


addOne : Robot -> Robots -> Robots
addOne robot robots =
    case robot of
        Ore ->
            { robots | ore = robots.ore + 1 }

        Clay ->
            { robots | clay = robots.clay + 1 }

        Obsidian ->
            { robots | obsidian = robots.obsidian + 1 }

        Geode ->
            { robots | geode = robots.geode + 1 }


maxProductionInTimeWith : Int -> Int -> Int
maxProductionInTimeWith geodeRobots time =
    geodeRobots * time + (time * (time - 1) // 2)
