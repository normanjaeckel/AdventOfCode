module Day11 exposing (run)

import Dict
import Parser exposing ((|.), (|=), DeadEnd)


run : String -> ( String, String )
run puzzleInput =
    ( runPuzzle puzzleInput 20 (PuzzlePartA 3), runPuzzle puzzleInput 10000 PuzzlePartB )


type PuzzlePart
    = PuzzlePartA Int
    | PuzzlePartB


runPuzzle : String -> Int -> PuzzlePart -> String
runPuzzle puzzleInput rounds puzzlePart =
    case puzzleInput |> parseInput of
        Ok monkeys ->
            monkeys
                |> playRounds rounds puzzlePart
                |> productOfInspectionOfMostActiveMonkeys
                |> String.fromInt

        Err _ ->
            "Error while parsing"



-- PARSE INPUT


type alias Monkeys =
    Dict.Dict MonkeyID Monkey


type alias MonkeyID =
    Int


type alias Monkey =
    { items : List Int
    , operation : Operation
    , testDiv : Int
    , targetIfTrue : MonkeyID
    , targetIfFalse : MonkeyID
    , hasInspected : Int
    }


fakeMonkey : Monkey
fakeMonkey =
    Monkey [] (Addition Self Self) 0 0 0 0


type Operation
    = Addition Operand Operand
    | Multiplication Operand Operand


type Operand
    = Self
    | Const Int


parseInput : String -> Result (List DeadEnd) Monkeys
parseInput input =
    let
        fn : String -> Result (List DeadEnd) Monkeys -> Result (List DeadEnd) Monkeys
        fn part monkeys =
            let
                result : Result (List DeadEnd) ( MonkeyID, Monkey )
                result =
                    part |> parseInputPart
            in
            result |> Result.map2 (\innerMonkeys ( monkeyId, monkey ) -> innerMonkeys |> Dict.insert monkeyId monkey) monkeys
    in
    input
        |> String.split "\n\n"
        |> List.foldl fn (Just Dict.empty |> Result.fromMaybe [])


parseInputPart : String -> Result (List DeadEnd) ( MonkeyID, Monkey )
parseInputPart input =
    input |> Parser.run monkeyParser


monkeyParser : Parser.Parser ( MonkeyID, Monkey )
monkeyParser =
    Parser.succeed
        (\monkeyId items operation testDiv targetIfTrue targetIfFalse ->
            ( monkeyId
            , { items = items
              , operation = operation
              , testDiv = testDiv
              , targetIfTrue = targetIfTrue
              , targetIfFalse = targetIfFalse
              , hasInspected = 0
              }
            )
        )
        |. Parser.token "Monkey"
        |. Parser.spaces
        |= Parser.int
        |. Parser.token ":"
        |. Parser.spaces
        |. Parser.token "Starting items:"
        |. Parser.spaces
        |= parseItemList
        |. Parser.spaces
        |. Parser.token "Operation: new ="
        |. Parser.spaces
        |= parseOperation
        |. Parser.spaces
        |. Parser.token "Test: divisible by"
        |. Parser.spaces
        |= Parser.int
        |. Parser.spaces
        |. Parser.token "If true: throw to monkey"
        |. Parser.spaces
        |= Parser.int
        |. Parser.spaces
        |. Parser.token "If false: throw to monkey"
        |. Parser.spaces
        |= Parser.int


parseItemList : Parser.Parser (List Int)
parseItemList =
    Parser.sequence
        { start = ""
        , separator = ","
        , end = ""
        , spaces = Parser.spaces
        , item = Parser.int
        , trailing = Parser.Forbidden
        }


parseOperation : Parser.Parser Operation
parseOperation =
    Parser.succeed (\op1 opn op2 -> opn op1 op2)
        |= Parser.oneOf
            [ Parser.succeed Self |. Parser.token "old"
            , Parser.succeed Const |= Parser.int
            ]
        |. Parser.spaces
        |= Parser.oneOf
            [ Parser.succeed Addition |. Parser.token "+"
            , Parser.succeed Multiplication |. Parser.token "*"
            ]
        |. Parser.spaces
        |= Parser.oneOf
            [ Parser.succeed Self |. Parser.token "old"
            , Parser.succeed Const |= Parser.int
            ]



-- Playing


playRounds : Int -> PuzzlePart -> Monkeys -> Monkeys
playRounds count puzzlePart monkeys =
    List.repeat count () |> List.foldl (playRound puzzlePart) monkeys


playRound : PuzzlePart -> () -> Monkeys -> Monkeys
playRound puzzlePart _ monkeys =
    let
        oskarHelpMeHere : Int -> Int
        oskarHelpMeHere item =
            case puzzlePart of
                PuzzlePartA i ->
                    item // i

                PuzzlePartB ->
                    item |> modBy (monkeys |> Dict.values |> List.map .testDiv |> List.foldl (\a b -> a * b) 1)

        fn1 : MonkeyID -> Monkeys -> Monkeys
        fn1 monkeyId all =
            let
                monkey : Monkey
                monkey =
                    all |> Dict.get monkeyId |> Maybe.withDefault fakeMonkey
            in
            monkey.items
                |> List.foldl (fn2 monkey) all
                |> Dict.insert monkeyId { monkey | items = [], hasInspected = monkey.hasInspected + List.length monkey.items }

        fn2 : Monkey -> Int -> Monkeys -> Monkeys
        fn2 monkey item all =
            let
                newItem =
                    (item |> processOperation monkey.operation) |> oskarHelpMeHere
            in
            if newItem |> runDivTest monkey.testDiv then
                newItem |> throwToMonkey monkey.targetIfTrue all

            else
                newItem |> throwToMonkey monkey.targetIfFalse all
    in
    monkeys |> Dict.keys |> List.foldl fn1 monkeys


processOperation : Operation -> Int -> Int
processOperation operation item =
    case operation of
        Addition op1 op2 ->
            getOperand op1 item + getOperand op2 item

        Multiplication op1 op2 ->
            getOperand op1 item * getOperand op2 item


getOperand : Operand -> Int -> Int
getOperand op item =
    case op of
        Self ->
            item

        Const c ->
            c


runDivTest : Int -> Int -> Bool
runDivTest divy item =
    (item |> modBy divy) == 0


throwToMonkey : MonkeyID -> Monkeys -> Int -> Monkeys
throwToMonkey monkeyId monkeys item =
    let
        m : Maybe Monkey
        m =
            monkeys |> Dict.get monkeyId
    in
    case m of
        Nothing ->
            monkeys

        Just mon ->
            monkeys |> Dict.insert monkeyId { mon | items = mon.items ++ [ item ] }


productOfInspectionOfMostActiveMonkeys : Monkeys -> Int
productOfInspectionOfMostActiveMonkeys monkeys =
    monkeys
        |> Dict.values
        |> List.map .hasInspected
        |> List.sort
        |> List.reverse
        |> List.take 2
        |> List.foldl (\a b -> a * b) 1
