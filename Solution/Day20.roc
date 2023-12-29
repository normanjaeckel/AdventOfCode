interface Solution.Day20
    exposes [
        part1,
        part2,
    ]
    imports [
        "Day20.input" as puzzleInput : Str,
        parser.String.{ parseStr, string, codeunitSatisfies },
        parser.Core.{ const, keep, skip, sepBy, oneOrMore, map, oneOf },
    ]

part1 =
    solvePart1 puzzleInput

solvePart1 = \input ->
    modules = input |> Str.trim |> parsePuzzleInput |> addParentsToConjuctions

    pushTheButton modules 1000
    |> (\finalState ->
        finalState.countLow * finalState.countHigh
    )
    |> Num.toStr

parsePuzzleInput = \input ->
    when parseStr puzzleParser input is
        Ok v -> v
        Err _ -> crash "parsing failed"

puzzleParser =
    lineParser |> sepBy (string "\n")

lineParser =
    const (\moduleType -> \destinations -> { moduleType, destinations })
    |> keep moduleParser
    |> skip (string " -> ")
    |> keep (moduleNameParser |> sepBy (string ", "))

moduleParser =
    oneOf [
        string "broadcaster" |> map (\_ -> Broadcaster),
        flipFlopModuleParser,
        conjuctionModuleParser,
    ]

flipFlopModuleParser =
    const (\name -> FlipFlop name Off)
    |> skip (string "%")
    |> keep moduleNameParser

conjuctionModuleParser =
    const (\name -> Conjuction name (Set.empty {}) (Set.empty {}))
    |> skip (string "&")
    |> keep moduleNameParser

moduleNameParser =
    fn = \char -> char >= 'a' && char <= 'z'

    oneOrMore (codeunitSatisfies fn)
    |> map
        (\res ->
            when Str.fromUtf8 res is
                Err _ -> crash "bad input"
                Ok r -> r
        )

addParentsToConjuctions = \modules ->
    parentsMap =
        modules
        |> List.walk
            (Dict.empty {})
            (\state, module ->
                name = module |> getName
                module.destinations
                |> List.walk
                    state
                    (\innerState, destination ->
                        innerState
                        |> Dict.update
                            destination
                            (\v ->
                                when v is
                                    Missing -> List.single name |> Present
                                    Present p -> p |> List.append name |> Present
                            )
                    )
            )

    modules
    |> List.map
        (\module ->
            when module.moduleType is
                Conjuction name _parents memory ->
                    newParents = parentsMap |> Dict.get name |> Result.withDefault [] |> Set.fromList
                    { module & moduleType: Conjuction name newParents memory }

                _ ->
                    module

        )

# addDebugModule = \modules ->
#     modules |> List.append { moduleType: FlipFlop "output" Off, destinations: [] }

pushTheButton = \modules, count ->
    List.repeat {} count
    |> List.walk
        { modules: modules, countLow: 0, countHigh: 0 }
        (\state, _ ->
            sendPulse state.modules [Low "broadcaster" "button"] state.countLow state.countHigh
        )

sendPulse = \modules, pulses, countLow, countHigh ->
    if List.isEmpty pulses then
        { modules, countLow, countHigh }
    else
        initialState = { modules, pulses: [], countLow, countHigh }

        pulses
        |> List.walk
            initialState
            (\state, pulse ->
                state |> processPulse pulse
            )
        |> (\finalState ->
            sendPulse finalState.modules finalState.pulses finalState.countLow finalState.countHigh
        )

processPulse = \state, pulse ->
    when pulse is
        Low target origin ->
            (module, idx) =
                when state.modules |> getModule target is
                    Ok v -> v
                    Err _ ->
                        ({ moduleType: Broadcaster, destinations: [] }, 0)

            when module.moduleType is
                Broadcaster ->
                    newPulses = module.destinations |> List.map (\d -> Low d "broadcaster")
                    { state & countLow: state.countLow + 1, pulses: state.pulses |> List.concat newPulses }

                FlipFlop name onOff ->
                    when onOff is
                        Off ->
                            newModules = state.modules |> List.update idx (\m -> { m & moduleType: FlipFlop name On })
                            newPulses = module.destinations |> List.map (\d -> High d name)
                            { state & modules: newModules, countLow: state.countLow + 1, pulses: state.pulses |> List.concat newPulses }

                        On ->
                            newModules = state.modules |> List.update idx (\m -> { m & moduleType: FlipFlop name Off })
                            newPulses = module.destinations |> List.map (\d -> Low d name)
                            { state & modules: newModules, countLow: state.countLow + 1, pulses: state.pulses |> List.concat newPulses }

                Conjuction name parents memory ->
                    newMemory = memory |> Set.remove origin
                    newModules = state.modules |> List.update idx (\m -> { m & moduleType: Conjuction name parents newMemory })
                    newPulses = module.destinations |> List.map (\d -> High d name)
                    { state & modules: newModules, countLow: state.countLow + 1, pulses: state.pulses |> List.concat newPulses }

        High target origin ->
            (module, idx) =
                when state.modules |> getModule target is
                    Ok v -> v
                    Err _ ->
                        ({ moduleType: Broadcaster, destinations: [] }, 0)

            when module.moduleType is
                Broadcaster ->
                    { state & countHigh: state.countHigh + 1 }

                FlipFlop _name _onOff ->
                    { state & countHigh: state.countHigh + 1 }

                Conjuction name parents memory ->
                    newMemory = memory |> Set.insert origin
                    newModules = state.modules |> List.update idx (\m -> { m & moduleType: Conjuction name parents newMemory })
                    newPulses =
                        if newMemory == parents then
                            module.destinations |> List.map (\d -> Low d name)
                        else
                            module.destinations |> List.map (\d -> High d name)
                    { state & modules: newModules, countHigh: state.countHigh + 1, pulses: state.pulses |> List.concat newPulses }

getModule = \modules, name ->
    modules
    |> List.findFirstIndex
        (\m1 ->
            when m1.moduleType is
                Broadcaster -> name == "broadcaster"
                FlipFlop n _ -> name == n
                Conjuction n _ _ -> name == n
        )
    |> Result.try
        (\idx ->
            module =
                when modules |> List.get idx is
                    Err _ -> crash "bad modules"
                    Ok m2 -> m2
            Ok (module, idx)
        )

getName = \module ->
    when module.moduleType is
        Broadcaster -> "broadcaster"
        FlipFlop name _ -> name
        Conjuction name _ _ -> name

exampleData1 =
    """
    broadcaster -> a, b, c
    %a -> b
    %b -> c
    %c -> inv
    &inv -> a
    """

expect
    got = solvePart1 exampleData1
    got == "32000000"

exampleData2 =
    """
    broadcaster -> a
    %a -> inv, con
    &inv -> b
    %b -> con
    &con -> output
    """

expect
    got = solvePart1 exampleData2
    got == "11687500"

part2 =
    solvePart2 puzzleInput

solvePart2 = \_input ->
    ""
