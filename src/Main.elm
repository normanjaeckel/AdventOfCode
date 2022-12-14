module Main exposing (main)

import Browser
import Day01
import Day02
import Day03
import Day04
import Day05
import Day06
import Day07
import Day08
import Day09
import Day10
import Day11
import Day12
import Day13
import Day14
import Day15
import Day16
import Day17
import Day18
import Day19
import Day20
import Day21
import Day22
import Day23
import Day24
import Day25
import Dict
import Html exposing (..)
import Html.Attributes exposing (attribute, class, disabled, placeholder, required, rows, selected, value)
import Html.Events exposing (onInput)


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }



-- MODEL


allDays : Dict.Dict DayNumber DayFunc
allDays =
    Dict.fromList
        [ ( 1, Day01.run )
        , ( 2, Day02.run )
        , ( 3, Day03.run )
        , ( 4, Day04.run )
        , ( 5, Day05.run )
        , ( 6, Day06.run )
        , ( 7, Day07.run )
        , ( 8, Day08.run )
        , ( 9, Day09.run )
        , ( 10, Day10.run )
        , ( 11, Day11.run )
        , ( 12, Day12.run )
        , ( 13, Day13.run )
        , ( 14, Day14.run )
        , ( 15, Day15.run )
        , ( 16, Day16.run )
        , ( 17, Day17.run )
        , ( 18, Day18.run )
        , ( 19, Day19.run )
        , ( 20, Day20.run )
        , ( 21, Day21.run )
        , ( 22, Day22.run )
        , ( 23, Day23.run )
        , ( 24, Day24.run )
        , ( 25, Day25.run )
        ]


type alias Model =
    { puzzleInput : String
    , day : Day
    }


type Day
    = Day DayNumber DayFunc


type alias DayNumber =
    Int


type alias DayFunc =
    String -> ( String, String )


init : Model
init =
    Model "" (Day 0 notImplementedFn)



-- UPDATE


type Msg
    = FormField String
    | FormDay Int


update : Msg -> Model -> Model
update msg model =
    case msg of
        FormField c ->
            { model | puzzleInput = c }

        FormDay d ->
            let
                fn =
                    allDays |> Dict.get d |> Maybe.withDefault notImplementedFn
            in
            { model | day = Day d fn }


notImplementedFn : String -> ( String, String )
notImplementedFn _ =
    ( "Not implemented", "Not implemented" )



-- VIEW


view : Model -> Html Msg
view model =
    let
        result =
            case model.day of
                Day i fn ->
                    ( i, fn model.puzzleInput )
    in
    div [ classes "container p-3 pb-5" ]
        [ main_ []
            ([ h1 [ class "pb-5" ] [ text "Advent Of Code 2022" ]
             , form [ classes "row mb-5" ]
                [ div [ class "col-4" ]
                    [ select
                        [ class "form-select"
                        , attribute "aria-label" "Select day"
                        , onInput (String.toInt >> Maybe.withDefault 0 >> FormDay)
                        ]
                        (option [ selected True, disabled True ] [ text "Select day" ]
                            :: List.map
                                (\i -> option [ value (String.fromInt i) ] [ text <| String.fromInt i ])
                                (List.range 1 25)
                        )
                    ]
                ]
             ]
                ++ (if Tuple.first result > 0 then
                        [ div []
                            [ h2 [ class "mb-3" ] [ text <| "Result for day " ++ (Tuple.first result |> String.fromInt) ]
                            , form
                                [ classes "row mb-5" ]
                                [ div [ classes "col-4" ]
                                    [ textarea
                                        [ class "form-control"
                                        , rows 5
                                        , placeholder "Puzzle input"
                                        , attribute "aria-label" "Puzzle input"
                                        , required True
                                        , onInput FormField
                                        , value model.puzzleInput
                                        ]
                                        []
                                    ]
                                , div [ class "col-4" ]
                                    [ Tuple.second result |> Tuple.first |> text ]
                                , div [ classes "col-4 font-monospace" ]
                                    [ Tuple.second result |> Tuple.second |> text ]
                                ]
                            ]
                        ]

                    else
                        []
                   )
            )
        ]


{-| This helper takes a string with class names separated by one whitespace. All
classes are applied to the result.
import Html exposing (..)
view : Model -> Html msg
view model =
div [ classes "center with-border nice-color" ][ text model.content ]
-}
classes : String -> Html.Attribute msg
classes s =
    let
        cl : List ( String, Bool )
        cl =
            String.split " " s |> List.map (\c -> ( c, True ))
    in
    Html.Attributes.classList cl
