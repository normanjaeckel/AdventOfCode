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
        , skip <|
            describe "day 20"
                [ test "both parts are correct" <|
                    \_ ->
                        Day20.run inputDay20
                            |> Expect.all
                                [ Tuple.first >> Expect.equal "3"
                                , Tuple.second >> Expect.equal "1623178306"
                                ]
                ]
        , describe "day 21"
            [ test "both parts are correct" <|
                \_ ->
                    Day21.run inputDay21
                        |> Expect.all
                            [ Tuple.first >> Expect.equal "152"
                            , Tuple.second >> Expect.equal "301"
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
    "root: pppw + sjmn\ndbpl: 5\ncczh: sllz + lgvd\nzczc: 2\nptdq: humn - dvpt\ndvpt: 3\nlfqf: 4\nhumn: 5\nljgn: 2\nsjmn: drzm * dbpl\nsllz: 4\npppw: cczh / lfqf\nlgvd: ljgn * ptdq\ndrzm: hmdt - zczc\nhmdt: 32\n"


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


xxx =
    "jwql: tqsm * svnj\ndbzh: 5\ngnsg: cscc * mpjs\nzmrg: tscm * nscs\nmdgm: 2\npbrd: 2\nzlcn: zvnj * mrrb\nblml: 9\nrdsl: dgcp * vhfh\nlsth: sbjp * cwzv\nwhth: mdgm * sjgn\nclcj: pcms * blml\njqvn: 7\ntfvn: 5\njzbv: 4\nqvgc: 3\nnpqm: 2\nljqw: 2\nlddv: pfqq / vpsr\nhlcp: rmjw * dfsr\nhfss: 14\nrzwz: 2\njsrs: vqzw - mrfv\nsmbr: ltrm - nsrr\nqpth: hmgv * wjpp\nvhfh: jsms * wqrt\nnwqn: 5\nfvmv: 13\nvcfh: fbtw + djcj\nswzm: 2\nwvwf: 4\nfbcc: 7\nqgtn: 14\ntlqm: pnvf + gsdr\nmpqs: 14\nrmhj: 2\nvznw: zhvz * lhcr\nrvlm: phps - hbcq\ndnvd: 3\nldvj: rjld * zrwh\nzcpc: fgdw + vvqq\nfjwb: 2\nmfqc: 20\njrgn: szvz * jzbv\nmdgl: 4\npcch: vmmw * mrcm\npscr: 15\nllpb: crlj * jfnp\nzjgt: 10\nnmmz: 1\nrdmc: 8\ntpmz: wnms * ztnq\nsbwb: 4\njpdw: 2\nmstb: mvrp * mqhl\ngmsj: rzfz + thnb\nflnj: 5\nbpjm: 3\njdqq: 9\nmnrl: wjzg / rdmc\ntdnb: 3\nhhgt: 2\ngjdq: qgfq * nmzt\nndrd: 2\nmspz: npbq * qsfj\njqvz: 3\nmrst: vjqw + dbpv\nlljn: 2\nswjc: 3\njwph: 11\ndjqp: 8\nrpcj: vrlf * qppr\nllbw: nqwl + pljj\nnddv: 2\nqsgv: vzft * gczl\npsfs: lvdf - mmlw\nccft: mdrn * mstb\nlfvh: brjc * dndb\nczgl: 3\nwzfs: npcm + bfgr\nmgzs: 3\ntnmz: zztb + jtpw\nhqnp: 3\nnwbb: mzbv + rvsv\nrgjt: 3\nrnnq: 2\nwdll: wlvl * rfdf\ngldc: 4\nchzd: qpqn / zmfn\nhsnn: 4\nwtcd: 3\nhfzr: 8\nzclt: gffg * gvpn\nnctf: 7\njmvc: 5\nrmfw: tgrf + lsnc\nvvwr: 4\ncwpc: dvlb * dctl\nfwzt: jgpd * rftp\ntznf: sglm * jsqw\ntfwm: 2\njmqz: 2\ncrcz: vwpc * lsrv\njpsb: 2\njnqm: qqtc * hlzd\nqgrs: pnbb + tfvn\nbbhz: 4\nqwqw: pgdm + rvfr\nbpfl: smbd + jrrq\njlbh: flgh + qqbd\ntsnv: 2\nvpsr: 2\ncttg: lfgc * bbhz\ntjcm: 4\npgph: nmzl * jzhw\ncntc: gwpn * qmjn\ntgch: 6\nzjdz: 4\nsjch: 4\ntdqn: dphb / rmhj\nhbtr: 2\njphc: 3\nbwhb: drft + nptq\nzvvw: 3\nlwdc: trzp + wzfd\nzmbb: 4\nrhgq: 3\nhzpg: 4\nsmbd: 3\nhhbj: 10\npsdb: gfsh + wtwv\nltng: whcv * hqch\ngnfz: 11\nhzwg: jsvd * cbdg\ncbdg: gzmv * qdtj\ngljf: 3\npnbb: 2\ndlcz: 11\ntzmm: 3\nlhjp: 2\ncnlm: ztgr * mqst\ngcjd: 3\ngbgw: czqs * wzsn\nsqsc: 1\ndqbq: thth * zptv\ndvrd: 8\ndnhs: nvmr + ggfm\nhprc: 1\nstls: 3\nmgsz: rjhl + fhvc\nswth: mgzc * mccr\nndzf: rwwf + lfdb\nlszf: psdm * hhds\npwtz: jmqz * zwdd\ntnhm: ggll + hpmd\ntdhr: 5\nmqrv: rwqw * vdbq\ngrrb: 3\nhfdq: wwmq + gqlq\nwgmn: 10\ntrzp: fqhp * tcpf\nvblr: 5\nmflt: 2\ngvcr: 2\nrvrp: 6\npdpj: 3\nrfmr: 7\ntrcg: 5\nvwcc: 4\nmdlr: 3\nflwl: 2\nrzfd: 8\nzlbd: jpgp + mzmr\nccnp: wqlf * pqmw\ncdgd: 3\ncggc: wsfs + rpdf\npczj: jgmg * bcmd\ndvww: 5\nzngh: ndbs * dczh\nwrlp: pgts * jpsb\nbvrn: 5\ndtnc: gdrl + lsdf\nfdhc: pwrg * ppwg\nhpdd: 2\nfwln: 4\njtbj: dtdj * vsqt\nwdqq: 4\nwjsq: jldj - cglz\ndjlm: 2\nvjqw: nfnw * wjlh\nggvc: bvvc * grws\nwbft: ccnp + wsbv\ntsvq: nqjg + qbbv\nsnwb: wdwp + pdbf\nrpdf: fzwr + fhrb\nvgzr: 2\nzhvz: mcbj * dmmh\ncpvn: 5\nrprh: 3\nqdtj: 2\nsdcr: lhfl + twrb\ncswv: 1\ndnbq: wwzp + wdnv\nzrpj: 2\ncgtg: 17\njstb: 5\nhwmg: wmmt + vwff\nrbmm: 11\nhfbv: 5\nhcsr: 2\ngczl: 2\nflbp: lsbq * wzdf\ncqzm: 14\nhgfg: blqj * glws\nvqwv: 2\ndjfh: 5\nrnnm: 4\nppwp: 3\nbpgc: mftz + dfrl\nlzwp: mqzg + bcdg\ndphc: bjpr + qmdr\nsbcl: 2\nswcn: nrpj + vvhd\nntqn: vthq + zfsf\nsflq: 4\npfbd: 8\nmwwf: 2\nbzzl: dpcf + smjj\ntnmv: 2\nsszs: 2\nvfmv: dbqw * bgjf\nhlzd: 5\ngnpz: 2\nsgcv: 4\nrgtd: pgzn - mfzn\ngttj: 3\nwwmq: gchw + pqhs\nhpzr: prwg * jdwq\ntdvg: wqch + bnmr\npwrg: cbsm - cdhh\nqmvv: wbrr + lpmb\ntjmg: qdzq / wfjf\nzclc: ljng + gmsj\ntqwl: 5\nszwd: btpg * swtj\nnmjq: htww * dwpw\nccqq: 2\nmnqc: qzrj * tsnv\npdcc: 2\nfzzt: cwnw * wdvh\nfbnq: 1\nfsdw: 3\nqlcr: qcst * ctgg\nqjcz: 2\nntfg: 2\nhvsg: mgzs * nwbb\nncrb: ljtw + wclb\nnwgd: qqdj * fssq\nqbrz: szgs - thjb\nwvsc: nmjq + twql\ndmbl: bvpf + zdbl\ndbqq: 2\ngrln: 2\nhzpt: hsfn + smvj\nmbnh: 13\ncjvq: 2\nptbt: hpdz / qtwd\ncncc: 10\nqgld: 1\ncsgw: 3\nsnlv: 7\nnshb: qvmg * ccft\ntmhr: 6\ndtlj: 9\nwzsh: dfld * nlzv\nthrm: 4\nszgv: qdbz - tzsp\nqpqs: 12\nrcqf: bwdg * mhmw\nzddm: mhtm - fjzq\nrjhl: vqgm * qnnl\nrvfp: bqbb * jgrd\nmjqq: fbcc * zbnw\ndfjl: wfwm + dhsh\ncnrj: 2\nnmpt: vtzc - ffbd\nhgvw: qnww * slhm\ncghj: vnrr * ttrc\nnmzt: 5\nbmsc: btbr * hmrb\ndprf: lbht + bvtd\nhpfr: 11\nsvnj: 2\nfppg: cqzm + hlqb\npccp: 17\nnmgl: 5\nchnh: 4\nhmwf: bfqz * bvwp\ntmpv: 9\njfnp: ljlj + htvj\nvfrz: 3\nllzl: tdqn * swzm\nwjhg: fgbg + mtmt\nrljp: 5\nfdjr: ddtt * pdmm\njgvd: mflt * prsr\njpgp: gzsv + tvrh\ntlsr: 3\nwpln: 2\nrvsv: htbd * fmpg\nmfdj: ljjb + ppzf\nzchq: 5\ndpgj: sqpd * qqjr\nwvdg: dwnf * jdbd\ntgfs: 2\nrbvm: fdvb * zfpr\njsvd: jrgn + bwts\nfcns: hfzr * rljp\nbwll: 3\ncpfw: 2\nmqqh: 3\ndgcp: 7\nsfvg: zrvq * stfm\nnfzh: ppvm * bhlr\nbqvr: 20\nbhvl: 7\ntwnp: 2\nwjpp: gmld + pggp\ndwpw: 2\nndfj: rhnv * nqhd\ngczg: 1\npthm: rvbn * ppld\nlwgd: 3\ngdsq: qwwl - jzth\nbjzb: mstr * mslc\ngtjc: twnp * hgwg\nwcps: 13\nsbqt: cnfh * cdnl\ngflq: 5\nwvfr: 6\nfqbn: nsmv + jnqw\nqdjt: 5\nblpr: 3\nbnnw: dccl + fmnd\nmrmz: 8\ndnjl: lnwm * jqdc\nhnbl: tlnz - nqvl\nbnmd: 3\nhchd: 20\ngsbn: mdcf * ldch\nwhzz: 2\nhpdl: gjzt * rzfd\npdvp: 14\ncvjl: 11\nhmdt: 3\nntqj: 4\nmnjr: svvl + cwdv\nqpwh: 5\nlmcn: 5\nhfmg: zvdj * tgcc\nwvtc: nrcs + jwcv\ncqdw: cvld + wdjq\nqtwd: lcst * zrmr\nwdqw: 7\nlhpt: gqvv * dfnh\nrllb: 5\nlrpc: 9\nfqjw: cdmb * cswj\nbcvc: 3\nlthz: zqwp + qwjp\nvdmn: 4\nbgjf: 5\nbhfc: 6\nfwgr: 2\nvjmr: bclh + tncl\nvpcl: tbrs * ssvr\nzlsb: 6\nbmcp: cmgl * mdqs\nfmfm: 7\nfmnd: hnhs + cbpw\nlzzq: 5\nltsr: 5\nbcdg: 2\nrjwd: 5\nqbnw: dpmq + mqzv\nrfmq: 2\nrdpq: wnfd - stvc\nchbq: fzzt - vznw\njcbp: hdpr * swpr\nvbqp: 2\ntprf: 11\nvvgt: bjrl + mrmz\nnrdn: nmgl * cdvg\nrdmt: chmf * tmgq\njvpl: dlrc + szgd\ndmnv: wcbw + sjcb\nptjj: jlpb * prqv\nzlbp: nqvv * dmnv\ntrcd: mqbd * wlpf\nrdgb: pjlg + twpb\nmtmt: 3\nwqlf: 14\nrzvt: wttp * ssqc\ntlbn: tbqg + rswm\ntffd: 2\njdvb: 14\nvthq: 1\nfghp: 4\ndzgp: 19\nswcp: 2\nhmgv: 2\nlzlp: nqbp * vlft\nwjtp: lhwn + wvtm\nqznj: wzbm * zlcn\njnhj: 2\nfwhh: 7\nmftz: fcsr * jfrp\nwjpt: dfjl + zppz\nphvl: ttzn + swcp\nqdrm: qsjh * llzj\ngrmr: jqnh - qsjc\ndnpj: 2\ncvfz: 7\nnrdc: 3\nftvs: 5\nqnww: hfss + rhcs\nfhhh: fhbb - brvb\nnpcm: 5\nddzr: 2\nprzn: ptff + trrt\nrtvg: 3\ntlfp: qbrz * vtmm\nvwpc: pwsg - lzfd\nchvf: vmhp + pdbl\nvbmg: 11\nlcst: 2\njpdg: fwhh * tdlv\nhrpz: zhtq + rjwv\nrnhr: 4\ntbwd: bjln + ftbp\nqmhg: ptgb - bhfc\nmbqg: 1\njcdn: djqn - hfcl\nmzzl: 2\ntbwj: 2\nwgmh: 3\nqfsr: 3\nlqlp: 2\nslqs: 2\nwzmm: 3\ndlmj: 2\npsrr: 18\nmtns: cvvp / nwrq\ntfsd: 2\nwhml: tdpd / trcg\nbvmd: 4\nrrtr: 2\nbmds: 6\nwrdh: lbhd + rnrz\nfdvb: 4\npmlq: zbjj / hfpr\npbps: 3\nlmvq: 4\nzsrv: rtmt + gdsr\nbdlp: 9\nzqgl: gcsn * fdhl\nljlj: 9\nzshc: 2\nchdw: 6\npngf: 2\nnplz: 4\nfwlr: cggg - stls\nwrqg: jzpn + wqqc\ngrsv: szvt + rwgf\ngtzp: ldjd * tfrq\nngfn: bzqc * tprf\nbgws: fgcf * vlgv\nqnpz: pthm - lpwc\ntpgv: jqcr * tzpw\nmdfl: 5\nrwfc: tdbn + cswv\nrwlb: ntzv * tzdq\nlcmm: cdtl * sgst\nhspt: rllb + rnqw\nbwdz: 4\nmmdc: qvbm * zddm\nzbcw: 4\njgzl: 3\ndpdn: 2\nmjzn: jssm * twtg\ntgcc: 2\nmzmr: lfgv / hsdq\nmwvg: 3\nnfcq: 6\nsnsc: 8\nlsvd: 4\nwwgw: 3\nnwrq: 2\ntmmf: 3\ngffr: 5\ntdpd: hjbt * tfsn\nvfrn: 4\njldj: bmnl * dfjn\njgsn: 2\nqmvl: djfh * nqmh\nmcnj: 5\nrcgh: 4\npccf: 2\nrchv: 4\npvqn: 3\ntrfc: 3\nprsn: 7\nnpwc: gtjc / bjfm\nqtrb: 5\nldcn: 16\nhlqq: nltt * mjnm\ndfmb: 2\nnwrh: 2\nlfcg: mgsz / nddv\njhhj: pqtl + gpcg\nhdvf: 2\ngwjf: zcsf * flnj\nstcd: qpwh * nhzt\nnwcz: 19\nwqrt: smlh * tqwl\ngdsz: 4\nnwfv: bcvc + gcjz\nhzpn: 7\nqbhg: 5\nnzjh: lvqb * fwln\nlqml: 4\nwqmt: 4\nddrl: 2\nbhgc: hmfz + qfsg\nwrtb: mhhm + hfzt\nfrzv: trml * mwpn\nvjrs: 4\nrpsc: jszm + hzpn\nrszd: 5\ndphb: przn + bjwc\nrczm: 1\nbqbl: crnl * plnq\ndddh: lbhh * wlvr\nwjcr: pvdl * rhbs\nvntl: 9\njqcr: jsvp - ffjs\nszdf: 17\nhsfn: 8\nwfdv: 2\nvsqt: 2\nfswf: 2\ncmgl: sswb + zsfg\nnrrs: dnjl * npqh\njllh: 10\nnntm: 1\ntgrf: 2\nzdpw: sdvv + ggnn\ntvrh: djwb * vjvc\nttrc: 15\nrmgn: dpbn * jbcb\nfsjt: mftn + hgtf\nhscb: 9\njgcf: rdcj + tlqm\nsfrm: wdpz + jqvn\nqsgb: gmrp + jlbh\nrbnd: 1\njjjz: 3\nrmvz: 6\ndbcq: 5\nqpdn: qffn + wrsf\nnqjg: djfj * zvjq\nhnhs: 8\ngldq: 3\nroot: jdqw + nrrs\nrfwn: tmhr + sbdb\nrdqs: 3\nrwqw: fcdw + cdjw\ntslc: ghvt + snwb\nffbd: 2\nzlpr: 3\nrsjw: 2\nqmrs: 5\nrwqr: 5\nbhqd: btsh * mnqc\nwlwv: 11\nhvsm: qzgh + qjjt\ncrlj: 2\nqphq: 1\nrhbs: pqfd + mqrv\nhvlg: phvl * ggpb\ndgdr: wmrp * pvch\nvtqd: 2\ndmbw: 3\ndjqn: sntt * bsrp\ntwzs: 2\nnvff: 8\nvwcj: pmlq + ndfj\nsblg: ccrb + jshp\nmslc: 4\njtdd: wwhs * qrvv\ndzvq: 11\nmmlw: 12\ngmlr: dtww * pdpj\npbdh: 11\nwgfc: rssf * zpft\njncn: hchd + hbln\nmwpn: 4\nlmbf: rpcj + mmmf\nsvdd: nzbh * wzts\nddmc: 2\nzzlf: 2\nlbnq: 3\nwzdf: tpbw * nlfv\nzqwp: 5\nvbwq: 3\nwgfr: 7\nbzqc: 5\nwwnj: rzwz * bcvs\nnwdj: vcbn / pgjt\nbvnq: nmpt + gspb\ntjhw: lzwp * wfzs\nnbjt: 7\nhvtp: 2\nnmjj: hrpz / lncq\nzgrj: nnvt * pjdp\nbtbr: 2\ncqfp: 7\nrhds: jhcr * rmrr\nnjtt: 4\npgjt: 2\njzhw: 8\nhbtb: 14\ntflw: hlmj + svww\nnnhf: 3\npjhq: dzvq + sstq\nmpbg: tztr - npff\nwcrj: hhmq / lzqm\ncpvd: 10\nfjjc: qcjg * jwhr\nzlvj: 3\npqhs: 11\ngqwq: zqzr * mfgw\nmmsr: 4\nlzfd: 5\nvjvc: 2\nfzms: nsbz * vtqd\nzhtq: jhhj + qvsc\ntjzp: tdhr + hzpt\nlzlf: 2\ngblg: 16\nqnfb: 4\nvggh: 2\ntrml: vvnh + rnsd\nblqj: 2\nbrbv: 3\nmzbv: ntfw + gbvr\nwppb: wjcr / wgvm\nvrqj: 3\nbjfm: 2\ntpbw: 5\nntfw: 4\ngdsr: qqqp * bvzn\nshvv: 1\nnflt: 11\ncqtz: 2\nvtbg: jhmj * vdtj\ndbqz: jcvd - tppz\npgts: 10\ndjdw: 3\njppl: hfjm * tfdv\nhzhc: srbj * zjdm\nzsrg: vggh * njpf\ndnmj: stcd + jbhb\njtpg: jmrf * nwmh\nrqmw: zmrg + fhpt\ndmnh: cnrj * gsfj\njqnh: gfvd - dphc\ngjsc: mzfw + bclv\nqhpv: lqwt + frjt\npqfd: qwpg * bvgd\nchpr: nmpz / cmrm\nwvtm: 5\nppld: prpz + sjch\ncrhs: zlpr * jsqp\nhvhj: lsvd + tgsp\nhbjc: 7\nmmhg: 7\ngfmb: wnzg * tbwj\nwvlr: mhgb / hrmd\nhlsn: lzzq * bswm\nwvrm: rjhw * szdf\ncsfj: 6\ngqdg: mdrc + sbfh\ngjgw: cjpp + hzcg\nvdwr: 3\npnrd: 7\nhdjt: 11\nqjsz: nlrq * cbrp\ntwcm: tnhm * hbtr\nbswg: 5\nthcj: 3\nmfdb: hhwh + rpql\nsljl: 3\ntfdm: 8\njlnj: 19\nsgdd: 7\nwjzg: ssnq * rbvm\ntvlz: 3\nbvgd: wdrq * vrtr\nhbcq: 1\nnghl: 3\nfrdq: 2\ntbhd: tlwm / pczj\ngsft: rwwc + llmq\nsqrv: 4\ngzmv: tchr + dwsw\nbfnm: 4\nmqqs: bvst * gjdq\nhbns: 9\nbrjc: 7\nwhcv: czbj * zcvz\nqsrh: hcbm * zbmw\nfgcp: 10\nsctg: 5\nftpg: vrwm + nfjp\nqqlr: lzdp + zctw\ndrqv: 3\nzwcs: gvcr + rjwd\ndjcf: 13\nfhzl: 4\nrfwp: 3\ngdnj: 4\nlpwc: wrdh * gdzh\ncgnt: 11\nhlqb: 12\nczhr: gdnl * jtph\nvrtr: 2\nhjrw: 5\nfzgw: tqtg * mdqc\nfqhp: 9\nsmvw: 3\nrnqw: nmmz + pjjv\nvrwm: 1\nbctr: pcvp * jsfb\nszvt: 15\ngblb: szsh * prsn\nzdqz: jjbd * mmsr\nncfz: qzmv + nshb\nzzhl: 4\nszsj: jhpr + tvnp\ndqmj: hggm * cjvq\nvvsm: dtlj * mzcr\nqgdc: 2\njrzs: clwf - tmsh\nfmhr: npvb * ffbt\nllcr: pdfq * fvqt\nqhvb: 3\nnsjg: rznv * dzgp\nzbjp: chgv * lcwp\ndqvf: 1\nbjrl: 3\njwnj: 10\nlsnc: dfsh * blhm\nqtwt: jcqs * npqm\nqzrj: cnpl + qvzf\nrtrc: 7\nsmjj: tldj - fjrw\nfrrv: 5\nqhwt: 4\nqvzf: 1\nzmnz: 2\npdbf: 19\nprgp: 14\ndlfn: 5\nbqbb: mglh * tmrv\nsbjp: 11\nlbbb: lsmc + jssw\nlvnq: 7\ncgnd: 2\njhjh: tpwm * zsdf\nchwl: sscm + ltng\npnjv: bffv * gbnd\nljcm: 4\nmbtc: 3\nslcg: 19\nthnb: 7\npzmr: szwd * vcgm\nwlpf: bgsz * lphm\nddtt: 5\nlgpq: qrrv + psfs\ncsbn: 4\nfccn: pvsc + mjgz\nnwvt: 5\nmzrj: prml + bvlv\nbffv: ztjg + twmw\ngphq: fswf * wzws\nrhcs: 17\ncrdq: 3\njbwl: 13\nwtjz: 1\ngnpd: 3\nrbrw: zwbm + dqpr\nlmlf: 3\nprml: pwld * dnhs\nppwg: 5\nhbln: rhvj * lbnq\ntmfb: pgpg * bdjw\nzhvc: 5\nfzpn: gflm * mvsd\nwqqc: qsgv + smpc\nsbvg: ztql - drlj\nzqfs: 3\nfmpg: 4\njsms: 3\ndpmq: 3\ncvgp: lqml + ngfn\nwnql: mtpt * nwvt\njcdw: hcmr + bngv\nbpfj: tdvg - drhv\ndwsw: hczs * rdnw\nrjwv: 5\nzmlm: 4\ngnqp: 3\nfvqt: bltq - cvbz\ntbwn: 5\ngrws: 8\nzptv: 2\ngrnh: vcfh * lhjp\nsqpd: dhdh + jhjh\nvbvf: vnhj * mbgw\ncjpp: rgtd * wpln\ncgjm: fsjt + tlbn\nwvwn: 5\nstbv: 12\nshpg: bdww + cmpp\nqrrv: bccv / jczp\nllmq: jsqn * bfnm\nmzwg: vrqb + wdnm\nrjld: qsrh + qvph\nfbbh: gmlr + ntfg\njgpd: 2\npljj: rwlb / swqf\nwtcb: 3\nwnvb: 3\nsrbj: 4\ntsvp: 5\nztsp: lhfq + mqlc\nntrd: 4\nsdqd: dctv * zmnz\nvmwv: 2\nbdfj: 1\ngbqz: nrrh + vjss\nqmdq: 1\ngsfj: lljn * sjvt\nvqdb: zztm + tbwn\nrrsb: 2\nhzrt: zzrg + wvmm\nnwdn: ptsl + scwd\ngvjm: shvv + hhzp\nsqjj: 2\nvtmm: 2\nmrfv: 2\nqwfc: 4\nsnbt: 4\nmdqc: nwrh * mlcw\nmcbj: 2\nhfbb: mdlr + djdw\ntszl: 3\nvljf: pdcc * ztbg\nvcvh: 2\nfsbd: 1\npqmw: 4\nzqqs: 4\ngmbg: zngh / vfrn\npjpp: 3\njhjf: bntt * jwph\nbfgr: 20\nhpwf: 3\ngchw: 6\nnrsw: 4\nzplw: bswg * sgdd\nzdbl: 1\nnnnz: 2\njqff: 3\nqvvn: 2\ngndt: wdwr * bmsc\ndzzc: jnbr * vvmd\nwbrr: 3\npgnd: 3\njddn: ldcj / hfbv\nzgvc: 17\ndnlc: 10\nrftp: 13\nnwcr: ndhv + gdfr\nfgqw: zswn * jrzc\ngvmd: jcsq / ndrd\ncwwf: jfpv * csgw\nflgh: wgdz * wvtc\nmgzc: 20\nfhbv: pvpm * pfrc\ntqtg: znvj * nvbg\nqvph: pjhq * nsbq\nppvm: 17\nznzl: 3\nhfzt: 11\nsdjd: 5\nwcbp: tvdc + fngh\nzzwg: 13\nwmrp: tmpv + fqjw\nbfrh: hlht * zrcm\nhczs: lswd * gchc\nfssq: 2\nqsfj: 9\nmstr: grmr + gnwc\nbgrd: 19\nfhqr: 16\ncmwh: vvlm * wjtp\ncbpw: 3\nwdbm: gwcc * qsrf\nzbmw: csfj * rhzn\nsdmp: 10\njvpg: dsrn + dpgj\nszwz: 3\njszm: fmhr + sblg\ntssr: mhhf + dgww\ncdhb: 2\nhcpl: rchv * vszn\nplgc: 3\ntwsc: 3\nmzpw: cbgb + csqb\nplnq: 5\nfghg: lrjz * bcnh\nnwqb: czhr + tqrg\ncnfh: 3\nmftn: zdmp + sbll\nlggm: qstn * whdr\ngfsh: 17\nhzcg: jgzl * cprz\nldcc: 2\nvbbl: nnmr + qgmp\nlfdb: rsjw * ffzf\nqgbl: 3\nlndq: gwjf * fbtd\nmssp: cgjm * mzgg\nfqrh: zrbl - dddh\nrdzb: ntcs / wrnp\nmjmv: rzvt + bfrv\ntjcr: gdsq + gqvp\nwzfn: bpqv * zngc\ncbgc: pngf * dlqt\nwnct: 5\nhdpt: 2\nfssv: 2\njdgm: 6\nghvt: 5\njnjq: 5\ngdcj: 3\njbhb: psww * hdjt\npftj: vrqj * lrjv\nptff: mtns * znpv\nprjp: 7\nlsmc: 18\nfgcf: llpb * rcpw\nnzbh: fsdw * pzlb\nzbjj: mjqq + hvfr\njrld: 5\nqvsc: jcfj + vbwq\nbhwv: 7\nfhql: rghb * smvw\nwfwm: 9\nwvcs: qzdf / ctcp\nfwtg: 2\njjbm: 4\ncwdv: 6\ngnwc: glqg * qmjb\nnjbp: 3\npcbt: mlhs * pndw\nqghq: 19\nfcdf: mpfd * sdjd\ndbpp: qsgb * bfwn\nfplw: hphz + lhpt\nlmzd: 4\nhctp: mbbj + sdcr\ndlzm: 4\nqsfb: zgvc + llzw\nwrfn: 3\nnptq: 4\nndhv: 16\nfzwr: jtdd / cqtz\ncvld: 3\njcfj: fmnv * nhtd\ntlnz: cvdp * shcz\nrcrv: gcjd * fmds\nmglh: 4\nnzhv: 2\nzrvn: prvz * wvwh\nldjd: 2\nbwdg: 2\nqccb: 3\nfbtd: 2\nsjrj: hcsn - vbbl\nthth: lpfg * tttq\nrvqw: 5\nzrvq: 10\nzqsq: cvfz * dngr\nlcwp: 3\ndfsh: 3\npgnh: 5\ncsgs: 4\ncwht: wwvv + mqnf\nldnh: svfq + nmjh\ndczh: 2\nbmdc: 8\nbfnc: cwvm + jtwm\nbngv: 12\nbgrl: vfmb + jrnr\nhdnn: 2\ngcsn: 7\nttsh: 1\npbzw: 4\nqzgh: gfzs * dbzh\nbhlr: 2\npctv: 12\njlpb: rnlj * djcf\ngwrb: tbrw * wbqs\ntmcp: tjmg - zgqm\nqrwj: tzcn * cwff\ntqdc: 3\nvhns: qgbp - hvqz\npfph: 3\npvqq: 6\nswng: 2\ncdvg: 2\nctgg: 3\nrvfr: 3\nvscz: 1\ntfpc: 1\njpdt: dmcb * mfjv\nfgcz: 13\nhcbm: wzjb * pfsv\nmjrf: sjrj + chsw\nfbvd: twzm + sqrv\nhhzp: zbhz * vdwr\nqdhs: pgph / pcmd\nchbn: tpgv / hzhr\nnnqd: grnh + ttff\nqhvt: 2\ngrgs: jqdw * dftz\nzhlb: 3\nfbbj: jnqr + rcqf\nbtsh: 2\nsmvj: hdpt * qdcn\ndfrl: hmwf + mmlh\nwjtd: zwhd * lhcg\nsdvv: zgtr / qgdc\nfppn: 2\nszlw: 2\nlrsm: 18\ncwnw: sdwr + qdhs\nmdqs: 2\nbvpf: 14\njshj: 2\nzthq: hwbw * lqht\nlqjf: 5\nlqwt: gqgj * vbdd\nnfzd: 2\nqcst: tdcc + mqrc\nqlrf: 3\nlzvn: 5\ngqqr: brlz * hbjc\nvhbl: qfsr * cfch\njppq: 2\nhtww: 3\nvbsv: 16\nbcvs: jsqt + cpjn\ngvht: czqn * nrdv\nmqbf: gqqr + zpsb\nqlbs: 5\nsbfh: qpwv - zjps\nwdnv: 5\nwvwh: 4\ncscc: 5\nhglp: 2\nntzv: 14\nvtzc: npnv * dvww\nchgv: 3\ntwrb: 7\nplgj: 8\npzlb: fgcz + flwb\nmlrb: ldgh + vhrc\nhcnv: mmcp * glmd\nhggm: dgsn + gsqp\nrwwf: dphh * hlqq\njlvt: 2\nmfdn: rcdh + qznj\nhrvv: vfzt / zlfm\nczqn: 5\npvpm: hvtp * mnqf\nbntt: 4\nftqp: 6\nmqbd: mhgd * tgvg\nvrjq: 5\nzwhd: 3\nfbrs: 3\nszgs: hpbc + zcpc\ntrzt: 5\ndqpr: jcdn * zrqw\nczqs: wgmh * wjbf\nqsjc: vbth * djlm\ngbrr: 11\ntppz: 6\ngzww: wnql * zszf\nbbjq: 3\nqrgw: wfbz * gqpp\ndbqw: 5\ndttn: 4\nqlst: vljf * jqvz\nwvml: 6\nbdvv: 5\nfrlb: 5\nptgb: hspt * qccb\nqwvl: wvfr + fwlb\nbbnq: 5\nmqst: 13\ntbdp: lscw + zchq\nvbdd: hqnr + sdpr\nqqwg: ldcn + jpzq\nmbbj: rshj * llvf\nqgnj: 3\nmdcb: mpqs * gdqd\nctth: 3\nzvdj: qcsg - fgcp\ntzdq: gljs * sqff\nvftv: 3\nljtw: dmbg + hzhf\ndbth: tszl * vpdv\ntblp: 3\njnqr: nfcq + nrdc\nhzsg: hscb + jhjf\nnjbt: fths * lqlp\nclpj: 2\nnlzv: 13\nnqsh: ljpc * zhjf\nvpjz: 7\ndrlj: 4\ndjpg: gwfq / djtd\ndslr: rrsb * wtcb\nvlqj: 5\nmsht: 5\ngwjm: hrvv * pblw\nmcsm: fdmh * lnsn\nwwzp: 2\nvdbq: 7\ngtfz: 2\nmchl: prjp * phdl\ntgvf: 1\npplm: wphd * njbp\njzps: nwqn * bdvw\nfvqm: htqw * lzqv\njvtr: 6\nsrmg: mwgw + gqdg\nvlgv: fbls + rfbj\nzrbl: bgsw * dllv\npjsw: jjwr * bjnp\ntwpb: dpsp * jpbs\nftnw: 2\nnsvp: jpdg + dzzc\nnszr: 19\ngffg: mdfl + sjcj\ntncl: fppn + pgnh\nwglt: 12\npfqq: zsrv + rlzn\nhjsw: 18\nwcbw: gnsg / jsfs\nvdgf: vrjr + lnrd\nwvfw: pwdp - mbqg\nlvtd: crpp * snbt\nqmwm: 4\nmhtm: hqjz * qrwj\nffjs: 1\ncmhd: 3\nwgpl: 4\nnpnv: 5\nbgsw: 18\njssm: 2\nmzpv: 7\npvzz: 2\npcms: 4\nmbrr: mwwf * bwhb\ngmnw: jgsn * qnfb\nwzjb: 2\nqffn: rcrv / jqfq\nnvmp: 5\nbdds: hqmn + vhjv\nnctq: 7\nlswd: 2\nqrcf: gqtt * mhnb\nrlhc: rnhr * jtpg\nrnlj: 3\npnhw: 4\nfswg: 19\nffdb: mnjr * fnpv\nmhnb: zvjg * mljz\ntsmb: 3\ngczs: wdlg - zqjs\nqzcq: 2\ncvbz: phjq + pbzw\nllzj: zmqb + wvsc\nqdgc: gczs * qwqw\nvjph: 11\nmchq: 5\nstpv: 17\nmqzg: fhhh + sdqd\njcvd: qqlq + pwmf\nsrtj: 13\nfvhj: 19\npbfd: 5\nqgbp: przd / wdqq\ngbvr: 9\nqnnl: hnhp / wzmm\ngqvv: tpbt * jnhg\ntmsh: gbgw + hphq\nnbft: cghj + zrvn\nbmmc: lrvl * ssph\nhmfz: wdll + rdsl\nprsr: 11\nfhqm: 20\ndnzn: fvjt * grrb\nzcvz: 2\nqcjd: cwpc + lmvq\nszsh: 5\nstsc: ndzf / ncgq\nhlcm: hnmm * bwcw\nbhdt: hvsm * fbpq\nrmfd: 2\nssvr: 3\nfshs: bncl + bhjr\nhhnt: 5\ntttq: 2\njsfs: 5\nnpbq: 3\nmqsc: qjlm + qmvl\nfvpc: 2\nmfzn: cfzt * qhwt\npvgh: 7\ndqpj: 6\nnttm: 2\nfrjf: 2\nhmcv: 12\nblmj: hmls * gblc\nrznv: 2\ndphh: mqqh * zzwg\nwwhs: 2\njcwp: 4\ndbzz: 6\nfcbn: cntc / vshb\nhcmh: hzzp * zgdm\nsvmn: 3\ndrsb: qcfr * hnlt\nqspl: 2\nncdw: 2\ntfcr: 2\nqzqz: 3\nshcz: 10\njcqs: 7\nbnzz: zqgl + snsc\nzgdm: 3\ntsjb: 3\ndrhv: wtnb + hpfr\nwdjq: 10\nnnnd: nntm + qpqs\nqjlm: chzd - czwl\nwwvv: hnbl / vbwd\njfqj: qvgc * zwnj\nzrqw: 2\ntsdg: hhdm + bpgc\nlzqv: nltz + qlst\nhcsn: bfbz * jvpg\ngqvp: gbrr + wgfc\nnzvf: prhh + czhh\nndzz: wrrn + ptcg\nggpb: 2\ndjbg: jdvb - vscz\nhbnm: 5\nrrdq: rfcz * hbmp\njdwq: 5\nsppm: 3\nbrlz: jcdw + mcnj\nhmrb: snng + mcnt\nncnp: 2\nznnj: ptbt + bzfj\njpbs: qlrw + njbt\nmrrb: nhfm * vdpq\njhpf: 4\nfgbg: dfmb + hvjj\nzjps: 12\nfhlm: 3\nvndh: 3\nmvbv: 3\nmcvf: nwdj - jwwr\nlgst: vrvr + lsth\nvzft: mdlm + tmmf\nvjvn: mrbb - vhdh\nmfjv: zlbp - qnqp\npcpr: 2\npdmm: 5\nqlfn: frlb * wstm\nggll: 9\nthqs: bjgh - nwfv\nfqmr: 7\nblbw: tqft * mhfc\njdbd: 9\npcvp: 5\nprpz: dpdn + gblb\nrnrz: 4\nphjq: 4\ndhsh: 2\nljjb: 5\nlnrd: nwcr * wzgl\nbjbd: 3\nlllf: 12\njpzq: 13\nsbll: 4\nhzhr: 3\ncqwn: dmbl + rvnc\nvbth: 3\nhwln: llcr + pphc\ngmbw: gslc + jhgf\nqvqq: 2\nbgsq: cpvn * nbjt\ntrbp: drlm + csgs\ncmrm: 5\nfjrw: bzqz * lpjt\npcgj: pctv - zhfd\ncmfn: ctmg * wnvb\nhbmr: 20\ntpbt: 7\nlvdf: stbv + tptq\nbtgt: ggnb * lwpm\nfglt: jnzm * pcgj\nslhm: 2\nwzjj: jppl - wcrj\npwdz: gndt / jsrs\nntcs: nhfg * jtbj\nqfsg: sqjj * rfwn\ndfld: 3\nlbhh: 17\nlhml: 18\nlnwm: hcfq * qlbt\nfnvn: npwc * fssv\nnrdv: qrhf + ffvh\npvlz: tnvn * vgbd\nnpct: hqbr * ftvs\nmhmt: 2\nbvzn: szwz * dmbw\nbsrp: gjsc * trbp\njpvw: 5\npqcp: 5\nscwd: vzgl + nflt\nnpqh: mmqs * pwdf\nwmbh: hfbb + ljcm\nwzwp: 2\nbdvw: 5\nqcjg: 3\ngqtt: 6\nnncr: 11\ndjzn: hbnm + hpdd\nqcsg: crhs + mqqt\nrbzj: jnbd + cjzt\nrzzf: 2\nrfdf: 15\nqnqp: pscr * vfbb\ndjgb: 11\ncpfb: jpzn * dslt\nhhmq: pbdh * qbgz\nhfnn: 9\nbsvd: lbzl * wqmt\nqgrd: 13\nlttd: dtdq * pzfd\nbffq: jczr * pfph\nsmqr: 2\nvrqb: hqbt * rdpp\nnpmd: vvwr * smqr\nmnrs: 2\nnqhd: wjpt * vgqr\nggzt: fswg * fqrj\nmdrc: 18\nstcj: nfgw * zbbs\nzhqf: 7\nlncq: 3\ndsrn: prcs * jqjm\njhgf: 13\nqlbt: dnsg / gtfz\nmnrh: npzq * hqhv\ncmpp: ggjg + dzdr\nnmzl: rdmt + zhqv\nhumn: 1342\nlpjt: gdcj * vfrz\nwffm: 2\npztq: 3\nrfmb: nnqd + chwl\npvsc: dpwl * ppwp\npspv: nfzh - lhpg\ngflm: 7\nmvvt: ntnd * sljl\ncggg: jpvw * tgtn\ngmrp: bhgc * ffdb\npwld: zftc - qphq\nvrlf: 2\nwclb: tbwd * ccds\njzpn: 8\nzfpr: 4\ngcln: znrf + tbpn\nwrrn: 7\nwgqp: nttm * cljq\nhrgg: 2\nlctb: tgsc + zwrr\nllhf: 3\nzfrm: bgws - fmjc\ndtcf: 3\nwdrq: hcts + mzrj\nhlht: 7\njcpj: 4\ntbmd: gnfz * rfrm\nmffn: 9\ntgsc: 2\nhzzp: 2\ntltn: 3\nbvtd: msnd + srsl\ngvpn: ldnh + slmh\nrfcv: spbn + qmhg\nlgln: nzhv * zzhl\nsmlh: 3\ncszj: 5\njssw: 5\nscbt: sfrm * zrpj\npqrq: 2\npvdl: 2\ndpcf: grsv * mbnh\nlfrm: 13\nrdcj: mqcr * bhqd\nzswn: 6\nhdpr: wrfn * vrgz\nbqqd: 2\nqrgh: 4\nssng: 12\nrpln: 4\nlvcn: 3\nvqmc: 9\ntchh: cttg * hlqd\nmhmw: 7\nbmjc: vlzm - hzgc\nhcmr: 18\njtpw: rtvg * zmcn\nldcj: psmc + ggrf\nqqnl: 3\nfsqc: fzms + hbns\ngdqr: mjmv * jgfp\nwgvm: 2\nnhpc: 5\nwlvr: vcvh + ltsr\nhfmd: 1\ncfzt: qlhv + fsgb\nnrnq: 4\nczwl: rrtr * gzfn\nspnp: 13\nqzmv: fsqc * rnpf\nqlrw: jwql * gmnw\npggp: 4\nvvlm: vftv * hfnn\nhvtr: brzp * qrcf\nwrrz: 3\ndccf: 3\nsscm: vhqf * gnzn\nsntt: bgqf * flhn\ndtdq: btls + vftj\ntnqp: 2\nrcpw: 4\nfjrd: lvnq * lpqd\ndvlb: svpw * qhvb\nhpdn: 16\nglqg: 8\nqwjc: 1\nwzhp: 18\nrghb: wwms - clhb\nprdc: sjwq * vmwv\ngsmv: 9\nhqbr: 9\nssph: 2\nstfs: 3\ndmmh: 3\nfsqb: 2\nttzn: 11\nlgpm: 2\ntvrj: 2\nsrnv: 3\nnsbz: 5\nzvnj: svmn + njrg\nmmqs: sbjz + wjnt\nmrgb: qgbl * cnrp\nndgq: fjjc + bgrd\nhfpr: 2\ntbrw: 2\nwzts: 8\nzvsp: jfnr * zvhr\nfths: srvg / vqwv\nhzhf: cppj + fzgw\nhsdq: 2\nwhtb: wjwz - rqzq\ndctv: 5\npfzs: fdhc - bscd\nmtzs: czgl * fwsl\nnrpj: cmpz * tflj\nhphq: wjgw * wrrz\ncbvd: zlbd / vcst\nlltc: hnvb * lthz\nmdrn: 5\njrrq: qqlr * tqdc\nmzgg: 3\nbghc: hznq + hqdc\nzvjq: 3\ntlgz: 6\nftbp: wjjp * stcj\ntfrq: bqbl + gwjm\nwgdz: psvd * gqcv\njrcr: 2\nwwms: rqmw / dbqq\nwfqh: 3\nqgfq: 11\ntwzm: mchl + bwgh\ncgnv: dvcq + hgvw\nrgqh: 20\ngbzb: 2\ncwzv: 18\nvpcs: 2\nfvwq: 3\nbdsd: clls * cszj\npsdm: 9\nhpdz: tzwm * mdwn\nlrjv: 2\njrnr: hwll + hrnj\nvddh: 2\nhgcd: bbjq * mqbf\nglps: 3\nmbgw: lzlf * tndn\nnlfv: 13\nnjpf: vrjq * rgjt\nrfrm: 2\nlsdf: qrhv * ldcc\nljng: lqqq * jccn\ntdqc: 3\nnrcs: hrbq * gcln\nhclm: scbt + grgf\nrnsd: 1\nqqht: frpq * bpnz\ndtww: 7\nnhzt: 2\nttff: vfmv * nwzj\ngspb: 6\nzpft: 2\nldgd: fhlm * tmhf\nwsfs: wbwf * wzql\nvmjl: zbmp + nrsw\nbpqv: dtcf * rdqg\nqgmp: njbl - cmwh\nzhqv: 2\ntcqs: zhpr * tdnb\nbtjv: 7\nzcbw: rfmq * rcgh\nqmjb: 3\nmpch: 5\nlwpm: 13\nnhtd: 2\nrhzn: 2\nprwg: 13\ncmjw: 3\nwvsj: 7\nmhgb: prms - nrjf\nwnzg: tnrd + pdvp\ngsqp: 3\nhgtf: 10\nfhbb: gzww / zdsd\njccn: 2\nblhm: 3\nwsst: rlrv + fppg\nszgd: zvbh / vbqp\njclw: 12\nzztb: qgrd + hpdn\ntmhj: zplw + mmdc\nsqff: 2\ndjwb: wtjz + lltc\nvplb: tbmd + tqql\nlfgv: cpzl * cvgp\nvrjr: mbtj * rfcv\nbjwc: 4\nsstq: 2\nbdjw: tfwm * zqdb\nrhnf: hlsn + zgjb\nffbt: 2\nvbbn: zqtd * jfqj\nvfmb: pmdd + cnlm\nplms: 2\ndllv: fzrq * hmfr\nszvz: dgfj * frdq\nwjhj: tznf + hvsg\ndnnp: dnvd * fbns\nmmlh: 15\nzqzr: 7\npjpg: 2\ncsdt: nrnq + blmj\nvwdg: 5\npzfd: 4\npblw: 3\nzcfq: jbwl * pvqn\nthjn: 5\nzrmr: 3\nbrvb: 8\nqqch: 2\nzwdr: 3\nrphp: sctg + cgml\nwstm: 5\nvmhp: vhns * zqqs\nsgst: 4\nvvnh: 6\njsqp: 8\nztbg: 3\nrqzq: fbhm * psdb\nnqwl: jzps + wrlp\nfbls: 1\nrlzn: qhjq * bnzz\nccrb: sgcv + pcbt\npdbl: dtnc * jhdf\nlbht: 4\npdhl: 5\njvzn: 4\njtjj: 2\nwdpz: 5\nlhpg: 2\nfcsr: mvvt + fccn\ntgsp: 3\npqdz: 2\nrmjw: 2\njcwh: 2\nqppr: 3\ntzwm: 18\nmqhl: 5\nqwns: 1\ntztr: rpln * cmsd\nmsvl: 4\nsjwp: qwjc + vnvw\nvjzr: jwnj + bdlp\ngsdr: 5\nzhmd: qdgc + mlrb\nvnrr: 9\ntgwh: 3\nslmn: 12\ngvfg: 7\nfbhm: wdqw + hpdl\nrshj: pdhl + qpth\ndfjn: bpfl + ztqf\nnltz: 13\nzwcz: rdqs * gzhz\nvmqt: 4\ngnzn: 4\nhqnr: ntqn * wvlr\nwdvh: 2\nbrbh: 2\nggnb: bfrh + ccdl\ngbnd: 19\nprms: hcpl / hqlq\nwhdr: wwnj * mcmn\nwzfd: 2\nsvfq: wjfj * wffm\nzgvg: blgc - psfm\nzntm: 2\nzgtr: vtch + wppb\nhbvd: 14\njczr: llzl / mmcc\nvstr: 2\nljhq: zvsp - gfcd\nhqbt: znrp + whth\nsjcb: pfzs / rwqr\nprbs: sjfb / dnbq\ntsfz: 2\nsjqr: vdcd * cncc\nzzrg: 12\ngfvd: dnlc * gljf\nqmzp: fhqr / hrgg\nhchn: 10\nnvjn: 3\ntwqw: 4\nrdrs: 2\ndgww: 9\nbfrv: qshd * djbg\nzvfc: 3\nmtpt: 5\nzqcn: 11\ncwff: mffn + dqbq\nhhds: 7\nqbbv: chbn - zntm\ntvnp: zgtv + qnpz\nvdcv: 2\nqgzb: 4\nhtcn: gnpd + ntqj\nfglh: 2\nwjlh: 7\nczhh: qvqt * bvqs\njwcv: whhd * nhgb\nmcnt: rvrp * qhvt\nmchz: bsgd + cwwf\nmcmn: 2\nwjjp: tjcr + gvmd\nwnms: zdqz / lplv\ndcqm: 3\nhqch: jlvt * wzfs\ncvvp: dccw * shpg\nqhnd: 8\nztnq: 2\nlhcg: qtwt / sjdl\nhpmd: sbvg - vlqj\ngddh: tnqp + whpr\njcsw: ncdw + lllf\nvdcd: qzgr * mdgl\nbjcn: 3\nrvnc: 1\npwmf: zwdr * rmvz\nllzw: zshc * nvjn\ndftz: qmdq + dbqz\njnhg: 3\ncppj: pvzz * rpbl\nfhrb: 6\nbfwn: 3\ngqzz: mtmh + vbmg\ncjzt: 5\ntfdv: 2\npnvf: 11\nqsjh: nnnz * vntl\nsvln: 3\nwznw: 5\nsvww: 9\nwfzs: 2\nvnhj: 20\nzbhz: 2\nzrcm: 3\nqwjp: 3\nzwrr: dwzz + nnnd\nwbqs: blbw + jrld\nwfbz: jshj + dnzn\ntsvz: 2\nqmdr: 2\nnscs: 3\nznvj: jgcf + rfmb\nqbjg: 6\nrfcp: vgsf + npmd\nczbj: 8\nqzdf: 14\nqjft: rdzb * zhlb\nhphz: svln * bgsq\npbmt: rbtt / nfzd\npfrc: 20\nzwnj: 3\nwnfd: qqdw * zcfq\npwdp: 14\njdmc: 2\njdqw: rbrw / vmqt\nbmmg: nbmh + ftqp\njcnn: 8\nzncf: 13\njqfq: 3\npsmc: nctq * fhqm\ndmhg: qmzp + swjc\npjbz: dbpp * jvpl\ncgml: vhgh * gbrj\nzqtd: 3\nmvdw: swcn * qgnj\njfrp: 2\nqsrf: zrlm * nwqb\nqhjq: 17\njzth: 4\njcjs: 3\nsjgn: bbnq + pcch\njpqz: 2\nnztn: 4\nbpns: msht + jclw\nzdmp: 3\nhqmb: dlcz * glpn\nlfjq: lgpq * bwdz\nfwlb: 2\nprzd: gdqr + fhql\nvbht: rphp * jtjj\nphmr: mrwj / nqcw\ncqmw: phmr * rzmd\nsmnp: 2\nffvh: tdqc * bzpt\nmnqf: jnct + hnct\nsdwr: zclc + nqsh\ncfrf: mlhf / sgcb\ntptq: cdbf - hhbj\nbszn: lhml + tfpc\nmzsc: njtt * mcqn\ncrzd: 3\nnsbq: zfbr + qbnw\nwlbm: 6\ncswj: rczm + tlgz\nzbzr: 2\ntqft: 2\ngpcg: 2\nsrvg: zprc * djgb\nssqc: 3\nrwqb: 2\nrdqg: 9\nqpwv: pwtz + pmgn\nbscd: tsjz * qmvc\nmqcr: 2\nmgws: hprc + nrdn\ngdfr: wrcr + jvpm\ntmzd: 3\nfzrq: fbpw - llhf\ntbpn: zppc + dqpj\nrnqh: lszf + pfbd\nhtqn: 9\ncncz: qpdn / tnmv\ntgtn: 2\nzrtv: lfcg - grgs\ngsgf: 6\ndwnf: snjr + tzft\npsfm: ttcq * lttd\nztqf: jrcr * vmjl\nzhbn: 17\nfwsv: 4\nbpnz: 19\nrtmt: bgrl + jfbb\njnrz: fvhj * ptjj\nzvhr: pvpg - dmvm\nvhth: 1\ngblc: 2\ntcrr: 3\nnbmz: ttsh + frzv\ntdbn: brqn * mhzj\nbrzp: lrsm * jjbm\nttcq: 5\nhccv: bpfj / vdcv\njmrf: 13\npjlg: cfrf + bfwr\nznrp: 1\nbnmr: rwqb * qmcg\nzjzs: lqgr * cbvd\nwjbf: 9\nfvbq: 2\nqqqp: 6\nbgqf: hzwg + ztdt\nclhb: ddzr * mssp\nhlmj: nrzv * nsfh\nllvf: 3\nmtmh: wzsh + cffs\nztjg: 4\ndwqw: 15\nttbb: mtzs * qbjg\ntmjv: tltn * vjvn\nwrsf: humn - pjsw\npqtl: jjjz * pnrd\nsmpc: 5\ncbws: hbmr + qdrm\nqjtc: 4\nggjg: 4\nhhnb: fvpc * tsvp\npgzn: bghc / mchq\nhmfr: 3\nmsnd: 5\nhnmm: ghqg * cmhd\nbvwp: mfdj * mwvg\ntmgq: 3\nnfjp: hfvw / gdnj\nnsjn: nwcz * hvwp\nbsgd: jvmf * zltj\ngfcd: 8\nmbwc: mvbv * ndgq\nnpgd: hhnt + smnp\ntbhv: 11\nzdsd: 2\nmhch: 3\nnwqh: 16\ngzhz: 3\nfrsn: 5\nzhpr: stpv * mqvq\npnvs: 16\nwfjf: 2\npfsv: 19\nzhjf: 4\nhtzn: vhbl + tgvf\nzbbs: 3\ncpzl: pbrd * mgws\njrfb: vvgt + qzqz\nfsgb: fbrh * vjph\njlff: bhwv * tfsd\nwhhd: trfc + zjdz\nlqht: pjbz + qvql\nwphd: gbtz + zclt\nlfgc: sgns + bqvr\nbvst: bhfl * qqnl\ncflt: lgpm * mhch\nqhlm: 4\njhmj: 5\nwhpr: dccf + brjv\nfjlv: jpqz * mfrr\nmpjs: ltcn * vjmr\njfnr: rvqw + clpj\ndndb: mjzn + jhgp\ncljq: qmrs + gnpz\nvlzm: jgfl * wsst\nvgsf: 5\nrwgf: fwtg * zwcs\ntrmz: 4\nbwgh: mrst + hjdh\nvszn: fjlv * sjgh\npwsg: qlcr / jcjs\nclwf: pftj * cwht\nlrvl: ssbm * flwl\nglpn: 2\ngqlq: 10\nzprc: 2\nqdtr: 10\njgfl: 4\ngdnl: 12\nssbm: 5\ncdjw: vbbn + vntq\nbtls: zwcz * wznw\nmzcr: 3\nmrcm: 3\nphps: bnnw + fsbd\nnsfh: 2\nqwpg: 5\nbclh: 6\ndmbg: qqch * mfdn\njcjp: 2\nfqrj: 17\nvvmd: 4\nfrgg: pnjv + pvlz\nnhfg: 2\nlqqq: hdvf * wcps\nmltz: bmmc + tbmr\ntgts: mcvf / rdrs\nlvqb: jphc * rvlm\nrzmd: jjfq + lzwz\njnqw: sfvg + jqbn\ntldj: jcbp + fcns\nfbtw: tjzp + bszn\nnpzq: 4\nrljl: hpwf * gmhr\nfbpq: mqsc / fwsv\nmvsd: 7\nhqdc: vwcj * rpcb\nzbnw: nvff + mzpw\nvcbn: szsj + pdhv\nhqhv: qmwm * cqfp\nmhzj: 3\nrbtt: dprf * twzs\nwmmt: 3\ntsjz: qcjd + dvrd\nrdnw: wvcp + btgt\nzmwp: 3\nhnlt: tbhd + drzh\nffcz: dnmj + wcbp\nvdtj: 4\ncdbf: qcct + fcdf\nnqvl: jfhf / dnpj\ngchc: zfrm + hvtr\nmdwn: qrgw + srmg\nzljs: bmnn / jdmc\nqdzq: mbwc + cqmv\nchsp: lbbb * wmbh\nzctw: vplb / zlvj\nsnng: 1\ngcjz: 4\ngljs: 4\ndssz: qcwr * rszd\ntzsp: zqcn + bmcp\npdfq: 8\ngmld: 3\ntdlv: vvsm + qwfc\nbzcn: tsdg * qvvn\ntnvn: sbfb + nlwj\nsqcc: hfmg / cdhb\nrpbl: vwnc * jddn\nqrhv: nvmp + ldgd\nbjnp: pbmt * gflq\nzrlm: 2\nnvmr: 5\nbvvc: 13\nwqch: mmhg * rppz\nzrwh: 2\nrfcz: 20\nmlhs: 2\nffcn: 15\ndtdj: csdt + jnld\nlsrv: zhqf * btjv\nqqbd: jnrz * hgcd\nrpql: qjsz * lvpl\nswtj: tmhj + gmbw\nsnjr: 3\nptjc: mnrl / zcbw\nnqvv: ffcz / wrqd\ntfml: tfpm * cgtg\ngrgf: 5\nnpvb: 3\ntqnb: 2\nqqdj: 3\ncpjn: 2\nfgdw: 19\ndpwl: 2\ncvvb: 4\nvvqq: bfnc / mhmt\nzmcn: 11\nchzs: 6\nntlg: twbf * vzhj\nhqnz: lrnh * sqcc\ndccw: 2\nfhpt: mrgb + ggvc\npmdd: lwdc + pvgh\nljpc: crdq * fqmr\nztdt: rmgn + zthq\nhqjz: 2\njnzm: ljqw * dmhg\nhcdv: 4\nbzpt: 13\nfmjc: llbw * hnfz\nnnmr: gfmb * qwjl\ntwtg: 3\nlpzn: pwpp + smbr\nglmd: 4\nnsrr: bvnq * vwvc\ndlrc: wwgw + ftpg\nvzhl: 5\ncbgb: 10\njgfp: gmbg - fbnq\nhvwp: 2\ncbrp: wfqh * tslc\nnqbp: 3\njfbb: fghg - tssr\ntjbl: dgdr + gqhq\nhfcl: hmbc * tmcp\nvntq: gqwq * qdtr\nlnsn: qgzb + npgd\ndvcq: 5\ncmmj: 3\nznrf: tlsr * pnvs\nhrnj: 1\nstcw: 5\ncrnl: 16\nwdwp: vhth + tgch\nfqgg: pzgm * jcjp\nzqjs: 4\nchmf: 3\ngslc: 5\njsqt: 15\njsqw: mltz - zlsb\ndfnh: 5\nhjds: 3\npdhv: whtb * dbgg\nsdpr: 2\nnsqn: pcpr * qjjz\nbblr: crjp * tfdm\nvztj: tsjb * rght\nlncv: rhnf * sflq\ngmhr: 7\nhwbw: 5\nrlds: jdgm + lzvn\nzgjb: dlzq * lvcn\ngfzs: cpfw * zqfs\ndzbd: 2\nhjdh: jrrn * rprh\nflwb: rfwp * hcsr\nnrjd: tbdp * hzsg\nwjwz: gjgw / zdnr\nblgc: tlfp * jrfb\nhbmp: rbzj * jvzn\nvzgl: sbwb + twjf\njhgp: 1\ncnpl: 16\nnlrq: 3\njvmf: 5\njhpr: drqv * vdps\nsqnb: trzt + gdsz\nzbmp: prmp - sqsc\nsjvt: rhds + nwdn\nflhn: 2\ntqsm: 3\nzqdb: 5\ncfch: 11\nvmhr: 10\ngbqp: 2\nwttp: 2\nhmls: mpbg - fhzl\nlvpl: wvdg - pzwn\ntzft: 6\nqrdc: 1\nnrjf: 4\nphdl: 4\ncrjp: 3\nmjnm: 3\ncthg: rfmr * bwll\nzzzb: 1\nhvfr: cvjl * ftpd\npsvd: stcw * hbvd\ntqrg: bshs - cgzs\nhgwg: fgqw + gbqz\nhmch: jswp - fqbn\ncqmv: tpmz + stsc\njcsq: qghq * qjcz\nqpqn: hqnz / zmlm\nlzdp: vpjz * zsvn\nbgsz: fdzp - hzsh\nvqgm: 3\nthjb: mchz * tvrj\nbfbz: 2\njhdf: 3\nprcs: 2\nmfrr: 4\nbrpd: 3\nnjbl: prdc * hgcp\nsgns: 3\ntjgn: qzcq * hrnf\nmfgw: 2\njsqn: zljs + bjbd\njbls: jnhj * wlwv\nltcn: tchh / jcnn\njhcr: ttcs + jmvc\nfdmh: 2\nvcst: 2\ntvmj: tzmm * vndh\nvrvr: lgln * qwvl\nrmrr: 4\njwwr: ffcn + fmjb\njtph: pvnt + hpmn\nbrqn: 12\nnqcw: 2\nbfwr: nbmz * pplv\ncdhh: qwpb - nzjh\nzfsf: bhbm * lmcn\nbhjr: ctth * wvsj\nsjdl: 2\nprhh: 4\nzppc: hctp / cgrh\nbcmd: 3\nsglm: 5\nzsfg: mpch * plgj\ngdqd: 2\nqbbz: 2\nhhdm: hchn + cpvd\nqdbz: wjhj + gvht\ndpbn: 12\nsnfh: 3\nvhqf: vpcs * gqzz\nmhfc: 4\nqcct: wrth * tbhv\ntwmw: 9\npcmd: 2\nzmqb: 3\njfhf: bmbq * wmbb\nbrjv: 4\nbmnn: sfwz + qzmd\npvpg: zvvw * bpjm\nnnvt: npct + cgnd\nmqzv: 4\ndnhb: 5\ntndn: 5\ncdtl: 2\ntvdc: snfh * wgfr\nrlrv: gphq / qlbs\nwdnm: fvmv * rtrc\ncnrp: cgnt * djtc\nbdww: bctr - fsqb\nfbdq: clcj + wjtd\nbvlv: fmdb * jmdz\nlpqn: 3\njdsb: 5\nmvrp: 5\nlwcm: 3\nndbs: rnnm * jcpj\ncglz: znnc * ptjc\nhwll: hjls - jcsw\nspbn: mpbr / grln\nlhfl: bvrn * sjht\nvlft: 9\nbjln: jzqd * hpzr\nlrnh: pnhw * dbcq\ntzgl: mbps + rhgq\nwmbb: ncfz + tmfb\ndwzz: twcm + dslr\nfvjt: 3\npgdm: zbzr * qjtc\njtpm: 2\nvjss: ndlq + hfdq\nhfvw: hzhc * zbjp\nrght: 9\ndjtd: 3\njtwm: 10\nmslt: 2\nhhwh: mjrf + zdpw\nftpd: sdmp + qrdc\ntqql: fbvc * bvmd\nqmjn: ptpf + nrjd\nnbcp: mzsc + sppm\nlvlg: 8\njjwr: 3\nccdl: 2\ntzpw: 3\nprmp: dnhb * thrm\nshnm: 9\nvqjt: 4\nnjrg: 4\ntfpm: fdjr + hzpg\nvcgm: 2\njnld: qhnd - zzzb\npwfn: 2\njqjm: prbs / rzzf\nwrnp: 2\nctmg: wgqp + wrqg\ndrzh: 4\nqqdw: 11\ncgzs: qgfd * sqnb\nbzfj: mvdw * hwcg\ngwcc: 9\nchsw: thjn * hmqs\nbgrh: gffr + nmjj\nbbwp: 2\nfbns: stfs * lwcm\nclls: 3\nrcdh: pplm * cmmj\nvwnc: fcbn + wdbm\ntrrt: nwgd * hcdv\nnplj: 18\ntlwm: wvml * lzlp\nmzfw: mzpv + qqht\nmqrc: 16\nndlq: gjwj * gddh\njqdw: dbth * bjcn\ndhdh: dqmj * tvmj\nbzqz: 17\ntfsn: fplw / gsgf\ntbqg: gvfg * qhlm\njsfb: 5\nfngh: qrgh * gwrb\ndrlm: dcqm * rbmm\nvwrt: wdnb - jcwh\nslmh: zhvc * zsrg\nrqgq: hhgt + svng\ngwfq: jpdt + qhpv\nstvc: crcz / hcmh\nctcp: 2\ngdrl: nztn + rdjj\nwvcp: tcqs + lmlq\nbjgh: tgdq * plms\ndlzq: tmqj + vjrs\njshp: rvfp - tpgs\nsgcb: 12\nzszf: 2\nmbtj: qmvv + hclm\nsswb: gsbn / hdnn\ndmcb: 2\nbncl: 13\ntdcc: 1\nwdwr: 4\nzlfm: 2\nmmcp: 2\ngzsv: fglt + hwln\npvnt: 13\nnhfm: 2\nzvjg: 2\njwhr: wgpl + hhnb\nmwgw: fjrd + hjrw\ncvsb: 2\ntpwm: qglr + tnmz\nbfsc: 9\npfwg: nchs + wvfw\ngbrj: 3\nfmdb: 2\nhqdn: 3\ndmvm: 2\ncwvm: bqqd * qsfb\nlbzl: 2\npphc: lfvh * tblp\njgrd: jzhz * pqrq\nvtch: pqcp * drdm\nggrf: mqqs + hmch\nzfrc: vqdb * sjwp\ncgrh: 2\nwzws: szll + qlfn\nlscw: 2\nlzqm: 2\njvpm: 3\nzcsf: 2\nwbwf: 2\ngwgm: 6\nmlcw: zqjl * spnp\nsjcj: psrr * nvdq\nqrhf: mzzl * dfcv\nswzl: zbcw + tjpj\nrdpp: 2\njpzn: rgqh / ccqq\nvhrc: svzj + qqwg\nprqv: 3\nbhbm: 2\nrvbn: 2\ndrdm: gvjm * vwdg\nqcwr: 5\ntzcn: 2\ntcpf: vbht / jpdw\nbccv: zfrc + rpsc\nvrgz: 9\nsvng: 5\nsvvl: 17\ngcrd: vdgf - bjzb\njfpv: glps * pngh\nwvmv: lggm - lpzn\nnltt: bwfb / gbqp\ngtjm: 2\nwlvl: 8\njczp: 2\nbjpr: 5\ntmjs: wgmn * hqnp\nmqvq: 2\ncmpz: 12\nqqtc: 2\nfbvc: 2\npzwn: wjhg + hcnv\nsfwz: zhbn * vstr\nlpfg: 5\npjdp: 2\nbncq: nbft + vbvf\nqglr: plgc * bfsc\nvvpb: 2\nltrm: mcsm * djpd\ntdgl: 2\nwzsn: vdmn * rmfd\ntmqj: 5\nwvmm: 1\ntrlw: cbgc + jlnj\nnbmh: 1\nhcts: 6\nwrcr: sbcl * hbtb\ngqcv: tjcm + rmfr\nvshb: pwfn + qbhg\nnvdq: 3\nrzfz: zjgt * rljl\nhrnf: htcn * nghl\nzppz: dnnp - lrpc\nqvmg: 2\nsjfb: nsjn * swzl\nstfm: jppq * vqjt\nhvqz: vmhr * vbsv\nptpf: fbvd * cflt\nfrpq: 2\njzhz: 3\ndlqt: 11\nlsfg: 4\npplv: cthg + rnnq\nttlg: rrvl / nzdm\nbltq: lcmm + bpns\nrfbj: zptw + fwzt\nlgnj: ghtq + tjgn\ndbpv: bmdc + srtj\nvhjv: dzbd * fjhr\nsvpw: 2\nqwjl: 2\nqrvv: tzgl * lmbf\nzjdm: 2\nmljz: 3\nfdhl: 3\nhbdh: lddv - htzn\nmcqn: 2\nttcs: 14\nrpcb: 3\nqmcg: hvhj + fghp\nnzdm: fglh * lmzd\ndwww: 12\nppzf: 2\nqwwl: hjsw + bdsd\nwdgw: 5\nmsbj: 9\nsvzj: 1\nprvz: nctf * srnv\ndrft: 4\njzqd: cbws + tbqm\nmnzh: 2\nzpsb: trmz * bsvd\nssbp: gldc * wfdv\nzgqm: gldq * cgnv\ncmsd: brbv * pccf\nvmtd: dlfn * snlv\nglws: wzjj + gwgm\nzptw: frrv * hzrt\nfnpv: jdsb * hqmb\ngctl: ndzz + chzs\nznnc: hwmg + chdw\ntgdq: gmwp * qmfz\nvftj: vjzr * szlw\nrjhw: ttbb + dqvf\nnfnw: 9\ngjwj: 15\njgmg: 2\ndngr: 3\ngjzt: 2\npwpp: lctb + wzph\ngwpn: pvqq + gczg\nlhwn: 2\nmpbr: 14\nfdzp: jllh * dwww\nbmnl: nnhf * twsc\nggnn: nvns * wvcs\nvmmw: 2\ntbqm: bhdt + wjsq\nwsbv: gsft * mnrs\njswp: wvrm + hlcm\ndzdr: 2\nmmmf: 1\nvzhj: vzhl + wzhp\nsrsl: 2\nhtvj: whzz * nbcp\ngdzh: 3\ntwjf: vgzr * bmmg\nhzsh: qwns + tmjs\ndqzp: rmfw * lpqn\ndbgg: 2\nwjnt: hbdh + rnqh\nvdpq: dlmj * ltnc\njnbr: wdgw + prgp\nrhvj: 3\nbcnh: 11\nztql: 19\ngqhq: bdds * bbwp\npgpg: sndc * tvlz\nmrbb: msbj + nsjg\nstnh: mzwg + gwlf\nhzgc: qtrb + tsvq\nbwts: dwqw * jdqq\njjbd: jhpf * csbn\nrrvl: cqwn * fmfm\nvwvc: 2\ntbmr: hvlg + qgld\nsbjz: mdcb + mspz\nlbhd: 3\njbcb: trcd - ncrb\nwtnb: 6\nfrjt: bffq * hglp\nwzql: nszr + tgcd\nqgfd: 3\nvgbd: bmds + fpdc\njnct: 4\nzwdd: dssz + twqw\nzvbh: fbbh * jtpm\nnfgw: frjf * stnh\ncvdp: rrdq + tgts\nmqqt: mbrr + hfmd\ncdmb: 2\npvch: wbft + vmtd\nhgcp: fbdq + ztsp\njmdz: fvbq * pspv\nbvqs: 20\nfmjb: ttlg * ntrd\nzdnr: 5\nzftc: 12\nslhd: zmwp * jqff\nhmqs: bzzl + zhmd\nvbwd: 9\nvhdh: 4\njqdc: 2\nltnc: jvtr + jnjq\nqvql: pzmr * lqqm\ncbsm: rdgb / gttj\nfbpw: 12\ndpsp: 7\nvvhd: 13\nvwnd: 1\nbmbq: 2\nhbqw: 9\nccds: 3\nbhfl: 3\ntpgs: swth / wzwp\nswpr: slcg + pnwh\nhlqd: 2\nzwbm: mnrh + cpfb\nqdlj: 2\nhnfz: fvqm / brbh\nqqlq: 3\ndzwg: tfml + phpv\nrnpf: 3\nzngc: nnfl + hbqw\nfmds: nsvp + rlhc\ntchr: dzwg * mfdb\ntgfz: pbps + fbrs\nnwmh: 3\ntnrd: pbfd * blpr\nzgtv: vblr * frsn\npzbr: pwdz * frgg\nnnfl: 2\nmlhf: fqrh + sqjl\ntscm: ggzt + tgjj\ndsbr: thqs + pccp\nzfbr: tsfz * vztj\nmbvj: zjzs * dbzz\nwdnb: qlrf * lwgd\nrmwz: tmzd * ljhq\nhpbc: tjhw * cvvb\nmrwj: ncnp * tjbl\nqwpb: sbqt - fhbv\ntflj: 5\nnlwj: 3\nghqg: 13\nvqzw: dfdc * qspl\nwjfj: 6\nhcfq: fqgg + pzbr\nnchs: qgrs * fwlr\npmgn: bdfj + slmn\nlzwz: vvbq / lsfg\nhqlq: 2\nhpmn: dttn * jstb\ndjtc: 2\ndccl: tgwh * msvl\nldgh: cggc * gnqp\njsvp: gsmv * tfcr\nmbps: 4\ndfcv: 16\ntgjj: jrzs / pjpp\ngzfn: 4\ntjpj: 3\ngbtz: cqmw / slqs\ncphb: fwgr * fvwq\nwrth: 2\nlqgf: 1\nmmcc: 2\nqcfr: 7\nvnvw: 12\npndw: 16\nptsl: hsnn * nmdm\nzmfn: 5\npsww: 3\nssnq: rwfc * nplz\nbwfb: 14\nfcdw: zgrj + nwqh\npjjv: 5\nhnhp: rdpq * tsmb\ngwlf: lmlf * hmcv\nbwcw: lvlg * crzd\nnmdm: 11\njjfq: znzl * tqnb\ndfsr: 3\nntnd: 2\njnbd: 2\nhmbc: 4\ncdnl: vpcl + szgv\ntmrv: 8\nnrrh: gctl - cphb\nnmpz: nbwg * qdjt\nrppz: lqgf + tgfz\nggfm: 2\nwzgl: 3\nqbgz: 2\nzqjl: 13\nmpfd: 5\nfbrh: jcwp + cqdw\nmqnf: lfjq - qjft\nlplv: 2\nmccr: qdlj * pgnd\nvdps: bdvv * ftnw\nzsvn: chnh + cmjw\nsqjl: bsvh - zrtv\nnvbg: 2\ndjpd: zvfc * wtcd\npwdf: ldvj + znnj\nszll: tdgl * vtbg\nhtbd: 4\nlhfq: slhd + jbls\nqshd: 2\nldch: 2\nlpqd: 5\nlmlq: bzcn / vvpb\nncgq: 3\nfwsl: 2\nrdjj: svdd / ssbp\nbshs: nzvf * qvqq\nwjgw: 11\nnqmh: rlds + tsvz\nmhhm: tflw * sszs\nqdcn: 3\nwdlg: lqjf * bnmd\ngmwp: 2\nwzbm: wzfn + chbq\njrzc: 18\nnpff: 7\ntgvg: flbp + mbvj\nrswm: swng * jlff\nzsdf: 5\nnvns: 7\nqmvc: bblr + chpr\nmdcf: nsqn + rbnd\nffzf: djpg - chsp\ndnsg: dmnh + lgnj\ncrpp: 2\nbswm: 20\nwrqd: dlzm * mnzh\nzztm: wnct + htqn\nvhgh: 2\nsztw: 2\nmhgd: 4\ntmhf: 2\nvfzt: bhvl * fjwb\nqmfz: 7\nqzgr: 2\ntbrs: ssng + nhpc\ncsqb: 1\nnrzv: qgtn / zzlf\nlsbq: vddh + whml\nsjht: hjds * pjpg\nhjls: lvtd + fshs\nhbbv: vwrt * cvsb\nsbfb: wvwn + sztw\nhrbq: 5\nqvqt: 2\nbtpg: fbbj + sjqr\njqbn: nncr + bgrh\ngndz: 2\nsjwq: 5\ndjfj: 7\nphpv: bmjc + gcrd\ngqpp: 2\nrmfr: thcj * shnm\nswqf: 2\nvfbb: wrtb - rfcp\ndjcj: gblg + zncf\nqzmd: 4\ncprz: gtzp + hccv\ndfdc: 5\nqjjt: hbbv / gndz\ntgcd: hlcp * hqdn\nsjgh: 2\nlphm: tffd * lfrm\nlqqm: trlw * fnvn\nlpmb: 4\ndslt: gtjm * jncn\ndctl: 3\npnwh: 4\nfjhr: cmfn + lgst\nbfqz: 2\nvgqr: 2\ncffs: nplj / ddmc\nmjgz: 1\nqqjr: 5\ntwbf: 2\nqlhv: tcrr * wglt\nqjjz: 3\nhqmn: pfwg + rqgq\ndgfj: 4\nztgr: 2\nrssf: dsbr * ddrl\nmhhf: 3\nmqlc: 1\nfmnv: 4\nqstn: cncz + vwnd\npzgm: zgvg + drsb\nrhnv: 2\nzhfd: 2\nhtqw: 2\ntwql: gbzb * vwcc\nznpv: 2\nfhvc: dqzp * fzpn\nvwff: 4\nnsmv: hgfg * djzn\nhrmd: 4\nfpdc: 1\nbclv: 2\nghtq: jgvd + pqdz\nwtwv: 5\njrrn: 7\nlrjz: 4\ndgsn: 4\nnhgb: lncv / zmbb\nhfjm: vqmc + djqp\nsbdb: rmwz - mfqc\nbsvh: qbbz * chvf\nnmjh: 17\nhznq: wvmv * tgfs\nnbwg: 6\nqvbm: 2\nfjzq: zqsq / pztq\nlqgr: 2\nhvjj: mslt * cdgd\nhjbt: 5\nlhcr: lndq + mbtc\ngqgj: 3\nhnct: 9\nwzph: bncq - tmjv\nptcg: hmdt * jnqm\nmdlm: 10\nhwcg: 6\nvvbq: wvwf * wlbm\nvpdv: 3\nnwzj: 9\nzltj: 5\npngh: 2\nsndc: 3\nhnvb: 2\nrwwc: ntlg - brpd\n"
