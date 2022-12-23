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
import Expect
import Test exposing (..)


suite : Test
suite =
    describe "Puzzle for"
        [ skip <|
            describe "day 01"
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
        , skip <|
            describe "day 02"
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
        , skip <|
            describe "day 03"
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
        , skip <|
            describe "day 04"
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
        , skip <|
            describe "day 05"
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
        , skip <|
            describe "day 06"
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
        , skip <|
            describe "day 07"
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
        , skip <|
            describe "day 08"
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
        , skip <|
            describe "day 09"
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
        , skip <|
            describe "day 10"
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
        , skip <|
            describe "day 11"
                [ test "the first part is correct" <|
                    \_ ->
                        Day11.run inputDay11
                            |> Tuple.first
                            |> Expect.equal "10605"
                , test "the second part is correct" <|
                    \_ ->
                        Day11.run inputDay11
                            |> Tuple.second
                            |> Expect.equal "2713310158"
                ]
        , skip <|
            describe "day 12"
                [ test "the first part is correct" <|
                    \_ ->
                        Day12.run inputDay12
                            |> Tuple.first
                            |> Expect.equal "31"
                , test "the second part is correct" <|
                    \_ ->
                        Day12.run inputDay12
                            |> Tuple.second
                            |> Expect.equal "29"
                ]
        , skip <|
            describe "day 13"
                [ test "the first part is correct" <|
                    \_ ->
                        Day13.run inputDay13
                            |> Tuple.first
                            |> Expect.equal "13"
                , test "the second part is correct" <|
                    \_ ->
                        Day13.run inputDay13
                            |> Tuple.second
                            |> Expect.equal "140"
                ]
        , skip <|
            describe "day 14"
                [ test "the first part is correct" <|
                    \_ ->
                        Day14.run inputDay14
                            |> Tuple.first
                            |> Expect.equal "24"
                , test "the second part is correct" <|
                    \_ ->
                        Day14.run inputDay14
                            |> Tuple.second
                            |> Expect.equal "93"
                ]
        , skip <|
            describe "day 15"
                [ test "the first part is correct" <|
                    \_ ->
                        Day15.run inputDay15
                            |> Tuple.first
                            |> Expect.equal "26"
                , test "the second part is correct" <|
                    \_ ->
                        Day15.run inputDay15
                            |> Tuple.second
                            |> Expect.equal "56000011"
                ]
        , skip <|
            describe "day 16"
                [ test "both parts are correct" <|
                    \_ ->
                        Day16.run inputDay16
                            |> Expect.all
                                [ Tuple.first >> Expect.equal "1651"
                                , Tuple.second >> Expect.equal "1707"
                                ]
                ]
        , skip <|
            describe "day 17"
                [ test "both parts are correct" <|
                    \_ ->
                        Day17.run inputDay17
                            |> Expect.all
                                [ Tuple.first >> Expect.equal "3068"
                                , Tuple.second >> Expect.equal "1514285714288"
                                ]
                ]
        , skip <|
            describe "day 18"
                [ test "both parts are correct" <|
                    \_ ->
                        Day18.run inputDay18
                            |> Expect.all
                                [ Tuple.first >> Expect.equal "64"
                                , Tuple.second >> Expect.equal "58"
                                ]
                ]
        , skip <|
            describe "day 19"
                [ test "both parts are correct" <|
                    \_ ->
                        Day19.run inputDay19
                            |> Expect.all
                                [ Tuple.first >> Expect.equal "33"
                                , Tuple.second >> Expect.equal "3472"
                                ]
                ]
        , describe "day 20"
            [ test "both parts are correct" <|
                \_ ->
                    Day20.run inputDay20Prod
                        |> Expect.all
                            [ Tuple.first >> Expect.equal "3"
                            , Tuple.second >> Expect.equal "No solution"
                            ]
            ]
        , describe "day 21"
            [ test "both parts are correct" <|
                \_ ->
                    Day21.run inputDay21
                        |> Expect.all
                            [ Tuple.first >> Expect.equal "No solution"
                            , Tuple.second >> Expect.equal "No solution"
                            ]
            ]
        , describe "day 22"
            [ test "both parts are correct" <|
                \_ ->
                    Day22.run inputDay22
                        |> Expect.all
                            [ Tuple.first >> Expect.equal "No solution"
                            , Tuple.second >> Expect.equal "No solution"
                            ]
            ]
        , describe "day 23"
            [ test "both parts are correct" <|
                \_ ->
                    Day23.run inputDay23
                        |> Expect.all
                            [ Tuple.first >> Expect.equal "No solution"
                            , Tuple.second >> Expect.equal "No solution"
                            ]
            ]
        , describe "day 24"
            [ test "both parts are correct" <|
                \_ ->
                    Day24.run inputDay24
                        |> Expect.all
                            [ Tuple.first >> Expect.equal "No solution"
                            , Tuple.second >> Expect.equal "No solution"
                            ]
            ]
        , describe "day 25"
            [ test "both parts are correct" <|
                \_ ->
                    Day25.run inputDay25
                        |> Expect.all
                            [ Tuple.first >> Expect.equal "No solution"
                            , Tuple.second >> Expect.equal "No solution"
                            ]
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
    "Sabqponm\nabcryxxl\naccszExk\nacctuvwj\nabdefghi\n"


inputDay13 : String
inputDay13 =
    "[1,1,3,1,1]\n[1,1,5,1,1]\n\n[[1],[2,3,4]]\n[[1],4]\n\n[9]\n[[8,7,6]]\n\n[[4,4],4,4]\n[[4,4],4,4,4]\n\n[7,7,7,7]\n[7,7,7]\n\n[]\n[3]\n\n[[[]]]\n[[]]\n\n[1,[2,[3,[4,[5,6,7]]]],8,9]\n[1,[2,[3,[4,[5,6,0]]]],8,9]\n"


inputDay14 : String
inputDay14 =
    "498,4 -> 498,6 -> 496,6\n503,4 -> 502,4 -> 502,9 -> 494,9\n"


inputDay15 : String
inputDay15 =
    "Sensor at x=2, y=18: closest beacon is at x=-2, y=15\nSensor at x=9, y=16: closest beacon is at x=10, y=16\nSensor at x=13, y=2: closest beacon is at x=15, y=3\nSensor at x=12, y=14: closest beacon is at x=10, y=16\nSensor at x=10, y=20: closest beacon is at x=10, y=16\nSensor at x=14, y=17: closest beacon is at x=10, y=16\nSensor at x=8, y=7: closest beacon is at x=2, y=10\nSensor at x=2, y=0: closest beacon is at x=2, y=10\nSensor at x=0, y=11: closest beacon is at x=2, y=10\nSensor at x=20, y=14: closest beacon is at x=25, y=17\nSensor at x=17, y=20: closest beacon is at x=21, y=22\nSensor at x=16, y=7: closest beacon is at x=15, y=3\nSensor at x=14, y=3: closest beacon is at x=15, y=3\nSensor at x=20, y=1: closest beacon is at x=15, y=3\n"


inputDay16 : String
inputDay16 =
    "Valve AA has flow rate=0; tunnels lead to valves DD, II, BB\nValve BB has flow rate=13; tunnels lead to valves CC, AA\nValve CC has flow rate=2; tunnels lead to valves DD, BB\nValve DD has flow rate=20; tunnels lead to valves CC, AA, EE\nValve EE has flow rate=3; tunnels lead to valves FF, DD\nValve FF has flow rate=0; tunnels lead to valves EE, GG\nValve GG has flow rate=0; tunnels lead to valves FF, HH\nValve HH has flow rate=22; tunnel leads to valve GG\nValve II has flow rate=0; tunnels lead to valves AA, JJ\nValve JJ has flow rate=21; tunnel leads to valve II\n"


inputDay17 : String
inputDay17 =
    ">>><<><>><<<>><>>><<<>>><<<><<<>><>><<>>\n"


inputDay18 : String
inputDay18 =
    "2,2,2\n1,2,2\n3,2,2\n2,1,2\n2,3,2\n2,2,1\n2,2,3\n2,2,4\n2,2,6\n1,2,5\n3,2,5\n2,1,5\n2,3,5\n"


inputDay19 : String
inputDay19 =
    "Blueprint 1:\n  Each ore robot costs 4 ore.\n  Each clay robot costs 2 ore.\n  Each obsidian robot costs 3 ore and 14 clay.\n  Each geode robot costs 2 ore and 7 obsidian.\n\nBlueprint 2:\n  Each ore robot costs 2 ore.\n  Each clay robot costs 3 ore.\n  Each obsidian robot costs 3 ore and 8 clay.\n  Each geode robot costs 3 ore and 12 obsidian.\n"


inputDay20 : String
inputDay20 =
    "1\n2\n-3\n3\n-2\n0\n4\n"


inputDay21 : String
inputDay21 =
    "No solution"


inputDay22 : String
inputDay22 =
    "No solution"


inputDay23 : String
inputDay23 =
    "No solution"


inputDay24 : String
inputDay24 =
    "No solution"


inputDay25 : String
inputDay25 =
    "No solution"


inputDay20Prod =
    "-2448\n-3172\n-3071\n3905\n7335\n-6575\n-3123\n-1695\n872\n-4240\n-2438\n-9804\n-423\n-4900\n3663\n-5053\n-6704\n5427\n8363\n-3965\n2061\n4143\n-3352\n8015\n8657\n3554\n3799\n-6100\n-9334\n4619\n745\n-5128\n5488\n3705\n-9449\n474\n6945\n8038\n6665\n242\n-2750\n600\n791\n8612\n5137\n-429\n-3333\n2318\n7877\n-8907\n-3232\n8319\n1969\n-7024\n7327\n5565\n3453\n1377\n-8504\n7724\n9419\n2304\n-3191\n9985\n-4022\n-3623\n-3405\n-817\n5851\n9\n-7548\n-7708\n9618\n9973\n799\n1858\n4291\n-1394\n-3209\n1755\n3754\n4169\n-1649\n-6380\n-191\n-964\n8816\n-4916\n4084\n-3051\n-9123\n8527\n-9484\n3352\n8477\n-7312\n6224\n-6803\n-5482\n4777\n6231\n2770\n7137\n8872\n8543\n3400\n5381\n-5296\n3732\n601\n-5177\n3564\n-7525\n8380\n-7345\n-8032\n4234\n-983\n-1934\n-5287\n-915\n-445\n7447\n-6387\n-6933\n7505\n828\n-5182\n-2702\n961\n-7601\n7241\n-2604\n8754\n423\n2807\n2759\n-2480\n7633\n-1673\n-916\n8416\n-2270\n4065\n5480\n-395\n5467\n4280\n5309\n7818\n2937\n8174\n6420\n1684\n7672\n7132\n7379\n4696\n8543\n-9864\n-5262\n6095\n9137\n340\n5189\n-1542\n6312\n9055\n9210\n-8332\n3192\n-9073\n8101\n1717\n4945\n9055\n3148\n-3033\n-4811\n9679\n-7982\n-6430\n4281\n2404\n2053\n-1640\n-3435\n-324\n6987\n3045\n4678\n-3104\n4915\n-9181\n8959\n7460\n-4177\n-3752\n1750\n-9139\n8327\n2905\n3172\n7170\n8661\n-6044\n7524\n9189\n3112\n6092\n3038\n-3555\n5141\n-2558\n-7226\n-8686\n4580\n8263\n8060\n9269\n1601\n-5939\n1294\n-8370\n1609\n-2648\n-3031\n-7812\n-8963\n-4910\n-8970\n-2043\n-5045\n1785\n-9267\n9555\n7920\n4163\n2501\n-2366\n-6528\n5477\n4004\n-1378\n3752\n-9912\n8196\n7008\n-3610\n6032\n-4244\n-251\n6119\n9061\n-8939\n-1459\n4853\n3414\n-2800\n231\n1496\n-3292\n-7761\n3308\n7510\n-1236\n6992\n6175\n5178\n-7405\n-6539\n-7041\n-956\n9680\n6614\n-6356\n5572\n-4702\n5418\n8792\n8196\n-6683\n-2797\n-6077\n8329\n-7131\n1388\n-932\n-9996\n-6205\n4398\n-2871\n3931\n-4516\n-187\n6690\n-7278\n-8560\n7539\n-7586\n8016\n8471\n8751\n-7343\n8561\n5941\n1119\n-6606\n4143\n-1101\n-7648\n2704\n8196\n-2879\n-1907\n-5619\n-1052\n3933\n-1355\n4483\n-6787\n-7671\n628\n8731\n-165\n-792\n5335\n-8616\n4339\n6020\n-2626\n-1934\n4001\n-6446\n-7218\n5358\n2962\n2340\n-4022\n7745\n-431\n3902\n8027\n-9508\n9098\n-4244\n7165\n-3785\n-7357\n8225\n-9904\n-3092\n2924\n-7932\n-1991\n4218\n3293\n-4065\n-5618\n1033\n-2348\n5322\n8070\n2937\n-4900\n-1051\n5915\n4101\n111\n-1010\n-7195\n-7086\n311\n-4202\n-8358\n-1811\n-5929\n7146\n4914\n-6887\n3505\n-3552\n-2232\n3813\n4385\n6982\n6829\n-8923\n-6222\n-5647\n-3931\n-9514\n-7739\n6966\n-5032\n3095\n3237\n-7171\n-734\n358\n-5782\n-2639\n-3585\n-1374\n5526\n1174\n-4643\n-7203\n-82\n-6994\n-4735\n8918\n9317\n9540\n2959\n4562\n4339\n-8696\n6797\n-7631\n5358\n310\n-1657\n5407\n-2929\n2788\n-4787\n4706\n5129\n-6715\n8503\n-5910\n-9465\n-1543\n3613\n-6651\n6469\n-4183\n8183\n923\n4334\n4385\n7510\n-3632\n4701\n-2507\n-301\n-3758\n1881\n-4455\n5540\n5916\n-2625\n-7950\n-5537\n4372\n-2871\n-4974\n9913\n-5910\n2841\n-1658\n-5585\n6338\n6012\n-214\n1120\n-8505\n-9342\n-3006\n3382\n3175\n8741\n6490\n7332\n-9177\n2379\n-4848\n6565\n1433\n1555\n4245\n-9669\n-6953\n-1107\n-6345\n-5721\n5889\n-4171\n6670\n3459\n4004\n7503\n-9876\n8425\n5570\n-1657\n1597\n-8171\n676\n6475\n-6767\n-7191\n3612\n-3671\n8463\n-4956\n-5865\n7958\n7801\n-4436\n2842\n3708\n-2891\n9064\n-2823\n7054\n-3075\n-5835\n-9204\n-983\n-6154\n3996\n-6188\n-6086\n328\n5154\n-8629\n-6771\n3473\n5768\n-2505\n-627\n1183\n3069\n-5830\n9742\n2061\n7272\n5916\n-37\n-500\n-9278\n698\n9874\n162\n-8357\n-3301\n7500\n-6914\n9905\n2161\n-1792\n5507\n5169\n-5316\n-5286\n1849\n-6199\n2051\n-9412\n5828\n-8621\n6482\n-3931\n-9280\n-2626\n1812\n-7573\n-4741\n5513\n2907\n4427\n-7367\n-9750\n-9371\n6274\n-5670\n4914\n126\n-7719\n-7752\n-4798\n-311\n5763\n-2438\n-6074\n7728\n-9998\n-5510\n-3741\n-5071\n1692\n-6889\n-4679\n-7304\n4333\n9257\n-648\n8183\n-4143\n3831\n-1568\n-1378\n2496\n2043\n-836\n-3409\n-7572\n8809\n2364\n7160\n3339\n7691\n3485\n3299\n1938\n1755\n5615\n-5743\n-4288\n3549\n1686\n-1961\n-3350\n-4216\n-9325\n-9385\n3230\n-6983\n3390\n9387\n-6650\n318\n85\n-2573\n-1599\n8914\n6369\n2793\n-5598\n1141\n-4900\n-9042\n-3350\n-8550\n3195\n-3473\n-3795\n-4059\n6144\n-6037\n-6208\n-1320\n2001\n7969\n3518\n4851\n-3538\n2671\n1012\n-8616\n-2965\n9842\n-2507\n1194\n9357\n-9527\n56\n-7008\n9844\n-2213\n-8845\n3045\n3585\n4264\n8918\n-4580\n6357\n-6592\n7108\n-3328\n1641\n5526\n513\n-8615\n5878\n8249\n6359\n536\n-4469\n-3268\n6931\n5753\n5000\n7789\n2278\n-1753\n-6733\n8647\n-1935\n-6485\n43\n4508\n-1673\n3770\n-5795\n678\n-2597\n2955\n5680\n7420\n-9250\n-752\n778\n-6551\n-453\n9474\n4005\n-4867\n1160\n-4679\n5021\n-9792\n3580\n7196\n-169\n3401\n-3332\n5694\n-9913\n4708\n29\n5716\n-2029\n-1189\n-3134\n8097\n-1116\n-6292\n6194\n-2234\n-8434\n-9484\n2109\n2844\n4405\n-4784\n-8721\n-6511\n2092\n3707\n-1119\n5948\n5677\n-8208\n3204\n-596\n-4244\n1858\n-5741\n6442\n5467\n8822\n-7964\n7679\n7094\n-4956\n-4021\n8882\n8819\n-9415\n8476\n5777\n-9975\n233\n-8823\n-7278\n8128\n204\n9189\n-9915\n-826\n-939\n-1356\n4405\n226\n-5849\n6069\n6303\n3242\n-596\n-5776\n-8523\n1865\n-4551\n-2772\n-5008\n-3172\n9114\n-5406\n5082\n-4121\n2194\n-2296\n8294\n1131\n2722\n5367\n-8761\n9765\n-2857\n-2952\n-8069\n-7167\n-9546\n4551\n314\n2136\n-8207\n799\n1730\n-7428\n8661\n-217\n-7629\n-9291\n3427\n-256\n9307\n8196\n-2228\n-1276\n-316\n9479\n8450\n-2163\n5022\n-5619\n1583\n-4391\n2157\n1366\n7743\n-2430\n-6541\n4090\n-5774\n-3877\n-1158\n-2871\n5227\n9286\n-5269\n9803\n-9097\n-7568\n-2448\n-6846\n6715\n-4630\n-4568\n9275\n-84\n-7806\n-3275\n-343\n-8889\n3819\n7842\n-3405\n4274\n5381\n6841\n-2846\n-2344\n3248\n6308\n6756\n8875\n-1278\n0\n-6406\n6202\n-272\n-3555\n-8504\n-7221\n-8158\n-6614\n639\n4409\n828\n2810\n7091\n807\n5992\n-5347\n8800\n-2166\n-5973\n9409\n8955\n3076\n9832\n1921\n-8001\n6849\n4622\n42\n8245\n-5547\n-6448\n8893\n8329\n-1377\n3519\n-1664\n6056\n-8317\n-1370\n-4956\n-1425\n-8859\n9637\n-4631\n3897\n6043\n4562\n-4522\n9068\n4139\n9330\n-6448\n-5383\n-2446\n310\n-9215\n-6044\n7459\n5305\n3832\n-2871\n9228\n-4622\n-9497\n4731\n7384\n-4023\n-4982\n6057\n-4911\n-8584\n788\n-4039\n-8613\n3620\n3089\n-302\n9246\n5299\n2063\n-9762\n8761\n5085\n4548\n1474\n6752\n-9354\n-3284\n5700\n-5856\n-3865\n2599\n-552\n3218\n-9003\n3905\n9039\n-4520\n-9535\n5066\n-4182\n-1065\n-7877\n4722\n3297\n-2464\n301\n-5046\n-4019\n-246\n-5209\n-763\n-8985\n3548\n-2179\n9973\n-4738\n-740\n8805\n5782\n6925\n-768\n-1548\n-9459\n721\n-9424\n8863\n-6074\n-3762\n-4175\n-7131\n813\n5595\n9957\n-4961\n-2783\n9357\n-8312\n1376\n4709\n-3229\n3401\n-8231\n7409\n-4617\n5082\n-9956\n5813\n7974\n-2456\n255\n8027\n-7864\n4619\n-7013\n-7583\n-9049\n-1497\n-3102\n-4703\n4701\n-6563\n1709\n-5585\n-3281\n874\n6528\n5837\n8240\n1282\n-1973\n-8616\n7754\n44\n3466\n-9459\n-6086\n2491\n-9254\n-7863\n6737\n5431\n3877\n1067\n1291\n4196\n-9015\n-4428\n2085\n-839\n1182\n4326\n4430\n-1102\n-551\n-2891\n8210\n-3789\n1627\n-2344\n5369\n-1983\n3323\n8734\n-3381\n-7785\n-4851\n1220\n7214\n-3480\n-404\n-7948\n3038\n7061\n6408\n-8771\n22\n8204\n-6741\n5245\n8446\n-6913\n4535\n-2513\n5715\n-9861\n-1368\n-5528\n3670\n-881\n-8763\n-2910\n-7248\n1122\n-3558\n-6716\n5682\n-3073\n-836\n9163\n-5960\n-1443\n-1552\n-6246\n9228\n8128\n5236\n3610\n-3455\n-3538\n8302\n2154\n-3666\n1954\n4839\n4541\n-3362\n6163\n1240\n9521\n4493\n-3453\n7496\n-2730\n8771\n-1764\n5467\n-6154\n-5360\n-1856\n4948\n-6993\n-552\n-3375\n1787\n7165\n-9988\n4914\n2626\n-3076\n2766\n9555\n560\n5547\n-4175\n8822\n-3362\n558\n-2690\n2751\n3721\n4322\n5797\n8472\n3088\n-9507\n271\n-8627\n6705\n2200\n-9073\n-8527\n-4231\n4323\n-2954\n-604\n261\n9208\n-4633\n-3037\n6376\n-1402\n2434\n3185\n8770\n-2379\n-9494\n6460\n1212\n4871\n1502\n-7481\n-3322\n955\n3892\n8661\n2032\n-3847\n-5101\n6806\n-939\n-3069\n3129\n5927\n7801\n6288\n3699\n9208\n7826\n1828\n-4923\n9000\n6909\n874\n-8811\n-4989\n2161\n4483\n7137\n5110\n-5803\n-7429\n9403\n-7915\n-4893\n4253\n-9298\n-1994\n1865\n-4719\n839\n123\n-6027\n-881\n4136\n2174\n353\n-2678\n3297\n9263\n4333\n-2379\n7801\n-7383\n-4022\n9973\n-3728\n-4736\n5820\n-5125\n2443\n6369\n-8290\n-1934\n3275\n-7321\n-7108\n3287\n-9428\n9742\n4914\n-4811\n-6541\n7291\n24\n141\n-4252\n1456\n8626\n-6218\n8635\n6569\n-9886\n2887\n-7772\n-3558\n8910\n3352\n-8963\n-9874\n-1783\n5621\n-3092\n-7440\n3951\n-8270\n-1188\n1339\n-337\n3327\n6233\n8523\n6511\n-1425\n6475\n-5870\n908\n3111\n3194\n-5413\n7305\n-5295\n-9786\n1247\n-6703\n-7744\n-3134\n2349\n8916\n-2144\n997\n3327\n-4801\n9828\n4032\n-8216\n-3536\n-5019\n5889\n4142\n-8799\n-9528\n-222\n867\n-1693\n-6585\n2596\n2753\n4336\n-9706\n2109\n-6802\n-1449\n8057\n-6219\n8473\n2819\n3227\n5082\n-9385\n6808\n4333\n4734\n8183\n6798\n3908\n-32\n-6293\n4369\n-1127\n7093\n-1784\n-2563\n8754\n5681\n-4483\n9937\n-1011\n5087\n-763\n957\n9593\n-2511\n6811\n5771\n-7034\n896\n-2549\n-1363\n4334\n-4614\n3268\n-8355\n-746\n-5510\n-3157\n-8687\n-4485\n5335\n-5336\n8302\n-8979\n-2484\n1000\n-8443\n-4461\n8981\n-8505\n-2223\n1320\n-7628\n-1180\n-8596\n-5230\n4520\n1339\n-7079\n-5743\n-7877\n4125\n1240\n2770\n4485\n6603\n-7212\n9913\n207\n-4730\n8940\n4063\n9632\n7833\n-9797\n163\n-944\n-287\n-5952\n-5259\n7175\n-5214\n-8662\n-9450\n-3785\n6094\n5623\n-9298\n-8285\n7183\n527\n42\n-1011\n-1868\n-9761\n6896\n73\n-6023\n7341\n-3214\n-4512\n-5530\n-7583\n8752\n2929\n2433\n8132\n-6215\n-809\n-9254\n9997\n-5803\n1958\n6471\n717\n5778\n-3354\n-7319\n-8907\n-2905\n3293\n3700\n2365\n1029\n2841\n-1842\n1175\n-3931\n-2387\n-7722\n-7345\n-8443\n-4849\n-7637\n6975\n-4696\n2624\n7854\n-4406\n7175\n4430\n3786\n-4835\n-4211\n8495\n-3547\n9556\n-9340\n-6575\n-2229\n-4406\n7183\n4510\n-8656\n1825\n8501\n-3754\n4958\n-2877\n2208\n2062\n2984\n8828\n4046\n6756\n1322\n5673\n7510\n3699\n9252\n9848\n-2501\n-9042\n-1587\n4789\n-7703\n5797\n6128\n105\n-4768\n8948\n-5504\n-173\n5698\n3567\n-6673\n-2891\n-5378\n8183\n-3458\n4653\n-5969\n3180\n-1048\n8751\n-5830\n-2217\n-7626\n-505\n1454\n-2072\n-5053\n-3638\n2779\n-2974\n-2229\n8821\n-2209\n-854\n7526\n-6626\n-2135\n-463\n9052\n7445\n1055\n-1530\n6787\n4063\n4985\n8524\n-9767\n-6223\n1854\n-6023\n4535\n-8365\n7679\n-1326\n-5119\n-6688\n8462\n-77\n3926\n9296\n-4503\n-287\n-4756\n1877\n-7165\n9688\n-946\n9583\n-9517\n-6640\n-4075\n-8587\n-2037\n562\n-689\n-3558\n4297\n-4216\n4915\n506\n-6358\n-5372\n3050\n-6929\n9830\n-2353\n9227\n4640\n-7278\n-2841\n3227\n-6532\n-4603\n1873\n4981\n6039\n-4023\n-1170\n4016\n-9146\n6186\n1717\n37\n7790\n-4979\n-9483\n-1427\n5837\n6537\n2059\n3827\n-1933\n1056\n6300\n-4231\n6639\n-1010\n-3279\n-5008\n-4233\n4073\n-8382\n-7260\n5547\n-3651\n5902\n3500\n8752\n1000\n-5859\n1513\n-8880\n3865\n258\n-3435\n2047\n-5930\n258\n2375\n-3768\n-7597\n-8790\n7822\n730\n6426\n1639\n-5382\n-9326\n-2069\n-9751\n6034\n3831\n1789\n1379\n514\n5877\n-7516\n7175\n-5661\n-8620\n9937\n-6023\n-8970\n7790\n-4972\n-6672\n-4149\n5393\n5317\n-3541\n-4772\n3622\n9828\n-2667\n7296\n6811\n1286\n1458\n-2729\n8360\n539\n4452\n-5822\n9296\n3861\n-3006\n-5697\n7310\n-8819\n-6636\n-4436\n-3144\n2109\n-3745\n-6364\n5142\n-2947\n-7838\n-7557\n5753\n2881\n-1811\n5027\n199\n9055\n-6640\n2523\n2082\n-4455\n-5119\n4580\n-8693\n7701\n6098\n5752\n-2717\n3622\n9055\n-8938\n-6056\n-9745\n-2676\n-6580\n3926\n4001\n-922\n-9762\n-9232\n-2585\n5303\n-1753\n9018\n-2528\n7102\n1928\n8917\n425\n7689\n-6421\n4715\n3162\n2896\n-2279\n2250\n4921\n-1401\n6070\n506\n6416\n8789\n8561\n2930\n-4267\n-4407\n-820\n9009\n4416\n-7580\n-2983\n-2059\n3275\n5359\n-6373\n-1959\n-6635\n-9367\n-4031\n-3646\n5289\n-2276\n-8993\n-4956\n6962\n2793\n-2214\n5392\n8079\n750\n-3011\n-6215\n264\n1039\n-1993\n-3352\n-222\n-8332\n5329\n-7637\n3935\n-5124\n9411\n-8505\n-6309\n-5601\n-7100\n2896\n-851\n-2729\n6772\n-9071\n9492\n-4474\n6082\n5557\n5131\n4773\n2295\n-2438\n-1226\n6929\n-5697\n9473\n-7226\n2063\n9452\n1384\n8486\n2051\n4753\n-4861\n-2818\n5291\n7470\n-1795\n-1675\n-278\n-1657\n1150\n-1550\n-1657\n-7837\n-7714\n-6845\n3895\n4533\n-8100\n-8219\n7774\n3148\n2845\n9280\n3978\n1681\n-8921\n-1610\n1656\n7249\n-4970\n-2543\n2512\n9838\n-1414\n-7481\n4875\n6224\n4410\n-6435\n2450\n-6560\n-146\n-4271\n-6729\n8533\n-9344\n748\n1750\n2952\n-428\n6041\n-2483\n7157\n3214\n-2484\n6188\n-9999\n4594\n5570\n-2494\n-2561\n7718\n8195\n-1836\n6483\n-2139\n-9799\n2481\n-3065\n3153\n3327\n4421\n-8673\n-7720\n4875\n7721\n1170\n1329\n9462\n1755\n8624\n9846\n3076\n8262\n-2877\n1529\n3907\n4260\n4875\n9009\n4816\n-4851\n-1749\n-7319\n8307\n6300\n-2557\n3431\n5142\n-8053\n-768\n-2673\n-503\n-8330\n9163\n542\n5027\n-881\n8294\n-5859\n-3062\n-2462\n-6688\n4652\n5018\n-3157\n-6316\n8405\n2934\n1538\n-5609\n2369\n7992\n-5629\n4460\n7359\n1928\n4721\n-1834\n-2945\n-3071\n1588\n-346\n6845\n1665\n2414\n-1019\n3100\n2161\n9187\n3737\n6773\n5875\n3841\n7245\n1662\n-2213\n-1614\n-5288\n8111\n-7723\n-7081\n-4675\n-3333\n141\n153\n-9939\n-5386\n-6291\n-6161\n8821\n-3911\n-6540\n-5969\n-7702\n8568\n2239\n-7028\n-5739\n79\n5992\n-2559\n7909\n9794\n-6529\n-534\n4652\n-6481\n412\n7378\n2187\n-1626\n6058\n5804\n-1658\n1390\n-7146\n-1612\n5467\n-9730\n-5197\n658\n-1170\n-2921\n-8742\n-6353\n4003\n882\n-8781\n-5435\n6411\n-6312\n270\n-6390\n-9937\n-1900\n4091\n-5382\n8545\n-9204\n-3657\n8190\n1076\n-679\n-7185\n9742\n2232\n-8726\n-2463\n-8230\n777\n8970\n1526\n2667\n6128\n3086\n-1917\n1326\n8495\n8575\n7291\n5623\n-5878\n-1976\n-3576\n-3117\n9131\n9943\n9061\n6172\n9838\n4318\n-7088\n-609\n9029\n-5806\n-9762\n-7652\n-8602\n-2226\n-5457\n5927\n-2500\n-3090\n-9799\n-6686\n-2895\n5880\n6369\n-7583\n7658\n-4158\n7416\n-8665\n-1761\n3895\n1183\n-6532\n-5654\n-8309\n-5619\n-2353\n-6770\n3207\n484\n3204\n3707\n-1440\n-8053\n2962\n5291\n6460\n-6575\n-5960\n-2794\n9563\n9722\n1877\n4036\n-1062\n5513\n-2702\n9267\n3248\n-882\n-1666\n-3463\n-5590\n-5372\n5591\n-2497\n2963\n-9755\n-7365\n-5219\n-8979\n-2429\n-5360\n4478\n813\n-5474\n-6154\n-503\n-362\n896\n6824\n4934\n-8761\n-3852\n6016\n9810\n1983\n-6616\n-9804\n9250\n2771\n-6457\n9499\n-7948\n172\n5178\n3253\n-6084\n7134\n5472\n-5413\n2926\n3388\n-415\n7352\n-4567\n9583\n-6423\n6626\n9677\n-7100\n-4149\n-6681\n-4457\n6162\n5972\n5474\n9810\n6746\n9973\n302\n9995\n473\n-3933\n-1208\n-3754\n-4407\n4336\n-4970\n-1460\n6854\n-5663\n-6720\n-6695\n-7055\n-8771\n-9415\n-8176\n9884\n-8908\n-2455\n-4435\n3055\n7310\n2233\n9132\n1323\n3813\n9628\n4412\n1872\n-272\n-561\n5385\n-997\n4150\n4953\n3237\n-7332\n-6041\n3831\n-4074\n8599\n-6643\n-3789\n-5510\n1873\n-3099\n-9412\n-8202\n-2520\n9394\n-9314\n4490\n2045\n-2356\n-1425\n7816\n9424\n-2082\n2735\n-4288\n4706\n-1646\n6900\n-6098\n5085\n2400\n-5780\n2434\n1216\n2527\n3693\n-3513\n-9188\n-9750\n9108\n933\n-4768\n-3751\n-7892\n1809\n1366\n-8681\n-6143\n-2590\n8683\n6879\n9113\n3459\n-7453\n4412\n4528\n1881\n2279\n-846\n-2820\n-74\n7881\n-4925\n-5900\n-2287\n6874\n3352\n9835\n-1962\n-8523\n-7637\n8571\n3284\n-6676\n-851\n8358\n9491\n3418\n4625\n6785\n5866\n1248\n-2964\n-6840\n-3191\n5720\n-3443\n9080\n-3820\n1337\n4080\n-452\n-2082\n-9100\n-8728\n3760\n1254\n-7321\n6396\n-5878\n-392\n-9484\n4847\n4002\n-382\n-7501\n-2806\n9646\n-7960\n-4292\n-6456\n6257\n-7516\n-970\n-5295\n4871\n-5483\n-1436\n-9843\n8599\n-9016\n933\n2809\n2663\n-1844\n-1116\n5367\n3729\n-7927\n-8616\n-2679\n-262\n-626\n7448\n2541\n5895\n-6215\n1553\n5813\n9104\n-4143\n-414\n4572\n-3369\n-7283\n4667\n-2682\n5642\n3241\n5995\n4643\n3635\n-2624\n1362\n-138\n-1226\n-7121\n-8190\n639\n-5319\n721\n-9764\n8058\n-6639\n-6715\n8281\n-1967\n-9260\n-4428\n-6661\n8666\n-8372\n-2329\n7208\n9419\n7462\n-5547\n2172\n-4338\n5482\n9447\n-865\n-8445\n-8948\n-529\n-9618\n8940\n7801\n-6643\n6576\n-3671\n5715\n105\n-1444\n-1784\n-7710\n-8419\n-7656\n9310\n8091\n-4644\n-4671\n565\n-4397\n-4389\n-7591\n8769\n6665\n7678\n-8096\n4735\n6618\n6865\n-1754\n-5089\n-9713\n9642\n2194\n-5656\n9257\n8650\n445\n4866\n617\n-5085\n-8190\n-7004\n-1085\n-2078\n1456\n8661\n-6293\n8571\n-9342\n-6182\n-2448\n6112\n-3184\n9553\n1553\n-2276\n-6353\n-7799\n5342\n-8913\n951\n6623\n-1116\n4163\n2735\n7978\n3806\n-522\n-7938\n-7065\n3851\n-4817\n-8542\n5432\n7613\n3813\n7871\n-7382\n-2262\n-9269\n4643\n4773\n6140\n3070\n3383\n-5769\n-7086\n-2573\n2696\n8037\n-4813\n3829\n-6588\n-4338\n5274\n3310\n819\n-7516\n3218\n1945\n6227\n9246\n-3362\n-3590\n-7637\n1908\n-9441\n7816\n-8217\n6393\n-5406\n-9050\n-8118\n4296\n-1414\n-6829\n6442\n5488\n1671\n-8378\n513\n-4379\n4606\n-6137\n-8463\n-7637\n6527\n9474\n4790\n5035\n-327\n-8195\n4063\n-4533\n8581\n-9117\n2620\n-1014\n6410\n-6687\n-7154\n-6341\n3044\n-8309\n-3104\n9715\n-2275\n1750\n-9414\n-4603\n5367\n-6905\n-1468\n-1355\n-7601\n-6423\n-1685\n3981\n-4233\n-6635\n-2120\n-9326\n7724\n3780\n127\n-9736\n2991\n9\n8450\n1748\n5677\n6410\n-5182\n-4261\n1899\n8875\n2729\n7974\n4102\n-2097\n6090\n6778\n-3394\n6410\n5177\n-4239\n3100\n-1515\n1832\n2426\n3505\n-8613\n2088\n6483\n3278\n8351\n2778\n-4590\n4136\n3589\n-2843\n-9137\n-5797\n1090\n2029\n-3752\n-6933\n3263\n6251\n3333\n1225\n-1101\n5571\n7624\n6084\n-5296\n7153\n-7932\n4961\n8910\n-4451\n1247\n-6441\n3963\n-1715\n4615\n-2964\n-8435\n-9497\n-292\n-8195\n3038\n-2194\n-6517\n-2497\n8748\n-263\n8666\n-8008\n7772\n6516\n1941\n-6657\n-2557\n6408\n-1468\n-637\n4402\n5877\n1950\n1035\n7282\n5435\n9020\n8206\n-106\n-734\n-5698\n8791\n-1326\n-7569\n-6996\n9460\n2758\n-7601\n3914\n-3538\n3003\n-3683\n-7450\n-531\n9419\n5482\n7245\n-9484\n-6547\n4541\n9848\n-1280\n9866\n3788\n3115\n1809\n-6580\n-1272\n5293\n5738\n-1188\n-2084\n1415\n-4933\n-9525\n-8440\n6804\n7991\n-4418\n5227\n-3275\n-1975\n6940\n-4000\n1379\n-9527\n2832\n-5311\n7332\n2962\n-1754\n2455\n6425\n790\n2432\n-2888\n-6926\n-3042\n2559\n6516\n7090\n-9440\n-7709\n-1134\n3221\n-5204\n-2553\n8038\n-9351\n-2687\n9568\n1800\n163\n7245\n7728\n5746\n9146\n-7322\n7247\n-9777\n5540\n4031\n7853\n6896\n4163\n5029\n-8761\n-320\n-5639\n4578\n-8831\n-391\n-4567\n9217\n9734\n-3877\n-2807\n-469\n-9741\n-5435\n-3321\n-8911\n7208\n8501\n-752\n-8495\n-2239\n-1410\n-8036\n8111\n-236\n926\n2899\n-6624\n7091\n3098\n-8692\n360\n-5755\n5885\n8990\n8917\n1551\n-6364\n8710\n8930\n6082\n5539\n-4389\n-1047\n-34\n-7184\n1359\n2978\n6523\n-3745\n3237\n-9204\n-963\n-7357\n6167\n9607\n-8013\n-8168\n-6026\n-9501\n918\n7053\n-1613\n-9261\n-8048\n8751\n-5776\n-7350\n2088\n-7525\n-9450\n-4995\n3693\n-6297\n8147\n-5691\n1063\n8390\n3270\n5295\n3932\n-8900\n7275\n-7319\n-7108\n3019\n8545\n226\n-2511\n-2055\n-6219\n6452\n7926\n702\n8523\n8383\n9452\n-5354\n-5288\n-9706\n-2438\n-1010\n-8219\n-5854\n-8673\n-2877\n6787\n-2629\n6945\n-8719\n-3482\n-2907\n9973\n-8627\n1441\n-246\n9191\n-3383\n6882\n-1561\n-2511\n-3420\n6987\n2041\n2364\n8464\n3599\n3989\n6971\n7926\n-8152\n6340\n-856\n-403\n-8572\n8174\n-2818\n5958\n-80\n-808\n9433\n-6896\n2424\n7460\n4055\n3592\n4040\n3056\n-9064\n-8096\n-5429\n-1211\n2415\n9617\n-6456\n8854\n-2965\n8916\n-7656\n-117\n-8821\n9680\n2164\n-9179\n-8771\n2051\n7613\n2848\n3648\n4377\n-5139\n-9825\n8654\n-4867\n-5307\n-4207\n-7863\n1459\n4432\n6437\n2474\n8383\n-3104\n-3616\n-2794\n-16\n9941\n5403\n9482\n4245\n-131\n5278\n1318\n4641\n-1213\n3050\n-3558\n-4656\n-1958\n1566\n9292\n-4565\n-2163\n9909\n6078\n-4902\n-6690\n7763\n2937\n-27\n7787\n3039\n8297\n7690\n2453\n4706\n7371\n7093\n8321\n9275\n-4332\n-173\n892\n204\n-4190\n9275\n-2513\n1696\n-8077\n-8762\n-8054\n-7340\n8696\n3749\n-1730\n-7579\n3094\n-9502\n514\n-6373\n1160\n5357\n4777\n4643\n-7249\n-1649\n1377\n-3844\n6821\n-6983\n-9246\n218\n458\n5736\n-8259\n-5034\n-9868\n-6606\n-3657\n-1129\n-9763\n-1929\n-3764\n7492\n-2208\n-3418\n-9569\n-932\n-8584\n8844\n-8730\n-1351\n5992\n6426\n-7650\n-392\n2353\n781\n-1015\n-3688\n-3327\n-5688\n9777\n-2257\n1538\n9359\n-1032\n4245\n5274\n4504\n5418\n2730\n-2681\n-7501\n-109\n-372\n258\n3542\n543\n1239\n7005\n8767\n-648\n4489\n4878\n3385\n7913\n-7930\n494\n-851\n-1787\n-5322\n5621\n8660\n-6106\n-8098\n6847\n-4275\n-2161\n2161\n5992\n-5564\n1812\n7539\n1988\n3002\n-6905\n6390\n-5328\n2101\n-1980\n-686\n-6700\n-89\n-1050\n-3204\n2623\n3908\n5828\n-4314\n6957\n468\n7510\n-9045\n-9015\n1908\n-3244\n552\n6311\n-2553\n-9021\n2047\n2961\n-4321\n2624\n5661\n9902\n9909\n4688\n1499\n9773\n-9455\n6069\n-138\n1170\n6308\n5344\n2415\n-9478\n-8343\n-634\n-4485\n-6687\n-2552\n-4845\n-2344\n-2126\n6520\n-9094\n-6430\n-3169\n5995\n-3731\n6907\n1865\n8909\n-8134\n8359\n9913\n1877\n-1353\n-8728\n-9088\n6145\n3246\n5232\n7459\n-987\n1119\n-309\n5740\n-7499\n-2616\n9547\n-835\n3507\n-8617\n6426\n1527\n3806\n6492\n-7787\n7834\n-4533\n-2232\n-9752\n-5528\n1337\n-3211\n-2081\n1144\n156\n-8580\n-5913\n8495\n-2841\n5626\n-2172\n3235\n3998\n3535\n5539\n-6056\n2491\n-3156\n236\n-7915\n-6158\n2029\n-8443\n-5448\n7596\n226\n368\n-9829\n1641\n-6029\n-8173\n9191\n-4124\n-534\n-9015\n7561\n-1010\n5503\n9838\n-1024\n-9475\n9972\n2671\n9424\n410\n5659\n7550\n4304\n8079\n-6841\n7688\n4209\n-7982\n6859\n6011\n-3655\n-8002\n-2052\n-4379\n9303\n-2068\n2314\n-8539\n5027\n5868\n-5530\n-9866\n1698\n2276\n-3895\n2725\n8450\n878\n-5386\n-8038\n-72\n-1545\n5150\n7912\n9578\n3246\n-4989\n-6528\n8246\n-6300\n-5213\n-3275\n-3209\n9588\n613\n-6347\n2947\n4382\n-5116\n6298\n8194\n-3597\n-4888\n-5628\n9574\n4307\n9035\n-44\n8476\n-3861\n-4927\n592\n4790\n-7383\n8118\n1015\n-4769\n-504\n-3938\n853\n8613\n7718\n5033\n6752\n2073\n3850\n-7547\n1646\n6289\n-490\n-6394\n1708\n5460\n631\n-6894\n9650\n-1333\n-243\n1406\n-5286\n-1071\n-3439\n-1010\n-170\n9540\n-7629\n5339\n1094\n-8523\n7857\n5499\n-8198\n6134\n-6504\n-3413\n-1797\n-4943\n9393\n-1155\n24\n-2232\n-1489\n-7181\n-3458\n-5592\n-427\n-4120\n3908\n-7703\n519\n-5951\n-8347\n448\n3341\n7500\n-3541\n163\n5400\n-3330\n-5461\n9607\n-2951\n645\n-3321\n-5431\n-1224\n-7274\n-9052\n-132\n3385\n-246\n4722\n2340\n9567\n7112\n9781\n-4889\n-83\n5948\n-7237\n7395\n-809\n-8341\n-7692\n-6560\n8061\n247\n-2841\n6455\n3100\n-1980\n1325\n-3422\n4847\n-5739\n-5217\n-5759\n9686\n-8827\n-1913\n-9481\n-6605\n-7115\n5859\n2775\n1661\n6616\n3610\n1251\n472\n-3383\n6428\n6606\n7897\n-5282\n9665\n-4649\n9433\n-6470\n9191\n-5275\n4191\n-3453\n-7703\n5274\n-5549\n-6866\n7296\n-1890\n3098\n3902\n3479\n7404\n7726\n-1854\n2618\n-5943\n-2296\n3308\n3468\n-5891\n4397\n7289\n2230\n6153\n3528\n-9497\n-3403\n1718\n-4333\n2365\n4643\n3313\n-8810\n-9614\n-9050\n7310\n3284\n2791\n9111\n6357\n-7077\n5094\n-7368\n7339\n-5743\n-7278\n-1966\n-1649\n-862\n7367\n6842\n6098\n-1976\n-4637\n2414\n-9915\n-6032\n-7352\n-6661\n-7525\n458\n-6771\n-8590\n1877\n4543\n-1580\n5592\n8842\n-4296\n8633\n-7284\n-4395\n-9993\n-9494\n6671\n3702\n8685\n3741\n-3580\n1474\n-6490\n-5567\n8097\n4453\n-6353\n-6364\n9596\n7633\n5965\n-7593\n1732\n9607\n4108\n-51\n5982\n162\n-9173\n4147\n-6415\n775\n7049\n6661\n-5025\n1255\n9891\n-4889\n141\n5017\n4328\n-3071\n2829\n-8395\n8722\n-8831\n-62\n7296\n-6353\n-5940\n8742\n4005\n6741\n9905\n6747\n-272\n8767\n1048\n9257\n9637\n-4972\n978\n-2624\n-3447\n2182\n7414\n-4660\n-4107\n6248\n5673\n-6996\n6905\n2825\n5001\n1494\n5304\n6966\n-9888\n2496\n994\n5931\n3272\n-2520\n3901\n3627\n9159\n-8817\n1329\n-875\n5499\n6702\n3295\n-1022\n8861\n-7171\n-6305\n4641\n-2678\n-1523\n2061\n9129\n-7772\n-342\n-1856\n-7863\n-7899\n-2823\n-3269\n-2597\n4734\n-9092\n-3689\n-5581\n1287\n1365\n2976\n-9555\n-4940\n-6457\n5127\n-2902\n-829\n7301\n4696\n-6346\n7086\n4337\n2232\n-4430\n3978\n2273\n-8856\n-2932\n-851\n7779\n-2242\n-7011\n7415\n-2895\n1460\n-9163\n8505\n7384\n-6415\n-5943\n-609\n6376\n-9745\n-468\n-5086\n1998\n241\n7780\n1913\n-6755\n-648\n-5274\n-6154\n-5124\n-7221\n-7236\n207\n9907\n188\n1923\n873\n5348\n-76\n-8751\n-2054\n-3977\n-3266\n7134\n-8692\n3737\n1249\n7844\n-9692\n4483\n-3794\n-1410\n-5086\n-2239\n7241\n2187\n-7382\n4756\n8723\n8722\n9150\n7832\n3539\n2759\n4898\n-4498\n5488\n-1943\n-3576\n-637\n1377\n4393\n-3433\n5310\n9894\n4143\n1831\n-1428\n3257\n-6272\n1911\n-9879\n8970\n2590\n6328\n592\n9364\n9296\n-5286\n-1035\n6804\n6383\n527\n-8922\n-8726\n-6888\n2681\n-2910\n8730\n7745\n7702\n5959\n-9750\n-4341\n9663\n3737\n4506\n-5793\n-7986\n-6013\n6824\n1708\n7822\n9542\n1131\n658\n9714\n7695\n-8330\n7808\n-5654\n-1010\n9842\n8128\n-6532\n-3104\n-5071\n3240\n9632\n-6639\n8329\n7008\n-9433\n8271\n814\n874\n-9324\n8079\n5293\n1107\n8602\n-8329\n3694\n7985\n3144\n-7021\n9474\n3123\n-8552\n2453\n-2303\n123\n-4424\n5157\n-6056\n-1\n-8703\n7156\n9357\n-9964\n-9541\n1877\n2180\n6474\n-4595\n-8766\n-2053\n5303\n-1001\n8220\n-9614\n-6975\n-3204\n4111\n-9294\n-9822\n418\n-8880\n8990\n-518\n9130\n-7673\n-336\n-8096\n-3031\n-4266\n-7008\n9937\n8095\n5959\n9865\n3858\n6940\n-4952\n2580\n-6537\n6913\n4782\n373\n6756\n-8728\n7282\n5335\n-1162\n3754\n4329\n1334\n-5780\n6301\n-4714\n-5219\n6259\n-2354\n4800\n6383\n-3558\n-6225\n8769\n-6926\n7535\n-66\n7321\n-2007\n3565\n8346\n6772\n-2563\n6162\n976\n9061\n8624\n-5354\n5716\n2434\n-9385\n-1753\n-4849\n5357\n6140\n-9114\n-7635\n-4616\n-1661\n-7714\n-109\n8465\n5571\n6039\n9563\n-8061\n-9643\n-2511\n9385\n1789\n-2462\n4093\n-8811\n-2192\n8472\n5849\n1854\n6709\n-1059\n-4522\n-4973\n-7176\n8162\n9820\n-4603\n6391\n-8430\n-2779\n3673\n2772\n8628\n9716\n-2366\n6835\n-5780\n-9754\n-1236\n-27\n-9777\n9363\n2967\n-3229\n8662\n8503\n472\n-8504\n6437\n-3182\n-6756\n1942\n6112\n-9555\n7969\n5969\n5720\n6737\n186\n3839\n-5024\n-885\n4318\n1767\n-4332\n3606\n3613\n1819\n-2376\n5736\n-9015\n4412\n-9298\n-7696\n5324\n6020\n7656\n5932\n9479\n3596\n9726\n1071\n1856\n6879\n1990\n7519\n2439\n8335\n6348\n7844\n-3123\n7512\n1535\n-6511\n3670\n-3651\n2348\n2481\n-6068\n-5386\n-2708\n9876\n871\n6499\n5478\n975\n-8703\n9041\n-861\n-7364\n2348\n2907\n-752\n-8371\n5982\n-5388\n1881\n-9736\n-2563\n1248\n3418\n566\n-7226\n8162\n-8447\n5317\n-2247\n5225\n-3133\n6153\n-9484\n514\n4002\n-3191\n473\n-6536\n-6172\n6166\n7278\n-6646\n6257\n8223\n3539\n5154\n2990\n-302\n-3354\n-3587\n-6725\n4715\n-9022\n3980\n-3995\n-4663\n9429\n-6457\n2003\n-3198\n7204\n-8286\n-324\n-5762\n4393\n6172\n-8748\n-1523\n-4121\n3827\n5210\n957\n-7618\n8258\n-3446\n-1695\n-7687\n7690\n5369\n-2189\n-4267\n-7574\n-3096\n-7583\n-2242\n-7796\n-7045\n6779\n-4552\n-7692\n2141\n-9473\n-7615\n-8529\n-3446\n9887\n-9484\n-4322\n8902\n-9913\n190\n-3116\n-9046\n2144\n4297\n-5555\n2991\n2113\n1286\n6496\n-8955\n897\n-5196\n4666\n-4748\n5967\n-2303\n-7877\n5042\n-9600\n3474\n9628\n8686\n904\n-8697\n-1005\n-5825\n-5443\n-4603\n-627\n1111\n204\n-8001\n9463\n-817\n8408\n-9267\n-5629\n2544\n565\n-2482\n-5732\n2093\n2866\n6122\n2778\n-3172\n9666\n1071\n1908\n7214\n1\n1818\n9433\n4218\n1601\n4001\n6460\n-5890\n4457\n7221\n-8900\n-5197\n9873\n-4946\n7679\n-970\n-7518\n-3656\n6580\n204\n5572\n-9278\n7262\n3548\n4004\n2853\n3640\n9501\n2753\n3086\n5480\n6267\n-5219\n-7465\n762\n4410\n-8407\n-1468\n3761\n-470\n1809\n639\n9039\n6962\n-6643\n-160\n7726\n-3134\n5965\n412\n-3292\n2907\n5592\n-7086\n-4807\n8252\n5189\n-298\n-3975\n-7415\n2599\n4426\n5555\n-7172\n-9107\n749\n1381\n6997\n4439\n8442\n-8292\n1507\n-6563\n-7221\n-2822\n5291\n3528\n-4437\n6293\n1441\n8252\n5877\n6556\n5125\n8801\n7214\n9979\n-1610\n-5910\n-8817\n9241\n7511\n-1754\n-3134\n-7539\n-7525\n1605\n2364\n6964\n5529\n-2446\n-4240\n-7465\n-481\n-1271\n-4768\n8588\n799\n2576\n8686\n-9485\n-9021\n-321\n7503\n858\n506\n-9767\n8955\n9583\n-6683\n7808\n-4747\n-8430\n-3966\n8352\n-4867\n-3931\n4782\n-5539\n3021\n4828\n1868\n-428\n-7187\n-7651\n5056\n9310\n7245\n-2142\n-7838\n4134\n8710\n4806\n-6524\n2861\n-1943\n6180\n-216\n3892\n1441\n5125\n-7874\n7742\n9995\n-9074\n-8542\n-4913\n-7948\n-9210\n-9714\n7718\n1063\n-32\n-2097\n-456\n-482\n-3514\n-4893\n-7679\n7969\n-3483\n3548\n6683\n-4774\n-7031\n-5104\n-4252\n-8552\n-860\n-5780\n8015\n6139\n-3542\n7021\n9973\n4333\n8662\n1553\n-2745\n6804\n-3776\n-6456\n-7140\n1998\n5752\n6087\n8553\n-2862\n-9718\n-2645\n2809\n-5464\n934\n2144\n8480\n-7326\n-841\n-156\n-5286\n-1354\n8257\n8470\n-9481\n6671\n-500\n-5404\n9315\n-6162\n2832\n9919\n-2029\n-5323\n8809\n2474\n-9809\n-8381\n9479\n-1860\n-5601\n-2230\n-3558\n-320\n4631\n-6161\n-8111\n1392\n8437\n-8054\n-2557\n5122\n4750\n-3134\n4398\n6020\n4430\n2055\n-1419\n1099\n-2335\n-5856\n-9216\n-7692\n-2511\n6825\n4875\n-8900\n5587\n766\n5232\n-6541\n317\n4027\n2931\n-1249\n-9485\n1368\n-6678\n-6541\n-2390\n3327\n-5240\n6841\n8718\n8196\n7204\n3302\n-1983\n-4322\n-8287\n2092\n1872\n-5805\n-1201\n4838\n-1798\n76\n-4760\n-3266\n2270\n566\n5779\n-4654\n-9123\n-3999\n-2760\n-9117\n-6890\n-9662\n-5893\n2455\n5419\n289\n-9789\n-1678\n844\n3850\n-4025\n8408\n-7697\n-5552\n1120\n-7246\n-3350\n-8451\n-5804\n6162\n-826\n-9916\n-9145\n-7440\n-4218\n-4299\n-1065\n-2309\n-9232\n-3865\n7177\n1886\n3087\n-3299\n-150\n8236\n-9517\n9111\n4102\n2433\n3935\n2427\n-6353\n4521\n-9519\n3666\n-1966\n-4107\n-6023\n-614\n-9699\n586\n7404\n-7217\n-4472\n-4603\n9000\n-9173\n4982\n-9169\n-2820\n-6161\n6032\n9382\n-5811\n-4296\n9803\n-8590\n-1399\n2704\n2710\n6656\n-8557\n-6889\n6726\n7862\n-9201\n6737\n1243\n-2661\n9003\n-1010\n6048\n-1091\n-2673\n-414\n4471\n2197\n-1695\n1530\n4893\n-983\n-9736\n-3853\n-7665\n2489\n1662\n-9491\n-1793\n-2114\n-368\n4893\n354\n-7042\n-4132\n-2891\n-9399\n104\n-5818\n2404\n-8156\n-8032\n-3102\n4853\n-6347\n3612\n1945\n-5050\n-2891\n3811\n-8341\n8403\n2054\n2481\n2349\n9047\n-8111\n6259\n2599\n-382\n7127\n8440\n-6477\n-4961\n18\n-7416\n-9178\n9722\n-9430\n-8096\n-4592\n8062\n6693\n412\n3481\n-4960\n4890\n7492\n7826\n6785\n3169\n4747\n4619\n-6006\n3057\n8398\n-4900\n-3071\n7105\n1099\n4198\n-7946\n3078\n-3541\n8344\n7464\n-9643\n-8457\n-2194\n8006\n264\n-1014\n7743\n-2760\n-1091\n-7044\n4939\n-1378\n835\n9178\n9383\n-2142\n-445\n-1646\n9172\n7978\n1549\n-8629\n-7866\n1223\n3980\n-8697\n8269\n3674\n-1834\n4735\n7404\n4004\n-1353\n-3002\n-5354\n6616\n7721\n-9984\n-3402\n8866\n-8305\n-9594\n9041\n1146\n-1378\n-643\n1531\n-319\n6802\n-5818\n-6642\n8273\n101\n-1132\n1665\n7759\n484\n5435\n-3801\n7547\n9454\n5076\n6862\n-4246\n-6650\n6483\n-4389\n-6350\n2013\n4903\n-3938\n-4098\n5977\n-6299\n4455\n3451\n7364\n9346\n9009\n-5893\n-5609\n5507\n-3542\n-2480\n3422\n-4413\n8729\n2273\n-9335\n-3438\n8821\n-8908\n1381\n3022\n-2743\n-4437\n-4316\n-3702\n-7960\n5543\n2506\n-7283\n3327\n-9278\n7703\n6527\n-6829\n-9103\n-4280\n7991\n-462\n6879\n1988\n-6391\n8945\n4088\n-7747\n4204\n-9169\n1861\n-3947\n4530\n9646\n7228\n-797\n3208\n1996\n-6309\n-1320\n5833\n7963\n-2022\n-8195\n-9006\n-297\n1950\n-8959\n5833\n-6583\n-346\n7270\n1377\n-4455\n-1117\n5753\n-5156\n7981\n-3381\n-2841\n-1211\n-1354\n-8195\n-9876\n-7389\n-7023\n-5910\n7745\n-1396\n-3359\n7350\n-8303\n6475\n-9451\n-7418\n5349\n-7635\n-9071\n745\n195\n-1107\n4638\n-262\n8327\n-855\n-9250\n-7239\n1708\n818\n-5484\n3607\n3620\n1243\n-2984\n7064\n9064\n-7407\n4692\n-3597\n2685\n-1011\n-8433\n-2537\n-626\n-8001\n-7304\n-8899\n-70\n-2243\n6938\n-8555\n9466\n4793\n5659\n4622\n8450\n6209\n5042\n8505\n-2717\n-3381\n3039\n-3483\n1881\n4871\n-7871\n1313\n-7072\n-5336\n1450\n7778\n-6578\n-8198\n-9808\n1599\n5827\n-5534\n-2354\n4125\n-6353\n7558\n-4042\n-3371\n5539\n3326\n-3434\n-8865\n-4629\n1294\n1628\n8486\n-8726\n-1798\n5021\n3676\n791\n4877\n9443\n-9448\n1211\n-5483\n-1966\n7615\n5740\n-2438\n-2287\n-6481\n5368\n-5166\n-9915\n3422\n-3542\n7016\n1868\n-6477\n7090\n-8687\n494\n-6983\n-8325\n3786\n-5283\n-4303\n-5628\n-3752\n-8447\n3366\n-9970\n4171\n-2076\n-7259\n8940\n8257\n-9041\n726\n-431\n-5812\n-9429\n8748\n-3099\n-2242\n-1216\n9383\n-9253\n784\n-7917\n2443\n-6508\n-2491\n-9567\n-3525\n7078\n8821\n2479\n5789\n6067\n5516\n2462\n-6592\n-5764\n5712\n7282\n498\n-6681\n-6022\n5885\n6442\n-6412\n1858\n4404\n-1993\n8198\n3788\n7213\n-9939\n-935\n-8332\n1390\n-6788\n-2065\n-4839\n-7243\n8752\n6134\n4965\n1291\n6528\n4188\n9080\n865\n5189\n514\n5422\n-922\n7897\n-4910\n1616\n8194\n2771\n-8347\n-4754\n9907\n-4537\n-2818\n8812\n-2354\n-5456\n5618\n8012\n7387\n3972\n5082\n-9177\n781\n-6093\n-6626\n5478\n-8449\n-8515\n-6481\n4919\n-8482\n2778\n-1993\n6821\n4345\n7829\n3578\n-1526\n-1494\n6277\n-8290\n-9073\n4369\n-7450\n-5627\n-7135\n-8504\n2325\n-8800\n9478\n2274\n6229\n-8158\n8162\n-9898\n-3702\n5178\n559\n9024\n-3796\n-1816\n-7525\n3418\n3459\n-2080\n-6076\n-5976\n-7959\n9357\n-1953\n9239\n5964\n-9757\n-2114\n6349\n-4451\n1460\n5529\n8708\n3867\n-3977\n3073\n-7000\n601\n5795\n7445\n-4568\n-8457\n-2494\n-7481\n1662\n934\n-4364\n-5448\n"
