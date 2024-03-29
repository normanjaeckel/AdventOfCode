interface Solution.Day19
    exposes [
        part1,
        part2,
    ]
    imports [
        "Day19.input" as puzzleInput : Str,
        parser.String.{ parseStr, string, scalar, codeunitSatisfies, digits },
        parser.Core.{ const, keep, sepBy, skip, map, oneOf, oneOrMore },
    ]

part1 =
    solvePart1 puzzleInput

solvePart1 = \input ->
    (workflows, parts) =
        input
        |> Str.trim
        |> Str.split "\n\n"
        |> parsePuzzleInput

    parts
    |> List.keepIf (\part -> part |> isAccepted workflows)
    |> List.map (\part -> part.x + part.m + part.a + part.s)
    |> List.sum
    |> Num.toStr

parsePuzzleInput = \input ->
    when input is
        [workflowInput, partsInput] ->
            when (parseStr (workflowParser |> sepBy (scalar '\n')) workflowInput, parseStr (partParser |> sepBy (scalar '\n')) partsInput) is
                (Ok workflows, Ok parts) -> (workflows, parts)
                _ -> crash "parsing failed"

        _ -> crash "bad input"

workflowParser =
    const (\name -> \instructions -> { name, instructions })
    |> keep workflowName
    |> skip (string "{")
    |> keep (instructionParser |> sepBy (string ","))
    |> skip (string "}")

workflowName =
    fn = \char -> char >= 'a' && char <= 'z'

    oneOrMore (codeunitSatisfies fn)
    |> map
        (\res ->
            when Str.fromUtf8 res is
                Err _ -> crash "bad input"
                Ok r -> r
        )

instructionParser =
    oneOf [
        instructionWithCondition |> map (\i -> Condition i),
        defaultInstructionParser |> map (\j -> Step j),
    ]

instructionWithCondition =
    const (\category -> \relation -> \num -> \ifTruthy -> { category, relation, num, ifTruthy })
    |> keep
        (
            oneOf [
                string "x" |> map (\_ -> X),
                string "m" |> map (\_ -> M),
                string "a" |> map (\_ -> A),
                string "s" |> map (\_ -> S),
            ]
        )
    |> keep
        (
            oneOf [
                string "<" |> map (\_ -> LessThen),
                string ">" |> map (\_ -> GreaterThen),
            ]
        )
    |> keep digits
    |> skip (string ":")
    |> keep defaultInstructionParser

defaultInstructionParser =
    oneOf [
        string "A" |> map (\_ -> Accept),
        string "R" |> map (\_ -> Reject),
        workflowName |> map (\name -> Instruction name),
    ]

partParser =
    const (\x -> \m -> \a -> \s -> { x, m, a, s })
    |> skip (string "{x=")
    |> keep digits
    |> skip (string ",")
    |> skip (string "m=")
    |> keep digits
    |> skip (string ",")
    |> skip (string "a=")
    |> keep digits
    |> skip (string ",")
    |> skip (string "s=")
    |> keep digits
    |> skip (scalar '}')

isAccepted = \part, workflows ->
    walkWorkflow workflows part "in"

walkWorkflow = \workflows, part, name ->
    workflow =
        when workflows |> List.findFirst (\w -> w.name == name) is
            Err _ -> crash "workflow not found"
            Ok w -> w

    workflow.instructions
    |> List.walkUntil
        Undefined
        (\_, instruction ->
            when instruction is
                Step s ->
                    when s is
                        Accept -> Break (FinallyAccepted)
                        Reject -> Break (FinallyRejected)
                        Instruction i -> Break (Goto i)

                Condition c ->
                    when evalCondition c part is
                        Ok v ->
                            when v is
                                Accept -> Break (FinallyAccepted)
                                Reject -> Break (FinallyRejected)
                                Instruction i -> Break (Goto i)

                        Err _ ->
                            Continue Undefined
        )
    |> (\res ->
        when res is
            Undefined ->
                crash "undefined workflow state"

            FinallyAccepted ->
                Bool.true

            FinallyRejected ->
                Bool.false

            Goto next ->
                walkWorkflow workflows part next
    )

evalCondition = \{ category, relation, num, ifTruthy }, part ->
    res =
        when relation is
            LessThen ->
                when category is
                    X -> part.x < num
                    M -> part.m < num
                    A -> part.a < num
                    S -> part.s < num

            GreaterThen ->
                when category is
                    X -> part.x > num
                    M -> part.m > num
                    A -> part.a > num
                    S -> part.s > num

    if res then
        Ok ifTruthy
    else
        Err "condition does not match"

exampleData1 =
    """
    px{a<2006:qkq,m>2090:A,rfg}
    pv{a>1716:R,A}
    lnx{m>1548:A,A}
    rfg{s<537:gd,x>2440:R,A}
    qs{s>3448:A,lnx}
    qkq{x<1416:A,crn}
    crn{x>2662:A,R}
    in{s<1351:px,qqz}
    qqz{s>2770:qs,m<1801:hdj,R}
    gd{a>3333:R,R}
    hdj{m>838:A,pv}

    {x=787,m=2655,a=1222,s=2876}
    {x=1679,m=44,a=2067,s=496}
    {x=2036,m=264,a=79,s=2244}
    {x=2461,m=1339,a=466,s=291}
    {x=2127,m=1623,a=2188,s=1013}
    """

expect
    got = solvePart1 exampleData1
    got == "19114"

part2 =
    solvePart2 puzzleInput

