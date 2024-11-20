interface Solution.Day24
    exposes [
        part1,
        part2,
    ]
    imports [
        "Day24.input" as puzzleInput : Str,
        parser.String.{ parseStr, string, digits },
        parser.Core.{ const, keep, skip, sepBy, maybe, map },
    ]

part1 =
    solvePart1 puzzleInput (200_000_000_000_000, 400_000_000_000_000)

solvePart1 = \input, range ->
    hailstones = input |> Str.trim |> parsePuzzleInput
    getCrossings hailstones range 0
    |> Num.toStr

Hailstone : { x : I64, y : I64, z : I64, dx : I64, dy : I64, dz : I64 }
Range : (I64, I64)

parsePuzzleInput : Str -> List Hailstone
parsePuzzleInput = \input ->
    when parseStr puzzleParser input is
        Ok v -> v
        Err _ -> crash "parsing failed"

puzzleParser =
    lineParser |> sepBy (string "\n")

lineParser =
    const (\x -> \y -> \z -> \dx -> \dy -> \dz -> { x, y, z, dx, dy, dz })
    |> keep valueParser
    |> skip (string ", ")
    |> keep valueParser
    |> skip (string ", ")
    |> keep valueParser
    |> skip (string " @ ")
    |> keep valueParser
    |> skip (string ", ")
    |> keep valueParser
    |> skip (string ", ")
    |> keep valueParser

valueParser =
    const
        \negativ -> \number ->
                when negativ is
                    Err Nothing -> number
                    Ok _ -> -1 * number
    |> keep (maybe (string "-"))
    |> keep (digits |> map \n -> Num.toI64 n)

getCrossings : List Hailstone, Range, Nat -> Nat
getCrossings = \hailstones, range, result ->
    when hailstones is
        [] -> result
        [a, .. as rest] ->
            value = howManyCrossings a rest range
            getCrossings rest range (result + value)

howManyCrossings : Hailstone, List Hailstone, Range -> Nat
howManyCrossings = \hailstoneA, hailstones, inRange ->
    hailstones
    |> List.countIf
        (\hailstoneB -> hailstoneA |> isCrossing hailstoneB inRange)

isCrossing : Hailstone, Hailstone, Range -> Bool
isCrossing = \one, two, (low, high) ->
    # d1 = dy1 / dx1
    # d2 = dy2 / dx2
    d1 = Num.toFrac one.dy / Num.toFrac one.dx
    d2 = Num.toFrac two.dy / Num.toFrac two.dx
    if d1 == d2 then
        # Hailstones go parallel and never cross.
        Bool.false
    else
        c1 = (Num.toFrac one.y - d1 * Num.toFrac one.x)
        c2 = (Num.toFrac two.y - d2 * Num.toFrac two.x)

        # y = d1 * x + c1
        # y = d2 * x + c2
        # Subtraktion: d1 * x + c1 - d2 * x - c2 = 0
        # xd1 - xd2 + c1 -c2 = 0
        # x(d1 - d2) = c2 - c1
        # x = (c2 - c1)) / (d1 - d2)
        x = (c2 - c1) / (d1 - d2)
        y = d1 * x + c1
        if x < Num.toFrac low || x > Num.toFrac high || y < Num.toFrac low || y > Num.toFrac high then
            # Crossing is outside test area
            Bool.false
        else if (one.dx > 0 && x < Num.toFrac one.x) || (one.dx < 0 && x > Num.toFrac one.x) then
            # Crossing is in the past of hailstone one.
            Bool.false
        else if (two.dx > 0 && x < Num.toFrac two.x) || (two.dx < 0 && x > Num.toFrac two.x) then
            # Crossing is in the past of hailstone two.
            Bool.false
        else
            # Success
            Bool.true

exampleData1 =
    """
    19, 13, 30 @ -2, 1, -2
    18, 19, 22 @ -1, -1, -2
    20, 25, 34 @ -2, -2, -4
    12, 31, 28 @ -1, -2, -1
    20, 19, 15 @ 1, -5, -3
    """

expect
    got = solvePart1 exampleData1 (7, 27)
    got == "2"

part2 =
    solvePart2 puzzleInput

solvePart2 = \_input ->
    "Please look at the extra directory 'Day24'. Use --linker=legacy to avoid a compiler bug."
