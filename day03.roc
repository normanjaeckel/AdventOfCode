app [part1, part2] {
    pf: platform "https://github.com/ostcar/roc-aoc-platform/releases/download/v0.0.6/h-Fncg-ySjnWsh6mOiuaqdkz6wwfYCPCgy64Wep58YI.tar.br",
    parser: "https://github.com/lukewilliamboswell/roc-parser/releases/download/0.9.0/w8YKp2YAgQt5REYk912HfKAHBjcXsrnvtjI0CBzoAT4.tar.br",
}

example : Str
example =
    "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"

expect
    got = part1 example
    expected = Ok "161"
    got == expected

part1 : Str -> Result Str [NoErrorHere]
part1 = \rawInput ->
    rawInput
    |> Str.toUtf8
    |> List.walk
        { status: Outside, total: 0, factorA: 0 }
        \state, char ->
            (newStatus, foN) = parseChar state.status char
            when foN is
                Factor f ->
                    if newStatus == Delimiter then
                        { state & status: newStatus, factorA: f }
                    else if newStatus == Outside then
                        { state & status: newStatus, total: state.total + (state.factorA * f), factorA: 0 }
                    else
                        crash "Neverever"

                Nothing ->
                    { state & status: newStatus }
    |> \state ->
        state.total
        |> Num.toStr
        |> Ok

Status : [Outside, Statement U8, FactorA U64, Delimiter, FactorB U64]
FactorOrNothing : [Factor U64, Nothing]

parseChar : Status, U8 -> (Status, FactorOrNothing)
parseChar = \status, c ->
    when status is
        Outside ->
            if c == 'm' then
                (Statement 0, Nothing)
            else
                (Outside, Nothing)

        Statement s ->
            when (s, c) is
                (0, 'u') -> (Statement 1, Nothing)
                (1, 'l') -> (Statement 2, Nothing)
                (2, '(') -> (Statement 3, Nothing)
                (3, n) ->
                    if n >= '1' && n <= '9' then
                        (FactorA (n - '0' |> Num.toU64), Nothing)
                    else
                        (Outside, Nothing)

                _ ->
                    (Outside, Nothing)

        FactorA a ->
            if c == ',' then
                (Delimiter, Factor a)
            else if c >= '0' && c <= '9' then
                (FactorA (a * 10 + (c - '0' |> Num.toU64)), Nothing)
            else
                (Outside, Nothing)

        Delimiter ->
            if c >= '1' && c <= '9' then
                (FactorB (c - '0' |> Num.toU64), Nothing)
            else
                (Outside, Nothing)

        FactorB b ->
            if c == ')' then
                (Outside, Factor b)
            else if c >= '0' && c <= '9' then
                (FactorB (b * 10 + (c - '0' |> Num.toU64)), Nothing)
            else
                (Outside, Nothing)

example2 = "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"

expect
    got = part2 example2
    expected = Ok "48"
    got == expected

part2 : Str -> Result Str [NoErrorHere]
part2 = \rawInput ->
    rawInput |> stripOfDonts |> part1

stripOfDonts : Str -> Str
stripOfDonts = \s ->
    s |> stripOfDontsHelper

stripOfDontsHelper : Str -> Str
stripOfDontsHelper = \str ->
    str
    |> Str.splitFirst "don't()"
    |> Result.map
        \r1 ->
            when r1.after |> Str.splitFirst "do()" is
                Err NotFound -> r1.before
                Ok r2 ->
                    r1.before |> Str.concat r2.after |> stripOfDontsHelper
    |> Result.withDefault str
