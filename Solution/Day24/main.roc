app "advent-of-code-2023"
    packages {
        pf: "https://github.com/roc-lang/basic-cli/releases/download/0.7.1/Icc3xJoIixF3hCcfXrDwLCu4wQHtNdPyoJkEbkgIElA.tar.br",
        parser: "https://github.com/lukewilliamboswell/roc-parser/releases/download/0.3.0/-e3ebWWmlFPfe9fYrr2z1urfslzygbtQQsl69iH1qzQ.tar.br",
    }
    imports [
        "Day24.input" as puzzleInput : Str,
        pf.Stdout,
        pf.Task,
        parser.String.{ parseStr, string, digits },
        parser.Core.{ const, keep, skip, maybe, map, sepBy },
    ]
    provides [main] to pf

main =
    _ <- Stdout.line "Solution for part 1: \(part1)" |> Task.await
    Stdout.line "Solution for part 2: \(part2)"

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

part2 = solvePart2 puzzleInput

Dimension : [X, Y, Z]

solvePart2 = \input ->
    hailstones = input |> Str.trim |> parsePuzzleInput

    rockDxList = getPairsOfHailstonesWithSameVelocity hailstones X |> guessRocksVelocity X (List.range { start: At -5000, end: Length 10000 })
    rockDyList = getPairsOfHailstonesWithSameVelocity hailstones Y |> guessRocksVelocity Y (List.range { start: At -5000, end: Length 10000 })
    rockDzList = getPairsOfHailstonesWithSameVelocity hailstones Z |> guessRocksVelocity Z (List.range { start: At -5000, end: Length 10000 })

    (rockDx, rockDy, rockDz) =
        when (rockDxList, rockDyList, rockDzList) is
            ([x], [y], [z]) -> (x, y, z)
            _ -> crash "rock's velocity not found"

    result =
        when hailstones is
            [_, _, a, b, ..] -> calcResult a b rockDx rockDy rockDz
            _ -> crash "impossible"

    Str.concat (result |> Num.toStr) "  # You have to strip off the decimals manually."

getPairsOfHailstonesWithSameVelocity : List Hailstone, Dimension -> List (Hailstone, Hailstone)
getPairsOfHailstonesWithSameVelocity = \hailstones, dimension ->
    getPairsHelper hailstones dimension []

getPairsHelper = \hailstones, dimension, result ->
    when hailstones is
        [] -> result
        [a, .. as rest] ->
            newResult =
                when getPairsFor dimension a rest is
                    Err NotFound -> result
                    Ok found -> result |> List.append (a, found)
            getPairsHelper rest dimension newResult

getPairsFor = \dimension, hailstoneA, hailstones ->
    hailstones
    |> List.findFirst
        \hailstoneB ->
            when dimension is
                X -> hailstoneA.dx == hailstoneB.dx
                Y -> hailstoneA.dy == hailstoneB.dy
                Z -> hailstoneA.dz == hailstoneB.dz

guessRocksVelocity = \pairs, dimension, range ->
    when pairs is
        [] -> range
        [(one, two), .. as rest] ->
            (distance, velocity) =
                when dimension is
                    X -> (one.x - two.x, one.dx)
                    Y -> (one.y - two.y, one.dy)
                    Z -> (one.z - two.z, one.dz)
            newRange = range |> List.keepIf \i -> distance |> Num.isMultipleOf (i - velocity)
            if List.len newRange == 1 then
                newRange
            else
                guessRocksVelocity rest dimension newRange

calcResult = \hailstoneA, hailstoneB, rockDx, rockDy, rockDz ->
    # We have four equations:

    # rockX + timeA * rockDx = hailstoneA.x + timeA * hailstoneA.dx
    # rockX = hailstoneA.x + timeA * hailstoneA.dx - timeA * rockDx

    # rockX + timeB * rockDx = hailstoneB.x + timeB * hailstoneB.dx
    # rockX = hailstoneB.x + timeB * hailstoneB.dx - timeB * rockDx

    # rockY + timeA * rockDy = hailstoneA.y + timeA * hailstoneA.dy
    # rockY = hailstoneA.y + timeA * hailstoneA.dy - timeA * rockDy

    # rockY + timeB * rockDy = hailstoneB.y + timeB * hailstoneB.dy
    # rockY = hailstoneB.y + timeB * hailstoneB.dy - timeB * rockDy

    # Put them together:

    # hailstoneA.x + timeA * hailstoneA.dx - timeA * rockDx = hailstoneB.x + timeB * hailstoneB.dx - timeB * rockDx
    # hailstoneA.y + timeA * hailstoneA.dy - timeA * rockDy = hailstoneB.y + timeB * hailstoneB.dy - timeB * rockDy

    # Transform them:

    # hailstoneA.x + timeA * (hailstoneA.dx - rockDx) = hailstoneB.x + timeB * (hailstoneB.dx - rockDx)
    # hailstoneA.y + timeA * (hailstoneA.dy - rockDy) = hailstoneB.y + timeB * (hailstoneB.dy - rockDy)

    ax = hailstoneA.dx - rockDx |> Num.toFrac
    ay = hailstoneA.dy - rockDy |> Num.toFrac
    bx = hailstoneB.dx - rockDx |> Num.toFrac
    by = hailstoneB.dy - rockDy |> Num.toFrac

    # hailstoneA.x + timeA * ax = hailstoneB.x + timeB * bx
    # hailstoneA.y + timeA * ay = hailstoneB.y + timeB * by

    # Multiply second equation with
    # k = ax / ay

    # hailstoneA.x + timeA * ax = hailstoneB.x + timeB * bx
    # hailstoneA.y * k + timeA * ax = hailstoneB.y * k + timeB * by * k
    # Put equations together with subtraction method
    # hailstoneA.x - hailstoneA.y * k  = hailstoneB.x + timeB * bx - hailstoneB.y * k - timeB * by * k
    # hailstoneA.x - hailstoneA.y * k  = hailstoneB.x - hailstoneB.y * k + timeB * (bx - by * k)
    # hailstoneA.x - hailstoneA.y * k - hailstoneB.x + hailstoneB.y * k = timeB * (bx - by * k)
    timeB = (Num.toFrac hailstoneA.x - Num.toFrac hailstoneA.y * ax / ay - Num.toFrac hailstoneB.x + Num.toFrac hailstoneB.y * ax / ay) / (bx - by * ax / ay)

    rockX = Num.toFrac hailstoneB.x + timeB * Num.toFrac hailstoneB.dx - timeB * Num.toFrac rockDx
    rockY = Num.toFrac hailstoneB.y + timeB * Num.toFrac hailstoneB.dy - timeB * Num.toFrac rockDy
    rockZ = Num.toFrac hailstoneB.z + timeB * Num.toFrac hailstoneB.dz - timeB * Num.toFrac rockDz

    rockX + rockY + rockZ


expect
    got = solvePart2 exampleData1
    got == "47"

