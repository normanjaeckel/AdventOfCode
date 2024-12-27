app [part1, part2] {
    pf: platform "https://github.com/ostcar/roc-aoc-platform/releases/download/v0.0.8/lhFfiil7mQXDOB6wN-jduJQImoT8qRmoiNHDB4DVF9s.tar.br",
    parser: "https://github.com/lukewilliamboswell/roc-parser/releases/download/0.9.0/w8YKp2YAgQt5REYk912HfKAHBjcXsrnvtjI0CBzoAT4.tar.br",
}

import parser.Parser exposing [Parser, oneOf, oneOrMore, sepBy, map]
import parser.String exposing [parseStr, string]

example : Str
example =
    """
    029A
    980A
    179A
    456A
    379A
    """

expect
    got = part1 example
    expected = Ok "126384"
    got == expected

part1 : Str -> Result Str [ParsingFailure Str, ParsingIncomplete Str]
part1 = \rawInput ->
    parseStr puzzleParser (rawInput |> Str.trim)
    |> Result.map
        \doorcodes ->
            doorcodes
            |> List.map \doorcode -> solve doorcode 2
            |> List.sum
            |> Num.toStr

Doorcode : List NumericButton
NumericButton : [Zero, One, Two, Three, Four, Five, Six, Seven, Eight, Nine, Activate]
DirectionalButton : [Left, Right, Up, Down, Activate]
Sequence : List DirectionalButton

puzzleParser : Parser (List U8) (List Doorcode)
puzzleParser =
    doorCodeParser |> sepBy (string "\n")

doorCodeParser : Parser (List U8) Doorcode
doorCodeParser =
    oneOrMore
        (
            oneOf [
                string "0" |> map \_ -> Zero,
                string "1" |> map \_ -> One,
                string "2" |> map \_ -> Two,
                string "3" |> map \_ -> Three,
                string "4" |> map \_ -> Four,
                string "5" |> map \_ -> Five,
                string "6" |> map \_ -> Six,
                string "7" |> map \_ -> Seven,
                string "8" |> map \_ -> Eight,
                string "9" |> map \_ -> Nine,
                string "A" |> map \_ -> Activate,
            ]
        )

solve : Doorcode, U64 -> U64
solve = \doorcode, count ->
    min =
        getSequencesForDoor doorcode
        |> sequencesToDict (Dict.empty {}) 1
        |> solveHelper count
    min * doorCodeToNumbericalValue doorcode

getSequencesForDoor : Doorcode -> List Sequence
getSequencesForDoor = \doorcode ->
    getSequencesForDoorHelper Activate doorcode []

getSequencesForDoorHelper : NumericButton, List NumericButton, List Sequence -> List Sequence
getSequencesForDoorHelper = \current, buttons, result ->
    when buttons is
        [] -> result
        [button, .. as next] ->
            newResult = result |> List.append (pathForDoor current button)
            getSequencesForDoorHelper button next newResult

