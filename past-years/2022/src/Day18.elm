module Day18 exposing (run)

import Parser exposing ((|.), (|=))
import Set


run : String -> ( String, String )
run puzzleInput =
    ( runPartA puzzleInput, runPartB puzzleInput )


runPartA : String -> String
runPartA puzzleInput =
    case puzzleInput |> Parser.run puzzleParser of
        Ok cubes ->
            cubes
                |> getSurface
                |> String.fromInt

        Err _ ->
            "Error"


runPartB : String -> String
runPartB puzzleInput =
    case puzzleInput |> Parser.run puzzleParser of
        Ok cubes ->
            cubes
                |> getOuterSurface
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


type alias Space =
    Set.Set String



-- Part A


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



-- Part B


type alias MinMax =
    { xMin : Int, xMax : Int, yMin : Int, yMax : Int, zMin : Int, zMax : Int }


getMinMax : List Cube -> MinMax
getMinMax cubes =
    let
        fn : Cube -> MinMax -> MinMax
        fn (Cube x y z) result =
            { xMin = min x result.xMin
            , xMax = max x result.xMax
            , yMin = min y result.yMin
            , yMax = max y result.yMax
            , zMin = min z result.zMin
            , zMax = max z result.zMax
            }

        m : MinMax
        m =
            cubes
                |> List.foldl
                    fn
                    { xMin = 100000, xMax = 0, yMin = 100000, yMax = 0, zMin = 100000, zMax = 0 }
    in
    { xMin = m.xMin - 1
    , xMax = m.xMax + 1
    , yMin = m.yMin - 1
    , yMax = m.yMax + 1
    , zMin = m.zMin - 1
    , zMax = m.zMax + 1
    }


getOuterSurface : List Cube -> Int
getOuterSurface cubes =
    let
        m : MinMax
        m =
            getMinMax cubes

        cubeSet : Set.Set String
        cubeSet =
            cubes |> List.map toString |> Set.fromList

        firstWater : Cube
        firstWater =
            Cube m.xMin m.yMin m.zMin
    in
    if cubeSet |> Set.member (firstWater |> toString) then
        -1

    else
        walk cubeSet m { water = firstWater |> toString |> Set.singleton, newWater = [ firstWater ], surface = 0 }
            |> .surface


type alias Accumulator =
    { water : Set.Set String
    , newWater : List Cube
    , surface : Int
    }


walk : Set.Set String -> MinMax -> Accumulator -> Accumulator
walk cubes m acc =
    let
        fn1 : Cube -> ( List Cube, Int ) -> ( List Cube, Int )
        fn1 cube ( n, s ) =
            cube
                |> adjacent
                |> List.filter (not << outOf)
                |> List.filter (\c -> List.member c n |> not)
                |> List.filter (\c -> acc.water |> Set.member (c |> toString) |> not)
                |> List.foldl fn2 ( n, s )

        fn2 : Cube -> ( List Cube, Int ) -> ( List Cube, Int )
        fn2 cube ( n, s ) =
            if cubes |> Set.member (cube |> toString) then
                ( n, s + 1 )

            else
                ( cube :: n, s )

        ( possibleNext, newSurface ) =
            acc.newWater |> List.foldl fn1 ( [], 0 )

        outOf : Cube -> Bool
        outOf (Cube x y z) =
            (x < m.xMin)
                || (y < m.yMin)
                || (z < m.zMin)
                || (x > m.xMax)
                || (y > m.yMax)
                || (z > m.zMax)

        newAcc : Accumulator
        newAcc =
            { acc
                | water = acc.water |> Set.union (possibleNext |> List.map toString |> Set.fromList)
                , newWater = possibleNext
                , surface = acc.surface + newSurface
            }
    in
    if List.length newAcc.newWater == 0 then
        newAcc

    else
        walk cubes m newAcc


adjacent : Cube -> List Cube
adjacent (Cube x y z) =
    [ Cube (x - 1) y z
    , Cube (x + 1) y z
    , Cube x (y - 1) z
    , Cube x (y + 1) z
    , Cube x y (z - 1)
    , Cube x y (z + 1)
    ]
