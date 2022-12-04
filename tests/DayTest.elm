module DayTest exposing (suite)

import Day01
import Day02
import Day03
import Day04
import Expect
import Test exposing (..)


suite : Test
suite =
    describe "Puzzle for"
        [ describe "day 01"
            [ test "the first part is correct" <|
                \_ ->
                    Day01.run inputDay01
                        |> Tuple.first
                        |> Expect.equal "24000"
            , test "the second part is correct" <|
                \_ ->
                    Day01.run inputDay01
                        |> Tuple.second
                        |> Expect.equal "45000"
            ]
        , describe "day 02"
            [ test "the first part is correct" <|
                \_ ->
                    Day02.run inputDay02
                        |> Tuple.first
                        |> Expect.equal "15"
            , test "the second part is correct" <|
                \_ ->
                    Day02.run inputDay02
                        |> Tuple.second
                        |> Expect.equal "12"
            ]
        , describe "day 03"
            [ test "the first part is correct" <|
                \_ ->
                    Day03.run inputDay03
                        |> Tuple.first
                        |> Expect.equal "157"
            , test "the second part is correct" <|
                \_ ->
                    Day03.run inputDay03
                        |> Tuple.second
                        |> Expect.equal "70"
            ]
        , describe "day 04"
            [ test "the first part is correct" <|
                \_ ->
                    Day04.run inputDay04
                        |> Tuple.first
                        |> Expect.equal "2"
            , test "the second part is correct" <|
                \_ ->
                    Day04.run inputDay04
                        |> Tuple.second
                        |> Expect.equal "4"
            ]
        ]



-- , describe "day ..."
--     [ test "the first part is correct" <|
--         \_ ->
--             Day....run inputDay...
--                 |> Tuple.first
--                 |> Expect.equal "No solution"
--     , test "the second part is correct" <|
--         \_ ->
--             Day....run inputDay...
--                 |> Tuple.second
--                 |> Expect.equal "No solution"
--     ]


inputDay01 : String
inputDay01 =
    "1000\n2000\n3000\n\n4000\n\n5000\n6000\n\n7000\n8000\n9000\n\n10000\n"


inputDay02 : String
inputDay02 =
    "A Y\nB X\nC Z"


inputDay03 : String
inputDay03 =
    "vJrwpWtwJgWrhcsFMMfFFhFp\njqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL\nPmmdzqPrVvPwwTWBwg\nwMqvLMZHhHMvwLHjbvcjnnSBnvTQFn\nttgJtRGJQctTZtZT\nCrZsJsPPZsGzwwsLwLmpwMDw"


inputDay04 : String
inputDay04 =
    "2-4,6-8\n2-3,4-5\n5-7,7-9\n2-8,3-7\n6-6,4-6\n2-6,4-8\n"