solvePart2 = \input ->
    (workflows, _) =
        input
        |> Str.trim
        |> Str.split "\n\n"
        |> parsePuzzleInput

    startPart = { x: (1, 4000), m: (1, 4000), a: (1, 4000), s: (1, 4000), goto: "in" }
    walkWorkflow2 workflows [startPart] []
    |> List.map
        (\part ->
            (x1, x2) = part.x
            (m1, m2) = part.m
            (a1, a2) = part.a
            (s1, s2) = part.s
            (x2 - x1 + 1) * (m2 - m1 + 1) * (a2 - a1 + 1) * (s2 - s1 + 1)
        )
    |> List.sum
    |> Num.toStr

walkWorkflow2 = \workflows, parts, currentResult ->
    if List.isEmpty parts then
        currentResult
    else
        initialState = { newParts: [], newResult: currentResult }
        parts
        |> List.walk
            initialState
            (\state, currentPart ->
                workflow =
                    when workflows |> List.findFirst (\w -> w.name == currentPart.goto) is
                        Err _ -> crash "workflow not found"
                        Ok w -> w

                state |> processPart workflow currentPart
            )
        |> (\finalState ->
            walkWorkflow2 workflows finalState.newParts finalState.newResult
        )

processPart = \outerState, workflow, currentPart ->
    initialState = { inPipe: Ok currentPart, gotoAnotherWorkflow: [], accepted: [] }
    workflow.instructions
    |> List.walkUntil
        initialState
        (\state, instruction ->
            newState = state |> processInstruction instruction
            when newState.inPipe is
                Ok _ -> Continue newState
                Err _ -> Break newState
        )
    |> (\finalState -> {
        newParts: outerState.newParts |> List.concat finalState.gotoAnotherWorkflow,
        newResult: outerState.newResult |> List.concat finalState.accepted,
    }
    )

processInstruction = \state, instruction ->
    currentPart =
        when state.inPipe is
            Ok p -> p
            Err _ -> crash "nothing left here"

    when instruction is
        Step s ->
            when s is
                Accept ->
                    { state & inPipe: Err Nothing, accepted: state.accepted |> List.append currentPart }

                Reject ->
                    { state & inPipe: Err Nothing }

                Instruction name ->
                    { state & inPipe: Err Nothing, gotoAnotherWorkflow: state.gotoAnotherWorkflow |> List.append { currentPart & goto: name } }

        Condition c ->
            state |> processCondition c currentPart

processCondition = \state, { category, relation, num, ifTruthy }, currentPart ->
    (i, j) =
        when category is
            X -> currentPart.x
            M -> currentPart.m
            A -> currentPart.a
            S -> currentPart.s

    when relation is
        LessThen ->
            if num <= i then
                # currentPart stays in pipe
                state
            else if j < num then
                # currentPart is completly consumed by the condition, pipe is empty now
                when ifTruthy is
                    Accept ->
                        { state & inPipe: Err Nothing, accepted: state.accepted |> List.append currentPart }

                    Reject ->
                        { state & inPipe: Err Nothing }

                    Instruction name ->
                        { state & inPipe: Err Nothing, gotoAnotherWorkflow: state.gotoAnotherWorkflow |> List.append { currentPart & goto: name } }
            else
                # currentPart has to be split up: first part is consumed by the condition, the rest stays in pipe
                (left, right) = splitUpPart currentPart num category

                when ifTruthy is
                    Accept ->
                        { state & inPipe: Ok right, accepted: state.accepted |> List.append left }

                    Reject ->
                        { state & inPipe: Ok right }

                    Instruction name ->
                        { state & inPipe: Ok right, gotoAnotherWorkflow: state.gotoAnotherWorkflow |> List.append { left & goto: name } }

        GreaterThen ->
            if num >= j then
                # currentPart stays in pipe
                state
            else if i > num then
                # currentPart is completly consumed by the condition, pipe is empty now
                when ifTruthy is
                    Accept ->
                        { state & inPipe: Err Nothing, accepted: state.accepted |> List.append currentPart }

                    Reject ->
                        { state & inPipe: Err Nothing }

                    Instruction name ->
                        { state & inPipe: Err Nothing, gotoAnotherWorkflow: state.gotoAnotherWorkflow |> List.append { currentPart & goto: name } }
            else
                # currentPart has to be split up: first part is consumed by the condition, the rest stays in pipe
                (left, right) = splitUpPart currentPart (num + 1) category

                when ifTruthy is
                    Accept ->
                        { state & inPipe: Ok left, accepted: state.accepted |> List.append right }

                    Reject ->
                        { state & inPipe: Ok left }

                    Instruction name ->
                        { state & inPipe: Ok left, gotoAnotherWorkflow: state.gotoAnotherWorkflow |> List.append { right & goto: name } }

splitUpPart = \part, num, category ->
    when category is
        X ->
            (i, j) = part.x
            ({ part & x: (i, num - 1) }, { part & x: (num, j) })

        M ->
            (i, j) = part.m
            ({ part & m: (i, num - 1) }, { part & m: (num, j) })

        A ->
            (i, j) = part.a
            ({ part & a: (i, num - 1) }, { part & a: (num, j) })

        S ->
            (i, j) = part.s
            ({ part & s: (i, num - 1) }, { part & s: (num, j) })

expect
    got = splitUpPart { x: (1, 4000), m: (1, 4000), a: (1, 4000), s: (1, 4000), goto: "in" } 5 X
    got
    == (
        { x: (1, 4), m: (1, 4000), a: (1, 4000), s: (1, 4000), goto: "in" },
        { x: (5, 4000), m: (1, 4000), a: (1, 4000), s: (1, 4000), goto: "in" },
    )

exampleData2 =
    exampleData1

expect
    got = solvePart2 exampleData2
    got == "167409079868000"
