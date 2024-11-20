interface Solution.Day22
    exposes [
        part1,
        part2,
    ]
    imports [
        "Day22.input" as puzzleInput : Str,
        parser.String.{ parseStr, string, digits },
        parser.Core.{ const, keep, skip, sepBy },
    ]

part1 =
    solvePart1 puzzleInput

solvePart1 = \input ->
    sand =
        input
        |> Str.trim
        |> parsePuzzleInput
        |> processBricks
        |> letThemFall
        |> calcSupport

    supportOthers = sand.supportedBy |> transformSupport

    safelyDisintegrate sand.supportedBy supportOthers (List.len sand.bricks)
    |> List.len
    |> Num.toStr

BrickRaw : { startX : Nat, startY : Nat, startZ : Nat, endX : Nat, endY : Nat, endZ : Nat }
Brick : List (Nat, Nat, Nat)

SupportedBy : Dict Nat (Set Nat) # Keys an values are indexes of bricks. A brick with the index k supports all bricks in the value list.
SupportOthers : Dict Nat (Set Nat) # See SupportedBy but vice versa.

parsePuzzleInput : Str -> List BrickRaw
parsePuzzleInput = \input ->
    when parseStr puzzleParser input is
        Ok v -> v
        Err _ -> crash "parsing failed"

puzzleParser =
    brickParser |> sepBy (string "\n")

brickParser =
    const (\startX -> \startY -> \startZ -> \endX -> \endY -> \endZ -> { startX, startY, startZ, endX, endY, endZ })
    |> keep digits
    |> skip (string ",")
    |> keep digits
    |> skip (string ",")
    |> keep digits
    |> skip (string "~")
    |> keep digits
    |> skip (string ",")
    |> keep digits
    |> skip (string ",")
    |> keep digits

processBricks : List BrickRaw -> List Brick
processBricks = \bricks ->
    bricks
    |> List.sortWith \brick1, brick2 -> Num.compare brick1.startZ brick2.startZ
    |> List.map
        \{ startX, startY, startZ, endX, endY, endZ } ->
            if startX != endX then
                List.range { start: At startX, end: At endX } |> List.map (\x -> (x, startY, startZ))
            else if startY != endY then
                List.range { start: At startY, end: At endY } |> List.map (\y -> (startX, y, startZ))
            else if startZ != endZ then
                List.range { start: At startZ, end: At endZ } |> List.map (\z -> (startX, startY, z))
            else
                List.single (startX, startY, startZ)

letThemFall : List Brick -> List Brick
letThemFall = \givenBricks ->
    initialState = {
        bricks: List.withCapacity (List.len givenBricks),
        ground: Dict.empty {},
    }

    givenBricks
    |> List.walk
        initialState
        \state, brick ->
            brick
            |> List.map
                \(x, y, z) ->
                    groundLevel = state.ground |> Dict.get (x, y) |> Result.withDefault 0
                    z - groundLevel - 1
            |> List.min
            |> Result.withDefault 0
            |> (\canFall ->
                brick |> List.map \(x, y, z) -> (x, y, z - canFall)
            )
            |> \newBrick ->
                newBricks = state.bricks |> List.append newBrick
                newGround =
                    newBrick
                    |> List.walk
                        state.ground
                        \groundState, (x, y, z) ->
                            groundState |> Dict.insert (x, y) z

                { bricks: newBricks, ground: newGround }
    |> \finalState ->
        finalState.bricks

calcSupport : List Brick -> { bricks : List Brick, supportedBy : SupportedBy }
calcSupport = \givenBricks ->
    initialState = {
        support: Dict.empty {},
        supportedBy: Dict.empty {},
    }

    givenBricks
    |> List.walkWithIndex
        initialState
        \state, brick, index ->
            brick
            |> List.walk
                state
                \innerState, (x, y, z) ->
                    newSupport = innerState.support |> Dict.insert (x, y, z) index
                    newSupportedBy =
                        when innerState.support |> Dict.get (x, y, z - 1) is
                            Err KeyNotFound ->
                                innerState.supportedBy

                            Ok v ->
                                if v == index then
                                    innerState.supportedBy
                                else
                                    innerState.supportedBy
                                    |> Dict.update
                                        index
                                        \old ->
                                            when old is
                                                Missing -> Set.single v |> Present
                                                Present s -> s |> Set.insert v |> Present

                    { support: newSupport, supportedBy: newSupportedBy }
    |> \{ supportedBy } ->
        { bricks: givenBricks, supportedBy: supportedBy }

transformSupport : SupportedBy -> SupportOthers
transformSupport = \supportedBy ->
    supportedBy
    |> Dict.walk
        (Dict.empty {})
        \state, k, supporters ->
            supporters
            |> Set.walk
                state
                \innerState, supporter ->
                    innerState
                    |> Dict.update
                        supporter
                        \old ->
                            when old is
                                Missing -> Set.single k |> Present
                                Present s -> s |> Set.insert k |> Present

safelyDisintegrate : SupportedBy, SupportOthers, Nat -> List Nat
safelyDisintegrate = \supportedBy, supportOthers, count ->
    List.range { start: At 0, end: Length count }
    |> List.walk
        []
        \state, index ->
            when supportOthers |> Dict.get index is
                Err KeyNotFound ->
                    state |> List.append index

                Ok others ->
                    good =
                        others
                        |> Set.toList
                        |> List.all
                            \other ->
                                when supportedBy |> Dict.get other is
                                    Err KeyNotFound -> crash "bad support state, brick supports another brick but this other brick is not supported"
                                    Ok supporters ->
                                        Set.len supporters > 1
                    if good then
                        state |> List.append index
                    else
                        state

exampleData1 =
    """
    1,0,1~1,2,1
    0,0,2~2,0,2
    0,2,3~2,2,3
    0,0,4~0,2,4
    2,0,5~2,2,5
    0,1,6~2,1,6
    1,1,8~1,1,9
    """

expect
    got = solvePart1 exampleData1
    got == "5"

part2 =
    solvePart2 puzzleInput

solvePart2 = \input ->
    sand =
        input
        |> Str.trim
        |> parsePuzzleInput
        |> processBricks
        |> letThemFall
        |> calcSupport

    supportOthers = sand.supportedBy |> transformSupport

    sand.bricks
    |> List.mapWithIndex
        \_brick, index -> countIfDisintegrate sand.supportedBy supportOthers index (Set.empty {})
    |> List.map (\s -> Set.len s - 1)
    |> List.sum
    |> Num.toStr

countIfDisintegrate : SupportedBy, SupportOthers, Nat, Set Nat -> Set Nat
countIfDisintegrate = \supportedBy, supportOthers, index, alreadyRemoved ->
    newAlreadyRemoved = alreadyRemoved |> Set.insert index

    when supportOthers |> Dict.get index is
        Err KeyNotFound -> newAlreadyRemoved
        Ok others ->
            others
            |> Set.walk
                newAlreadyRemoved
                \state, other ->
                    supporters =
                        when supportedBy |> Dict.get other is
                            Err KeyNotFound -> Set.empty {}
                            Ok s -> s
                    if Set.difference supporters state |> Set.isEmpty then
                        countIfDisintegrate supportedBy supportOthers other state
                    else
                        state

exampleData2 =
    exampleData1

expect
    got = solvePart2 exampleData2
    got == "7"
