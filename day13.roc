app [part1, part2] {
    pf: platform "https://github.com/ostcar/roc-aoc-platform/releases/download/v0.0.8/lhFfiil7mQXDOB6wN-jduJQImoT8qRmoiNHDB4DVF9s.tar.br",
    parser: "https://github.com/lukewilliamboswell/roc-parser/releases/download/0.9.0/w8YKp2YAgQt5REYk912HfKAHBjcXsrnvtjI0CBzoAT4.tar.br",
}

import parser.Parser exposing [Parser, const, keep, map, sepBy, skip]
import parser.String exposing [parseStr, anyCodeunit, digits, string]

example : Str
example =
    """
    Button A: X+94, Y+34
    Button B: X+22, Y+67
    Prize: X=8400, Y=5400

    Button A: X+26, Y+66
    Button B: X+67, Y+21
    Prize: X=12748, Y=12176

    Button A: X+17, Y+86
    Button B: X+84, Y+37
    Prize: X=7870, Y=6450

    Button A: X+69, Y+23
    Button B: X+27, Y+71
    Prize: X=18641, Y=10279
    """

expect
    got = part1 example
    expected = Ok "480"
    got == expected

ClawMaschine : { buttonA : Button, buttonB : Button, prize : Prize }
Button : { x : U64, y : U64, costs : U64 }
Prize : { x : U64, y : U64 }

part1 : Str -> Result Str [ParsingFailure Str, ParsingIncomplete Str]
part1 = \rawInput ->
    parseStr puzzleParser (rawInput |> Str.trim)
    |> Result.map
        \clawMaschines ->
            clawMaschines
            |> List.map \cm -> winThePrize cm 0
            |> List.sum
            |> Num.toStr

puzzleParser : Parser (List U8) (List ClawMaschine)
puzzleParser =
    clawMaschineParser |> sepBy (string "\n\n")

clawMaschineParser : Parser (List U8) ClawMaschine
clawMaschineParser =
    const \buttonA -> \buttonB -> \prize -> { buttonA, buttonB, prize }
    |> keep buttonParser
    |> skip (string "\n")
    |> keep buttonParser
    |> skip (string "\n")
    |> keep prizeParser

buttonParser : Parser (List U8) Button
buttonParser =
    const \costs -> \x -> \y -> { x, y, costs }
    |> skip (string "Button ")
    |> keep
        (
            anyCodeunit |> map \c -> if c == 'A' then 3 else 1
        )
    |> skip (string ": X+")
    |> keep digits
    |> skip (string ", Y+")
    |> keep digits

prizeParser : Parser (List U8) Prize
prizeParser =
    const \x -> \y -> { x, y }
    |> skip (string "Prize: X=")
    |> keep digits
    |> skip (string ", Y=")
    |> keep digits

winThePrize : ClawMaschine, U64 -> U64
winThePrize = \cm, offset ->
    px = cm.prize.x + offset
    py = cm.prize.y + offset
    a1 = (Num.toI64 py * Num.toI64 cm.buttonB.x - Num.toI64 px * Num.toI64 cm.buttonB.y)
    a2 = (Num.toI64 cm.buttonA.y * Num.toI64 cm.buttonB.x - Num.toI64 cm.buttonA.x * Num.toI64 cm.buttonB.y)
    b1 = (Num.toI64 py * Num.toI64 cm.buttonA.x - Num.toI64 px * Num.toI64 cm.buttonA.y)
    b2 = (Num.toI64 cm.buttonB.y * Num.toI64 cm.buttonA.x - Num.toI64 cm.buttonB.x * Num.toI64 cm.buttonA.y)
    (da, ma) = diffAndMod a1 a2
    (db, mb) = diffAndMod b1 b2
    if ma == 0 && mb == 0 then
        da * 3 + db |> Num.toU64
    else
        0

diffAndMod : I64, I64 -> (I64, I64)
diffAndMod = \a, b ->
    (a // b, a % b)

exampleExtra =
    """
    Button A: X+51, Y+90
    Button B: X+75, Y+36
    Prize: X=10818, Y=11286
    """

expect
    got = part1 exampleExtra
    expected = Ok "360" # A = 93, B = 81
    got == expected

expect
    got = part2 example
    expected = Ok "875318608908"
    got == expected

part2 : Str -> Result Str [ParsingFailure Str, ParsingIncomplete Str]
part2 = \rawInput ->
    parseStr puzzleParser (rawInput |> Str.trim)
    |> Result.map
        \clawMaschines ->
            clawMaschines
            |> List.map \cm -> winThePrize cm 10000000000000
            |> List.sum
            |> Num.toStr

# winThePrize1 : ClawMaschine -> U64
# winThePrize1 = \cm ->
#     maxA = Num.min (cm.prize.x // cm.buttonA.x) (cm.prize.y // cm.buttonA.y)
#     maxB = Num.min (cm.prize.x // cm.buttonB.x) (cm.prize.y // cm.buttonB.y)
#     if maxA <= maxB then
#         checkButton maxA cm.buttonA cm.buttonB cm.prize
#     else
#         checkButton maxB cm.buttonB cm.buttonA cm.prize

# checkButton : U64, Button, Button, Prize -> U64
# checkButton = \max, b1, b2, prize ->
#     List.range { start: At 0, end: At (Num.min max 100) }
#     |> List.map
#         \push ->
#             (dx, mx) = diffAndMod1 (prize.x - (b1.x * push)) b2.x
#             (dy, my) = diffAndMod1 (prize.y - (b1.y * push)) b2.y
#             if mx != 0 || my != 0 then
#                 Err NotPossible
#             else if dx != dy then
#                 Err NotPossible
#             else if dx > 100 then
#                 Err NotPossible
#             else
#                 Ok ((push * b1.costs) + (dx * b2.costs))
#     |> List.walk
#         []
#         \state, res ->
#             when res is
#                 Err NotPossible -> state
#                 Ok v -> state |> List.append v
#     |> List.min
#     |> Result.withDefault 0

# diffAndMod1 : U64, U64 -> (U64, U64)
# diffAndMod1 = \a, b ->
#     (a // b, a % b)
