module Day18 exposing (run)

import Parser exposing ((|.), (|=))
import Set


run : String -> ( String, String )
run puzzleInput =
    ( runPartA puzzleInput, "No solution" )


runPartA : String -> String
runPartA puzzleInput =
    case puzzleInput |> Parser.run puzzleParser of
        Ok cubes ->
            cubes
                |> getSurface
                |> String.fromInt

        Err _ ->
            "Error"


type Cube
    = Cube Int Int Int


puzzleParser : Parser.Parser (List Cube)
puzzleParser =
    Parser.loop []
        (\all ->
            Parser.oneOf
                [ Parser.succeed (\cube -> cube :: all |> Parser.Loop)
                    |= cubeParser
                    |. Parser.symbol "\n"
                , (Parser.succeed ()
                    |. Parser.end
                  )
                    |> Parser.map (always <| Parser.Done (List.reverse all))
                ]
        )


cubeParser : Parser.Parser Cube
cubeParser =
    Parser.succeed (\x y z -> Cube x y z)
        |= Parser.int
        |. Parser.symbol ","
        |= Parser.int
        |. Parser.symbol ","
        |= Parser.int



-- type alias MinMax =
--     { xMin : Int, xMax : Int, yMin : Int, yMax : Int, zMin : Int, zMax : Int }
-- getMinMax : List Cube -> MinMax
-- getMinMax cubes =
--     let
--         fn : Cube -> MinMax -> MinMax
--         fn (Cube x y z) result =
--             { xMin = min x result.xMin
--             , xMax = max x result.xMax
--             , yMin = min y result.yMin
--             , yMax = max y result.yMax
--             , zMin = min z result.zMin
--             , zMax = max z result.zMax
--             }
--     in
--     cubes
--         |> List.foldl
--             fn
--             { xMin = 1000, xMax = 0, yMin = 1000, yMax = 0, zMin = 1000, zMax = 0 }


type State
    = Empty
    | Lava


type alias Space =
    Set.Set String


getSurface : List Cube -> Int
getSurface cubes =
    cubes
        |> List.foldl foldFn ( Set.empty, 0 )
        |> Tuple.second


foldFn : Cube -> ( Space, Int ) -> ( Space, Int )
foldFn cube ( space, surface ) =
    let
        newSurface =
            surface + 6 - (2 * neighbours space cube)
    in
    ( space |> Set.insert (cube |> toString), newSurface )


toString : Cube -> String
toString (Cube x y z) =
    [ x, y, z ] |> List.map String.fromInt |> String.join ","


neighbours : Space -> Cube -> Int
neighbours space (Cube x y z) =
    let
        x1 : Cube
        x1 =
            Cube (x - 1) y z

        x2 : Cube
        x2 =
            Cube (x + 1) y z

        y1 : Cube
        y1 =
            Cube x (y - 1) z

        y2 : Cube
        y2 =
            Cube x (y + 1) z

        z1 : Cube
        z1 =
            Cube x y (z - 1)

        z2 : Cube
        z2 =
            Cube x y (z + 1)
    in
    [ x1, x2, y1, y2, z1, z2 ]
        |> List.filter (\n -> space |> Set.member (toString n))
        |> List.length
