app [part1, part2] {
    pf: platform "https://github.com/ostcar/roc-aoc-platform/releases/download/v0.0.8/lhFfiil7mQXDOB6wN-jduJQImoT8qRmoiNHDB4DVF9s.tar.br",
    parser: "https://github.com/lukewilliamboswell/roc-parser/releases/download/0.9.0/w8YKp2YAgQt5REYk912HfKAHBjcXsrnvtjI0CBzoAT4.tar.br",
}

import parser.Parser exposing [Parser, const, keep, skip, sepBy, chompWhile, oneOf, map, flatten]
import parser.String exposing [parseStr, string]

example : Str
example =
    """
    x00: 1
    x01: 1
    x02: 1
    y00: 0
    y01: 1
    y02: 0

    x00 AND y00 -> z00
    x01 XOR y01 -> z01
    x02 OR y02 -> z02
    """

example2 : Str
example2 =
    """
    x00: 1
    x01: 0
    x02: 1
    x03: 1
    x04: 0
    y00: 1
    y01: 1
    y02: 1
    y03: 1
    y04: 1

    ntg XOR fgs -> mjb
    y02 OR x01 -> tnw
    kwq OR kpj -> z05
    x00 OR x03 -> fst
    tgd XOR rvg -> z01
    vdt OR tnw -> bfw
    bfw AND frj -> z10
    ffh OR nrd -> bqk
    y00 AND y03 -> djm
    y03 OR y00 -> psh
    bqk OR frj -> z08
    tnw OR fst -> frj
    gnj AND tgd -> z11
    bfw XOR mjb -> z00
    x03 OR x00 -> vdt
    gnj AND wpb -> z02
    x04 AND y00 -> kjc
    djm OR pbm -> qhw
    nrd AND vdt -> hwm
    kjc AND fst -> rvg
    y04 OR y02 -> fgs
    y01 AND x02 -> pbm
    ntg OR kjc -> kwq
    psh XOR fgs -> tgd
    qhw XOR tgd -> z09
    pbm OR djm -> kpj
    x03 XOR y03 -> ffh
    x00 XOR y04 -> ntg
    bfw OR bqk -> z06
    nrd XOR fgs -> wpb
    frj XOR qhw -> z04
    bqk OR frj -> z07
    y03 OR x01 -> nrd
    hwm AND bqk -> z03
    tgd XOR rvg -> z12
    tnw OR pbm -> gnj
    """

expect
    got = part1 example
    expected = Ok "4"
    got == expected

expect
    got = part1 example2
    expected = Ok "2024"
    got == expected

part1 : Str -> Result Str [ParsingFailure Str, ParsingIncomplete Str]
part1 = \rawInput ->
    parseStr puzzleParser (rawInput |> Str.trim)
    |> Result.map
        \input ->
            zIndex = findZIndex input.gates
            finalValues = startSystem (Dict.fromList input.initialValues) input.gates zIndex
            finalValues |> extractZWires zIndex |> Num.toStr

Wire : Str
Gate : { in1 : Wire, in2 : Wire, out : Wire, operation : Operation }
Operation : [AND, OR, XOR]

puzzleParser : Parser (List U8) { initialValues : List (Wire, Bool), gates : List Gate }
puzzleParser =
    const \initialValues -> \gates -> { initialValues, gates }
    |> keep (initialValueParser |> sepBy (string "\n"))
    |> skip (string "\n\n")
    |> keep (gateParser |> sepBy (string "\n"))

initialValueParser : Parser (List U8) (Str, Bool)
initialValueParser =
    const \wire -> \value -> (wire, value)
    |> keep wireParser
    |> skip (string ": ")
    |> keep
        (
            oneOf [
                string ("0") |> map \_ -> Bool.false,
                string ("1") |> map \_ -> Bool.true,
            ]
        )

gateParser : Parser (List U8) Gate
gateParser =
    const \in1 -> \operation -> \in2 -> \out -> { in1, in2, out, operation }
    |> keep wireParser
    |> skip (string " ")
    |> keep operationParser
    |> skip (string " ")
    |> keep wireParser
    |> skip (string " -> ")
    |> keep wireParser

wireParser : Parser (List U8) Wire
wireParser =
    chompWhile (\char -> ('0' <= char && char <= '9') || ('a' <= char && char <= 'z'))
    |> map \chars ->
        when chars |> Str.fromUtf8 is
            Err _ -> Err "Invalid wire id"
            Ok v -> Ok v
    |> flatten

operationParser : Parser (List U8) Operation
operationParser =
    oneOf [
        string ("AND") |> map \_ -> AND,
        string ("OR") |> map \_ -> OR,
        string ("XOR") |> map \_ -> XOR,
    ]

findZIndex : List Gate -> U64
findZIndex = \gates ->
    gates
    |> List.walk (Err NotFound) \state, gate ->
        [gate.in1, gate.in2, gate.out]
        |> List.walk state \innerState, wire ->
            when wire |> Str.toUtf8 is
                ['z', d1, d2] ->
                    num = [d1, d2] |> Str.fromUtf8 |> Result.withDefault "0" |> Str.toU64 |> Result.withDefault 0
                    when innerState is
                        Err NotFound -> Ok num
                        Ok prev -> Num.max prev num |> Ok

                _ -> innerState
    |> Result.withDefault 0

startSystem : Dict Wire Bool, List Gate, U64 -> Dict Wire Bool
startSystem = \wires, gates, zIndex ->
    if (zIndex + 1) == wires |> Dict.keys |> List.keepIf (\k -> k |> Str.startsWith "z") |> List.len then
        wires
        else

    gates
    |> List.walk wires \state, gate ->
        if state |> Dict.contains gate.out then
            state
            else

        when (state |> Dict.get gate.in1, state |> Dict.get gate.in2) is
            (Ok in1, Ok in2) ->
                out =
                    when gate.operation is
                        AND -> in1 && in2
                        OR -> in1 || in2
                        XOR -> in1 != in2
                state |> Dict.insert gate.out out

            _ -> state
    |> startSystem gates zIndex

extractZWires : Dict Wire Bool, U64 -> U64
extractZWires = \wires, zIndex ->
    List.range { start: At 0, end: At zIndex }
    |> List.walk 0 \acc, i ->
        wire =
            if i < 10 then
                "z0$(Num.toStr i)"
            else
                "z$(Num.toStr i)"
        when wires |> Dict.get wire is
            Err KeyNotFound -> acc
            Ok b ->
                if b then acc + (2 |> Num.powInt i) else acc

expect
    got = part2 example
    expected = Ok ""
    got == expected

part2 : Str -> Result Str [ParsingFailure Str, ParsingIncomplete Str]
part2 = \rawInput ->
    parseStr puzzleParser (rawInput |> Str.trim)
    |> Result.map
        \_input ->
            ""