pathForDoor : NumericButton, NumericButton -> Sequence
pathForDoor = \current, target ->
    # For some reason that I do not understand we must use Left before Up/Down and Up/Down before Right whenever possible,
    # meaning that when we would get to a gap the path is not allowed.
    sequence =
        when current is
            Activate ->
                when target is
                    Activate -> []
                    Zero -> [Left]
                    One -> [Up, Left, Left]
                    Two -> [Left, Up]
                    Three -> [Up]
                    Four -> [Up, Up, Left, Left]
                    Five -> [Left, Up, Up]
                    Six -> [Up, Up]
                    Seven -> [Up, Up, Up, Left, Left]
                    Eight -> [Left, Up, Up, Up]
                    Nine -> [Up, Up, Up]

            Zero ->
                when target is
                    Activate -> [Right]
                    Zero -> []
                    One -> [Up, Left]
                    Two -> [Up]
                    Three -> [Up, Right]
                    Four -> [Up, Up, Left]
                    Five -> [Up, Up]
                    Six -> [Up, Up, Right]
                    Seven -> [Up, Up, Up, Left]
                    Eight -> [Up, Up, Up]
                    Nine -> [Up, Up, Up, Right]

            One ->
                when target is
                    Activate -> [Right, Right, Down]
                    Zero -> [Right, Down]
                    One -> []
                    Two -> [Right]
                    Three -> [Right, Right]
                    Four -> [Up]
                    Five -> [Up, Right]
                    Six -> [Up, Right, Right]
                    Seven -> [Up, Up]
                    Eight -> [Up, Up, Right]
                    Nine -> [Up, Up, Right, Right]

            Two ->
                when target is
                    Activate -> [Down, Right]
                    Zero -> [Down]
                    One -> [Left]
                    Two -> []
                    Three -> [Right]
                    Four -> [Left, Up]
                    Five -> [Up]
                    Six -> [Up, Right]
                    Seven -> [Left, Up, Up]
                    Eight -> [Up, Up]
                    Nine -> [Up, Up, Right]

            Three ->
                when target is
                    Activate -> [Down]
                    Zero -> [Left, Down]
                    One -> [Left, Left]
                    Two -> [Left]
                    Three -> []
                    Four -> [Left, Left, Up]
                    Five -> [Left, Up]
                    Six -> [Up]
                    Seven -> [Left, Left, Up, Up]
                    Eight -> [Left, Up, Up]
                    Nine -> [Up, Up]

            Four ->
                when target is
                    Activate -> [Right, Right, Down, Down]
                    Zero -> [Right, Down, Down]
                    One -> [Down]
                    Two -> [Down, Right]
                    Three -> [Down, Right, Right]
                    Four -> []
                    Five -> [Right]
                    Six -> [Right, Right]
                    Seven -> [Up]
                    Eight -> [Up, Right]
                    Nine -> [Up, Right, Right]

            Five ->
                when target is
                    Activate -> [Down, Down, Right]
                    Zero -> [Down, Down]
                    One -> [Left, Down]
                    Two -> [Down]
                    Three -> [Down, Right]
                    Four -> [Left]
                    Five -> []
                    Six -> [Right]
                    Seven -> [Left, Up]
                    Eight -> [Up]
                    Nine -> [Up, Right]

            Six ->
                when target is
                    Activate -> [Down, Down]
                    Zero -> [Left, Down, Down]
                    One -> [Left, Left, Down]
                    Two -> [Left, Down]
                    Three -> [Down]
                    Four -> [Left, Left]
                    Five -> [Left]
                    Six -> []
                    Seven -> [Left, Left, Up]
                    Eight -> [Left, Up]
                    Nine -> [Up]

            Seven ->
                when target is
                    Activate -> [Right, Right, Down, Down, Down]
                    Zero -> [Right, Down, Down, Down]
                    One -> [Down, Down]
                    Two -> [Down, Down, Right]
                    Three -> [Down, Down, Right, Right]
                    Four -> [Down]
                    Five -> [Down, Right]
                    Six -> [Down, Right, Right]
                    Seven -> []
                    Eight -> [Right]
                    Nine -> [Right, Right]

            Eight ->
                when target is
                    Activate -> [Down, Down, Down, Right]
                    Zero -> [Down, Down, Down]
                    One -> [Left, Down, Down]
                    Two -> [Down, Down]
                    Three -> [Down, Down, Right]
                    Four -> [Left, Down]
                    Five -> [Down]
                    Six -> [Down, Right]
                    Seven -> [Left]
                    Eight -> []
                    Nine -> [Right]

            Nine ->
                when target is
                    Activate -> [Down, Down, Down]
                    Zero -> [Left, Down, Down, Down]
                    One -> [Left, Left, Down, Down]
                    Two -> [Left, Down, Down]
                    Three -> [Down, Down]
                    Four -> [Left, Left, Down]
                    Five -> [Left, Down]
                    Six -> [Down]
                    Seven -> [Left, Left]
                    Eight -> [Left]
                    Nine -> []

    sequence |> List.append Activate

