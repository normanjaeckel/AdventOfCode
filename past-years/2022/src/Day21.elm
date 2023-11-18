module Day21 exposing (run)

import Dict
import Parser exposing ((|.), (|=))


run : String -> ( String, String )
run puzzleInput =
    ( runPartA puzzleInput, runPartB puzzleInput )


runPartA : String -> String
runPartA puzzleInput =
    case puzzleInput |> Parser.run puzzleParser of
        Ok exps ->
            case resolve { common = exps, reverse = Dict.empty } AfterRoot "root" of
                Just result ->
                    String.fromFloat result

                Nothing ->
                    "No result A"

        Err _ ->
            "Error"


runPartB : String -> String
runPartB puzzleInput =
    case puzzleInput |> Parser.run puzzleParser of
        Ok exps ->
            let
                filteredExps : Dict.Dict Operand Expression
                filteredExps =
                    exps |> Dict.remove "humn"
            in
            case resolve { common = filteredExps, reverse = transform filteredExps } BeforeRoot "humn" of
                Just result ->
                    String.fromFloat result

                Nothing ->
                    "No result B"

        Err _ ->
            "Error"


type alias Operand =
    String


type Expression
    = Value Float
    | Equation Equation


type Equation
    = Addition Operand Operand LeftSideBeforeTranformation
    | Subtraction Operand Operand LeftSideBeforeTranformation
    | Multiplication Operand Operand LeftSideBeforeTranformation
    | Division Operand Operand LeftSideBeforeTranformation
    | Equal Operand


type Operator
    = Plus
    | Minus
    | Times
    | By


type alias LeftSideBeforeTranformation =
    Operand



-- Parser


puzzleParser : Parser.Parser (Dict.Dict Operand Expression)
puzzleParser =
    Parser.loop Dict.empty
        (\exps ->
            Parser.oneOf
                [ expressionParser |> Parser.map (\( op, exp ) -> exps |> Dict.insert op exp |> Parser.Loop)
                , (Parser.succeed () |. Parser.end) |> Parser.map (\_ -> Parser.Done exps)
                ]
        )


expressionParser : Parser.Parser ( Operand, Expression )
expressionParser =
    Parser.oneOf
        [ (Parser.succeed
            (\op a operator b ->
                case operator of
                    Plus ->
                        ( op, Addition a b "" )

                    Minus ->
                        ( op, Subtraction a b "" )

                    Times ->
                        ( op, Multiplication a b "" )

                    By ->
                        ( op, Division a b "" )
            )
            |= operandParser
            |. Parser.symbol ":"
            |. Parser.spaces
            |= operandParser
            |. Parser.spaces
            |= operatorParser
            |. Parser.spaces
            |= operandParser
            |. Parser.spaces
          )
            |> Parser.map (\( op, eq ) -> ( op, Equation eq ))
            |> Parser.backtrackable
        , (Parser.succeed (\op value -> ( op, Value value ))
            |= operandParser
            |. Parser.symbol ":"
            |. Parser.spaces
            |= Parser.float
            |. Parser.spaces
          )
            |> Parser.backtrackable
        ]


operandParser : Parser.Parser Operand
operandParser =
    Parser.getChompedString <|
        Parser.succeed ()
            |. Parser.chompIf (\c -> Char.isLower c)
            |. Parser.chompIf (\c -> Char.isLower c)
            |. Parser.chompIf (\c -> Char.isLower c)
            |. Parser.chompIf (\c -> Char.isLower c)


operatorParser : Parser.Parser Operator
operatorParser =
    Parser.oneOf
        [ Parser.succeed Plus |. Parser.symbol "+"
        , Parser.succeed Minus |. Parser.symbol "-"
        , Parser.succeed Times |. Parser.symbol "*"
        , Parser.succeed By |. Parser.symbol "/"
        ]



-- Caluclate


type Phase
    = BeforeRoot
    | AfterRoot


type alias AllExpressions =
    { common : Dict.Dict Operand Expression
    , reverse : Dict.Dict Operand Expression
    }


resolve : AllExpressions -> Phase -> Operand -> Maybe Float
resolve all phase operand =
    let
        mexp : Maybe Expression
        mexp =
            case phase of
                BeforeRoot ->
                    all.reverse |> Dict.get operand

                AfterRoot ->
                    all.common |> Dict.get operand
    in
    mexp
        |> Maybe.andThen
            (\exp ->
                case exp of
                    Value v ->
                        Just v

                    Equation eq ->
                        let
                            newPhase : Operand -> LeftSideBeforeTranformation -> Phase
                            newPhase op l =
                                if phase == AfterRoot || op /= l then
                                    AfterRoot

                                else
                                    BeforeRoot
                        in
                        case eq of
                            Addition a b l ->
                                exec (+)
                                    (resolve all (newPhase a l) a)
                                    (resolve all (newPhase b l) b)

                            Subtraction a b l ->
                                exec (-)
                                    (resolve all (newPhase a l) a)
                                    (resolve all (newPhase b l) b)

                            Multiplication a b l ->
                                exec (*)
                                    (resolve all (newPhase a l) a)
                                    (resolve all (newPhase b l) b)

                            Division a b l ->
                                exec (/)
                                    (resolve all (newPhase a l) a)
                                    (resolve all (newPhase b l) b)

                            Equal a ->
                                resolve all AfterRoot a
            )


exec : (Float -> Float -> Float) -> Maybe Float -> Maybe Float -> Maybe Float
exec fn mba mbb =
    mba |> Maybe.andThen (\a -> mbb |> Maybe.andThen (\b -> Just <| fn a b))


transform : Dict.Dict Operand Expression -> Dict.Dict Operand Expression
transform exps =
    let
        fn : Operand -> Expression -> Dict.Dict Operand Expression -> Dict.Dict Operand Expression
        fn op exp newExps =
            case exp of
                Value v ->
                    newExps |> Dict.insert op (Value v)

                Equation eq ->
                    case eq of
                        Addition a b _ ->
                            if op == "root" then
                                -- We know that root is an Addition case
                                newExps
                                    |> Dict.insert a (Equation <| Equal b)
                                    |> Dict.insert b (Equation <| Equal a)

                            else
                                -- op = a + b leads to a = op - b and b = op - a
                                newExps
                                    |> dictInsertIfNotExists a (Equation <| Subtraction op b op)
                                    |> dictInsertIfNotExists b (Equation <| Subtraction op a op)

                        Subtraction a b _ ->
                            -- op = a - b leads to a = op + b and b = a - op
                            newExps
                                |> dictInsertIfNotExists a (Equation <| Addition op b op)
                                |> dictInsertIfNotExists b (Equation <| Subtraction a op op)

                        Multiplication a b _ ->
                            -- op = a * b leads to a = op / b and b = op / a
                            newExps
                                |> dictInsertIfNotExists a (Equation <| Division op b op)
                                |> dictInsertIfNotExists b (Equation <| Division op a op)

                        Division a b _ ->
                            -- op = a / b leads to a = op * b and b = a / op
                            newExps
                                |> dictInsertIfNotExists a (Equation <| Multiplication op b op)
                                |> dictInsertIfNotExists b (Equation <| Division a op op)

                        Equal _ ->
                            newExps
    in
    exps |> Dict.foldl fn Dict.empty


dictInsertIfNotExists : comparable -> v -> Dict.Dict comparable v -> Dict.Dict comparable v
dictInsertIfNotExists k v d =
    if d |> Dict.member k then
        d

    else
        d |> Dict.insert k v
