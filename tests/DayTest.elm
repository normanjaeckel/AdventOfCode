module DayTest exposing (suite)

import Day01
import Day02
import Day03
import Day04
import Day05
import Day06
import Day07
import Day08
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
        , describe "day 05"
            [ test "the first part is correct" <|
                \_ ->
                    Day05.run inputDay05
                        |> Tuple.first
                        |> Expect.equal "CMZ"
            , test "the second part is correct" <|
                \_ ->
                    Day05.run inputDay05
                        |> Tuple.second
                        |> Expect.equal "MCD"
            ]
        , describe "day 06"
            [ test "the first part is correct A" <|
                \_ ->
                    Day06.run "bvwbjplbgvbhsrlpgdmjqwftvncz"
                        |> Tuple.first
                        |> Expect.equal "5"
            , test "the first part is correct B" <|
                \_ ->
                    Day06.run "nppdvjthqldpwncqszvftbrmjlhg"
                        |> Tuple.first
                        |> Expect.equal "6"
            , test "the first part is correct C" <|
                \_ ->
                    Day06.run "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg"
                        |> Tuple.first
                        |> Expect.equal "10"
            , test "the first part is correct D" <|
                \_ ->
                    Day06.run "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw"
                        |> Tuple.first
                        |> Expect.equal "11"
            , test "the second part is correct A" <|
                \_ ->
                    Day06.run "mjqjpqmgbljsphdztnvjfqwrcgsmlb"
                        |> Tuple.second
                        |> Expect.equal "19"
            , test "the second part is correct B" <|
                \_ ->
                    Day06.run "bvwbjplbgvbhsrlpgdmjqwftvncz"
                        |> Tuple.second
                        |> Expect.equal "23"
            , test "the second part is correct C" <|
                \_ ->
                    Day06.run "nppdvjthqldpwncqszvftbrmjlhg"
                        |> Tuple.second
                        |> Expect.equal "23"
            , test "the second part is correct D" <|
                \_ ->
                    Day06.run "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg"
                        |> Tuple.second
                        |> Expect.equal "29"
            , test "the second part is correct E" <|
                \_ ->
                    Day06.run "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw"
                        |> Tuple.second
                        |> Expect.equal "26"
            ]
        , describe "day 07"
            [ test "the first part is correct" <|
                \_ ->
                    Day07.run inputDay07
                        |> Tuple.first
                        |> Expect.equal "95437"
            , test "the second part is correct" <|
                \_ ->
                    Day07.run inputDay07
                        |> Tuple.second
                        |> Expect.equal "24933642"
            ]
        , describe "day 08"
            [ test "the first part is correct" <|
                \_ ->
                    Day08.run inputDay08
                        |> Tuple.first
                        |> Expect.equal "No solution"
            , test "the second part is correct" <|
                \_ ->
                    Day08.run inputDay08
                        |> Tuple.second
                        |> Expect.equal "No solution"
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


inputDay05 : String
inputDay05 =
    "    [D]\n[N] [C]\n[Z] [M] [P]\n 1   2   3\n\nmove 1 from 2 to 1\nmove 3 from 1 to 3\nmove 2 from 2 to 1\nmove 1 from 1 to 2"


inputDay07 : String
inputDay07 =
    "$ cd /\n$ ls\ndir a\n14848514 b.txt\n8504156 c.dat\ndir d\n$ cd a\n$ ls\ndir e\n29116 f\n2557 g\n62596 h.lst\n$ cd e\n$ ls\n584 i\n$ cd ..\n$ cd ..\n$ cd d\n$ ls\n4060174 j\n8033020 d.log\n5626152 d.ext\n7214296 k"


inputDay08 : String
inputDay08 =
    ""