sequencesToDict : List Sequence, Dict Sequence U64, U64 -> Dict Sequence U64
sequencesToDict = \sequences, initial, num ->
    sequences
    |> List.walk initial \dict, seq ->
        dict
        |> Dict.update seq \possibileValue ->
            when possibileValue is
                Err Missing -> Ok num
                Ok n -> Ok (n + num)

solveHelper : Dict Sequence U64, U64 -> U64
solveHelper = \dict, count ->
    if count == 0 then
        dict
        |> Dict.toList
        |> List.map \(k, v) ->
            v * List.len k
        |> List.sum
        else

    dict
    |> Dict.toList
    |> List.walk (Dict.empty {}) \acc, (seq, num) ->
        getSequencesForRobot seq |> sequencesToDict acc num
    |> solveHelper (count - 1)

getSequencesForRobot : Sequence -> List Sequence
getSequencesForRobot = \sequence ->
    getSequencesForRobotHelper Activate sequence []

getSequencesForRobotHelper : DirectionalButton, List DirectionalButton, List Sequence -> List Sequence
getSequencesForRobotHelper = \current, buttons, result ->
    when buttons is
        [] -> result
        [button, .. as next] ->
            newResult = result |> List.append (pathForRobot current button)
            getSequencesForRobotHelper button next newResult

pathForRobot : DirectionalButton, DirectionalButton -> Sequence
pathForRobot = \current, target ->
    sequence =
        when current is
            Activate ->
                when target is
                    Activate -> []
                    Up -> [Left]
                    Down -> [Left, Down]
                    Left -> [Down, Left, Left]
                    Right -> [Down]

            Up ->
                when target is
                    Activate -> [Right]
                    Up -> []
                    Down -> [Down]
                    Left -> [Down, Left]
                    Right -> [Down, Right]

            Down ->
                when target is
                    Activate -> [Up, Right]
                    Up -> [Up]
                    Down -> []
                    Left -> [Left]
                    Right -> [Right]

            Left ->
                when target is
                    Activate -> [Right, Right, Up]
                    Up -> [Right, Up]
                    Down -> [Right]
                    Left -> []
                    Right -> [Right, Right]

            Right ->
                when target is
                    Activate -> [Up]
                    Up -> [Left, Up]
                    Down -> [Left]
                    Left -> [Left, Left]
                    Right -> []

    sequence |> List.append Activate

doorCodeToNumbericalValue : Doorcode -> U64
doorCodeToNumbericalValue = \d ->
    d
    |> List.dropLast 1
    |> List.map numericButtonToNum
    |> List.reverse
    |> List.walkWithIndex 0 \acc, n, i ->
        acc + (n * (10 |> Num.powInt i))

numericButtonToNum : NumericButton -> U64
numericButtonToNum = \n ->
    when n is
        Zero -> 0
        One -> 1
        Two -> 2
        Three -> 3
        Four -> 4
        Five -> 5
        Six -> 6
        Seven -> 7
        Eight -> 8
        Nine -> 9
        Activate -> crash "Button Activate is not a number"

expect
    doorcode = [Zero, Two, Nine, Activate]
    got = doorCodeToNumbericalValue doorcode
    expected = 29
    got == expected

expect
    doorcode = [One, Seven, Nine, Activate]
    got = solve doorcode 2
    expected = 68 * 179
    got == expected

expect
    doorcode = [Two, Four, Six, Activate]
    got = solve doorcode 2
    expected = 70 * 246
    got == expected

part2 : Str -> Result Str [ParsingFailure Str, ParsingIncomplete Str]
part2 = \rawInput ->
    parseStr puzzleParser (rawInput |> Str.trim)
    |> Result.map
        \doorcodes ->
            doorcodes
            |> List.map \doorcode -> solve doorcode 25
            |> List.sum
            |> Num.toStr
