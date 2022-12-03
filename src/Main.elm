module Main exposing (main)

import Browser
import Day01
import Dict
import Html exposing (..)
import Html.Attributes exposing (attribute, class, for, id, placeholder, required, rows, value)
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
        ]


type alias Model =
    { content : String
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
    Model "" (Day 1 Day01.run)



-- UPDATE


type Msg
    = FormField String
    | FormDay Int


update : Msg -> Model -> Model
update msg model =
    case msg of
        FormField c ->
            { model | content = c }

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
                    ( i, fn model.content )
    in
    div [ classes "container p-3 pb-5" ]
        [ main_ []
            [ h1 [ class "pb-5" ] [ text "Advent Of Code 2022" ]
            , form [ classes "row mb-5" ]
                [ div [ class "col-4" ]
                    [ label
                        [ class "form-label"
                        , for "selectDay"
                        ]
                        [ text "Select day" ]
                    , select
                        [ class "form-select"
                        , id "selectDay"
                        , attribute "aria-label" "Select day"
                        , onInput (String.toInt >> Maybe.withDefault 0 >> FormDay)
                        ]
                        (List.map
                            (\i -> option [ value (String.fromInt i) ] [ text <| String.fromInt i ])
                            (List.range 1 24)
                        )
                    ]
                ]
            , h2 [ class "mb-3" ] [ text <| "Result for day " ++ (Tuple.first result |> String.fromInt) ]
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
                        , value model.content
                        ]
                        []
                    ]
                , div [ class "col-4" ]
                    [ Tuple.second result |> Tuple.first |> text ]
                , div [ class "col-4" ]
                    [ Tuple.second result |> Tuple.second |> text ]
                ]
            ]
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
