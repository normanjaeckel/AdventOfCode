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
            |> List.map solve
            |> List.sum
            |> Num.toStr

Doorcode : List NumericButton
NumericButton : [Zero, One, Two, Three, Four, Five, Six, Seven, Eight, Nine, Activate]
DirectionalButton : [Left, Right, Up, Down, Activate]

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

solve : Doorcode -> U64
solve = \doorcode ->
    result =
        getPathsForDoor Activate doorcode [[]]
        |> List.map \pathForDoor ->
            getPathsForRobot Activate pathForDoor [[]]
        |> List.join
        |> List.map \pathForRobot ->
            getPathsForRobot Activate pathForRobot [[]]
            |> List.map List.len
        |> List.join
    min = List.min result |> Result.withDefault 0
    min * doorCodeToNumbericalValue doorcode

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

getPathsForDoor : NumericButton, Doorcode, List (List DirectionalButton) -> List (List DirectionalButton)
getPathsForDoor = \currentPos, doorcode, result ->
    when doorcode is
        [] -> result
        [next, .. as rest] ->
            newResult =
                variantsForNumbericKeypad currentPos next
                |> List.map \var ->
                    result |> List.map (\r -> r |> List.concat var)
                |> List.join
            getPathsForDoor next rest newResult

variantsForNumbericKeypad : NumericButton, NumericButton -> List (List DirectionalButton)
variantsForNumbericKeypad = \current, target ->
    vertical =
        when current is
            Seven | Eight | Nine ->
                when target is
                    Seven | Eight | Nine -> []
                    Four | Five | Six -> [Down]
                    One | Two | Three -> [Down, Down]
                    Zero | Activate -> [Down, Down, Down]

            Four | Five | Six ->
                when target is
                    Seven | Eight | Nine -> [Up]
                    Four | Five | Six -> []
                    One | Two | Three -> [Down]
                    Zero | Activate -> [Down, Down]

            One | Two | Three ->
                when target is
                    Seven | Eight | Nine -> [Up, Up]
                    Four | Five | Six -> [Up]
                    One | Two | Three -> []
                    Zero | Activate -> [Down]

            Zero | Activate ->
                when target is
                    Seven | Eight | Nine -> [Up, Up, Up]
                    Four | Five | Six -> [Up, Up]
                    One | Two | Three -> [Up]
                    Zero | Activate -> []
    horizontal =
        when current is
            One | Four | Seven ->
                when target is
                    One | Four | Seven -> []
                    Zero | Two | Five | Eight -> [Right]
                    Activate | Three | Six | Nine -> [Right, Right]

            Zero | Two | Five | Eight ->
                when target is
                    One | Four | Seven -> [Left]
                    Zero | Two | Five | Eight -> []
                    Activate | Three | Six | Nine -> [Right]

            Activate | Three | Six | Nine ->
                when target is
                    One | Four | Seven -> [Left, Left]
                    Zero | Two | Five | Eight -> [Left]
                    Activate | Three | Six | Nine -> []
    var1 = List.concat vertical horizontal |> List.append Activate
    var2 = List.concat horizontal vertical |> List.append Activate
    if var1 == var2 then
        [var1]
        else

    when current is
        Zero | Activate ->
            when target is
                One | Four | Seven -> [var1]
                _ -> [var1, var2]

        One | Four | Seven ->
            when target is
                Zero | Activate -> [var2]
                _ -> [var1, var2]

        _ -> [var1, var2]

getPathsForRobot : DirectionalButton, List DirectionalButton, List (List DirectionalButton) -> List (List DirectionalButton)
getPathsForRobot = \currentPos, code, result ->
    when code is
        [] ->
            result

        [next, .. as rest] ->
            newResult =
                variantsForDirectionalKeypad currentPos next
                |> List.map \var ->
                    result |> List.map (\r -> r |> List.concat var)
                |> List.join
            getPathsForRobot next rest newResult

variantsForDirectionalKeypad : DirectionalButton, DirectionalButton -> List (List DirectionalButton)
variantsForDirectionalKeypad = \current, target ->
    variants =
        when current is
            Activate ->
                when target is
                    Activate -> [[]]
                    Up -> [[Left]]
                    Down -> [[Left, Down], [Down, Left]]
                    Left -> [[Left, Down, Left], [Down, Left, Left]]
                    Right -> [[Down]]

            Up ->
                when target is
                    Activate -> [[Right]]
                    Up -> [[]]
                    Down -> [[Down]]
                    Left -> [[Down, Left]]
                    Right -> [[Down, Right], [Right, Down]]

            Down ->
                when target is
                    Activate -> [[Up, Right], [Right, Up]]
                    Up -> [[Up]]
                    Down -> [[]]
                    Left -> [[Left]]
                    Right -> [[Right]]

            Left ->
                when target is
                    Activate -> [[Right, Right, Up], [Right, Up, Right]]
                    Up -> [[Right, Up]]
                    Down -> [[Right]]
                    Left -> [[]]
                    Right -> [[Right, Right]]

            Right ->
                when target is
                    Activate -> [[Up]]
                    Up -> [[Up, Left], [Left, Up]]
                    Down -> [[Left]]
                    Left -> [[Left, Left]]
                    Right -> [[]]
    variants |> List.map \v -> v |> List.append Activate

expect
    doorcode = [Zero, Two, Nine, Activate]
    got = doorCodeToNumbericalValue doorcode
    expected = 29
    got == expected

expect
    got = getPathsForDoor Activate [Zero, Two, Nine, Activate] [[]]
    expected = [
        [Left, Activate, Up, Activate, Up, Up, Right, Activate, Down, Down, Down, Activate],
        [Left, Activate, Up, Activate, Right, Up, Up, Activate, Down, Down, Down, Activate],
    ]
    got == expected

expect
    got = getPathsForRobot Activate [Left, Activate, Up, Activate, Right, Up, Up, Activate, Down, Down, Down, Activate] [[]]
    # v<<A>>^A<A>AvA<^AA>A<vAAA>^A
    expected = [
        Down,
        Left,
        Left,
        Activate,
        Right,
        Right,
        Up,
        Activate,
        Left,
        Activate,
        Right,
        Activate,
        Down,
        Activate,
        Left,
        Up,
        Activate,
        Activate,
        Right,
        Activate,
        Left,
        Down,
        Activate,
        Activate,
        Activate,
        Right,
        Up,
        Activate,
    ]
    got |> List.contains expected

expect
    got = variantsForNumbericKeypad Zero Seven
    expected = [[Up, Up, Up, Left, Activate]]
    got == expected

expect
    got = variantsForNumbericKeypad Six Four
    expected = [[Left, Left, Activate]]
    got == expected

expect
    got = variantsForNumbericKeypad Five Five
    expected = [[Activate]]
    got == expected

expect
    got = variantsForDirectionalKeypad Left Activate
    expected = [[Right, Right, Up, Activate], [Right, Up, Right, Activate]]
    got == expected

expect
    doorcode = [One, Seven, Nine, Activate]
    got = solve doorcode
    expected = 68 * 179
    got == expected

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
