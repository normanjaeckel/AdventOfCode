module Day01Test exposing (suite)

import Day01
import Expect
import Test exposing (..)


suite : Test
suite =
    describe "Day 1"
        [ test "first part" <|
            \_ ->
                let
                    input =
                        "1000\n2000\n3000\n\n4000\n\n5000\n6000\n\n7000\n8000\n9000\n\n10000\n"
                in
                Day01.run input
                    |> Tuple.first
                    |> Expect.equal "24000"
        , test "second part" <|
            \_ ->
                let
                    input =
                        "1000\n2000\n3000\n\n4000\n\n5000\n6000\n\n7000\n8000\n9000\n\n10000\n"
                in
                Day01.run input
                    |> Tuple.second
                    |> Expect.equal "45000"
        ]
