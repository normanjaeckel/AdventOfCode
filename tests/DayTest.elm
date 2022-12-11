module DayTest exposing (suite)

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
                        |> Expect.equal "21"
            , test "the second part is correct" <|
                \_ ->
                    Day08.run inputDay08
                        |> Tuple.second
                        |> Expect.equal "8"
            ]
        , describe "day 09"
            [ test "the first part is correct" <|
                \_ ->
                    Day09.run inputDay09a
                        |> Tuple.first
                        |> Expect.equal "13"
            , test "the second part is correct a" <|
                \_ ->
                    Day09.run inputDay09a
                        |> Tuple.second
                        |> Expect.equal "1"
            , test "the second part is correct b" <|
                \_ ->
                    Day09.run inputDay09b
                        |> Tuple.second
                        |> Expect.equal "36"
            ]
        , describe "day 10"
            [ test "the first part is correct" <|
                \_ ->
                    Day10.run inputDay10
                        |> Tuple.first
                        |> Expect.equal "13140"
            , test "the second part is correct" <|
                \_ ->
                    Day10.run inputDay10
                        |> Tuple.second
                        |> Expect.equal "##..##..##..##..##..##..##..##..##..##..\n###...###...###...###...###...###...###.\n####....####....####....####....####....\n#####.....#####.....#####.....#####.....\n######......######......######......####\n#######.......#######.......#######....."
            ]
        , describe "day 11"
            [ test "the first part is correct" <|
                \_ ->
                    Day11.run inputDay11
                        |> Tuple.first
                        |> Expect.equal "No solution"
            , test "the second part is correct" <|
                \_ ->
                    Day11.run inputDay11
                        |> Tuple.second
                        |> Expect.equal "No solution"
            ]
        , describe "day 12"
            [ test "the first part is correct" <|
                \_ ->
                    Day12.run inputDay12
                        |> Tuple.first
                        |> Expect.equal "No solution"
            , test "the second part is correct" <|
                \_ ->
                    Day12.run inputDay12
                        |> Tuple.second
                        |> Expect.equal "No solution"
            ]
        , describe "day 13"
            [ test "the first part is correct" <|
                \_ ->
                    Day13.run inputDay13
                        |> Tuple.first
                        |> Expect.equal "No solution"
            , test "the second part is correct" <|
                \_ ->
                    Day13.run inputDay13
                        |> Tuple.second
                        |> Expect.equal "No solution"
            ]
        , describe "day 14"
            [ test "the first part is correct" <|
                \_ ->
                    Day14.run inputDay14
                        |> Tuple.first
                        |> Expect.equal "No solution"
            , test "the second part is correct" <|
                \_ ->
                    Day14.run inputDay14
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
    "30373\n25512\n65332\n33549\n35390"


inputDay09a : String
inputDay09a =
    "R 4\nU 4\nL 3\nD 1\nR 4\nD 1\nL 5\nR 2"


inputDay09b : String
inputDay09b =
    "R 5\nU 8\nL 8\nD 3\nR 17\nD 10\nL 25\nU 20\n"


inputDay10 : String
inputDay10 =
    "addx 15\naddx -11\naddx 6\naddx -3\naddx 5\naddx -1\naddx -8\naddx 13\naddx 4\nnoop\naddx -1\naddx 5\naddx -1\naddx 5\naddx -1\naddx 5\naddx -1\naddx 5\naddx -1\naddx -35\naddx 1\naddx 24\naddx -19\naddx 1\naddx 16\naddx -11\nnoop\nnoop\naddx 21\naddx -15\nnoop\nnoop\naddx -3\naddx 9\naddx 1\naddx -3\naddx 8\naddx 1\naddx 5\nnoop\nnoop\nnoop\nnoop\nnoop\naddx -36\nnoop\naddx 1\naddx 7\nnoop\nnoop\nnoop\naddx 2\naddx 6\nnoop\nnoop\nnoop\nnoop\nnoop\naddx 1\nnoop\nnoop\naddx 7\naddx 1\nnoop\naddx -13\naddx 13\naddx 7\nnoop\naddx 1\naddx -33\nnoop\nnoop\nnoop\naddx 2\nnoop\nnoop\nnoop\naddx 8\nnoop\naddx -1\naddx 2\naddx 1\nnoop\naddx 17\naddx -9\naddx 1\naddx 1\naddx -3\naddx 11\nnoop\nnoop\naddx 1\nnoop\naddx 1\nnoop\nnoop\naddx -13\naddx -19\naddx 1\naddx 3\naddx 26\naddx -30\naddx 12\naddx -1\naddx 3\naddx 1\nnoop\nnoop\nnoop\naddx -9\naddx 18\naddx 1\naddx 2\nnoop\nnoop\naddx 9\nnoop\nnoop\nnoop\naddx -1\naddx 2\naddx -37\naddx 1\naddx 3\nnoop\naddx 15\naddx -21\naddx 22\naddx -6\naddx 1\nnoop\naddx 2\naddx 1\nnoop\naddx -10\nnoop\nnoop\naddx 20\naddx 1\naddx 2\naddx 2\naddx -6\naddx -11\nnoop\nnoop\nnoop\n"


inputDay11 : String
inputDay11 =
    "Monkey 0:\n  Starting items: 79, 98\n  Operation: new = old * 19\n  Test: divisible by 23\n    If true: throw to monkey 2\n    If false: throw to monkey 3\n\nMonkey 1:\n  Starting items: 54, 65, 75, 74\n  Operation: new = old + 6\n  Test: divisible by 19\n    If true: throw to monkey 2\n    If false: throw to monkey 0\n\nMonkey 2:\n  Starting items: 79, 60, 97\n  Operation: new = old * old\n  Test: divisible by 13\n    If true: throw to monkey 1\n    If false: throw to monkey 3\n\nMonkey 3:\n  Starting items: 74\n  Operation: new = old + 3\n  Test: divisible by 17\n    If true: throw to monkey 0\n    If false: throw to monkey 1\n"


inputDay12 : String
inputDay12 =
    "No solution"


inputDay13 : String
inputDay13 =
    "No solution"


inputDay14 : String
inputDay14 =
    "No solution"
