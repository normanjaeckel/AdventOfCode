app [part1, part2] {
    pf: platform "https://github.com/ostcar/roc-aoc-platform/releases/download/v0.0.8/lhFfiil7mQXDOB6wN-jduJQImoT8qRmoiNHDB4DVF9s.tar.br",
    parser: "https://github.com/lukewilliamboswell/roc-parser/releases/download/0.9.0/w8YKp2YAgQt5REYk912HfKAHBjcXsrnvtjI0CBzoAT4.tar.br",
}

import parser.Parser exposing [Parser, const, flatten, keep, map, sepBy, skip]
import parser.String exposing [parseStr, digit, digits, string]

example : Str
example =
    """
    Register A: 729
    Register B: 0
    Register C: 0

    Program: 0,1,5,4,3,0
    """

expect
    got = part1 example
    expected = Ok "4,6,3,5,6,3,5,2,1,0"
    got == expected

part1 : Str -> Result Str [ParsingFailure Str, ParsingIncomplete Str]
part1 = \rawInput ->
    parseStr puzzleParser (rawInput |> Str.trim)
    |> Result.map
        \input ->
            runComputer input.register input.program
            |> List.map Num.toStr
            |> Str.joinWith ","

Register : { a : U64, b : U64, c : U64 }
Program : List Instruction
Instruction : [Adv ComboOp, Bdv ComboOp, Cdv ComboOp, Bxl LiteralOp, Bst ComboOp, Bxc, Jnz LiteralOp, Out ComboOp]
LiteralOp : U64
ComboOp : [Lit0, Lit1, Lit2, Lit3, A, B, C]

puzzleParser : Parser (List U8) { register : Register, program : Program, programRaw : List U64 }
puzzleParser =
    const \register -> \(program, programRaw) -> { register, program, programRaw }
    |> keep registerParser
    |> skip (string "\n\n")
    |> keep programParser

registerParser : Parser (List U8) Register
registerParser =
    const \a -> \b -> \c -> { a, b, c }
    |> skip (string "Register A: ")
    |> keep digits
    |> skip (string "\nRegister B: ")
    |> keep digits
    |> skip (string "\nRegister C: ")
    |> keep digits

programParser : Parser (List U8) (Program, List U64)
programParser =
    const \p -> p
    |> skip (string "Program: ")
    |> keep (digit |> sepBy (string ","))
    |> map toProgram
    |> flatten

toProgram : List U64 -> Result (Program, List U64) Str
toProgram = \numbers ->
    helper = \nums, result ->
        when nums is
            [] -> Ok (result, numbers)
            [instruction, operand, .. as rest] ->
                v =
                    when instruction is
                        0 -> operand |> toCombo |> Result.map \o -> Adv o
                        1 -> Ok (Bxl operand)
                        2 -> operand |> toCombo |> Result.map \o -> Bst o
                        3 -> Ok (Jnz operand)
                        4 -> Ok Bxc
                        5 -> operand |> toCombo |> Result.map \o -> Out o
                        6 -> operand |> toCombo |> Result.map \o -> Bdv o
                        7 -> operand |> toCombo |> Result.map \o -> Cdv o
                        _ -> Err "Invalid instruction number"
                v |> Result.try \i -> helper rest (result |> List.append i)

            _ -> Err "Invalid lenght of instruction numbers"

    helper numbers []

toCombo : U64 -> Result ComboOp Str
toCombo = \n ->
    when n is
        0 -> Ok Lit0
        1 -> Ok Lit1
        2 -> Ok Lit2
        3 -> Ok Lit3
        4 -> Ok A
        5 -> Ok B
        6 -> Ok C
        _ -> Err "Invalid number for combo operand"

runComputer : Register, Program -> List U64
runComputer = \register, program ->
    runComputerHelper register program 0 []

runComputerHelper : Register, Program, U64, List U64 -> List U64
runComputerHelper = \register, program, pointer, output ->
    when program |> List.get (pointer // 2) is
        Err OutOfBounds -> output
        Ok instruction ->
            when instruction is
                Adv op ->
                    newA = register.a // (2 |> Num.powInt (valueOfCombo register op))
                    runComputerHelper { register & a: newA } program (pointer + 2) output

                Bdv op ->
                    newB = register.a // (2 |> Num.powInt (valueOfCombo register op))
                    runComputerHelper { register & b: newB } program (pointer + 2) output

                Cdv op ->
                    newC = register.a // (2 |> Num.powInt (valueOfCombo register op))
                    runComputerHelper { register & c: newC } program (pointer + 2) output

                Bxl op ->
                    newB = register.b |> Num.bitwiseXor op
                    runComputerHelper { register & b: newB } program (pointer + 2) output

                Bst op ->
                    newB = valueOfCombo register op % 8
                    runComputerHelper { register & b: newB } program (pointer + 2) output

                Bxc ->
                    newB = register.b |> Num.bitwiseXor register.c
                    runComputerHelper { register & b: newB } program (pointer + 2) output

                Jnz op ->
                    newPointer =
                        if register.a == 0 then
                            pointer + 2
                        else
                            op
                    runComputerHelper register program newPointer output

                Out op ->
                    runComputerHelper register program (pointer + 2) (output |> List.append (valueOfCombo register op % 8))

valueOfCombo : Register, ComboOp -> U64
valueOfCombo = \register, op ->
    when op is
        Lit0 -> 0
        Lit1 -> 1
        Lit2 -> 2
        Lit3 -> 3
        A -> register.a
        B -> register.b
        C -> register.c

example2 : Str
example2 =
    """
    Register A: 2024
    Register B: 0
    Register C: 0

    Program: 0,3,5,4,3,0
    """

expect
    got = part2 example2
    expected = Ok "117440"
    got == expected

part2 : Str -> Result Str [ParsingFailure Str, ParsingIncomplete Str, NoSolutionFound]
part2 = \rawInput ->
    parseStr puzzleParser (rawInput |> Str.trim)
    |> Result.try
        \input ->
            startingNumbers = [1, 2, 3, 4, 5, 6, 7]
            findStartValue input.register input.program input.programRaw startingNumbers
            |> Result.map Num.toStr

findStartValue : Register, Program, List U64, List U64 -> Result U64 [NoSolutionFound]
findStartValue = \register, program, programRaw, possibleSolutions ->
    when possibleSolutions is
        [] -> Err NoSolutionFound
        [possibleSolution, .. as rest] ->
            result = runComputer { register & a: possibleSolution } program

            if programRaw == result then
                Ok possibleSolution
                else

            newPossibleSolutions =
                if programRaw |> List.endsWith result then
                    List.range { start: At (possibleSolution * 8), end: Length 8 } |> List.concat rest
                else
                    rest

            findStartValue register program programRaw newPossibleSolutions
