interface Solution.Day15
    exposes [
        part1,
        part2,
    ]
    imports [
        "Day15.input" as puzzleInput : Str,
        parser.String.{ parseStr, digit, anyCodeunit },
        parser.Core.{ const, chompWhile, maybe, keep, map },
    ]

part1 =
    solvePart1 puzzleInput

solvePart1 = \input ->
    input
    |> Str.trim
    |> Str.split "\n"
    |> List.map (\l -> l |> Str.split ",")
    |> List.join
    |> List.map holidayASCIIStringHelperAlgorithm
    |> List.sum
    |> Num.toStr

holidayASCIIStringHelperAlgorithm = \s ->
    s
    |> Str.toUtf8
    |> List.map Num.toNat
    |> List.walk
        0
        (\state, c ->
            ((state + c) * 17) % 256
        )

expect
    got = holidayASCIIStringHelperAlgorithm "HASH"
    got == 52

expect
    got = holidayASCIIStringHelperAlgorithm "rn=1"
    got == 30

exampleData1 =
    """
    rn=1,cm-,qp=3,cm=2,qp-,pc=4,ot=9,ab=5,pc-,pc=6,ot=7
    rn=1,cm-,qp=3,cm=2,qp-,pc=4,ot=9,ab=5,pc-,pc=6,ot=7
    """

expect
    got = solvePart1 exampleData1
    got == "2640" # 1320 * 2

part2 =
    solvePart2 puzzleInput

solvePart2 = \input ->
    steps =
        input
        |> Str.trim
        |> Str.split "\n"
        |> List.map (\l -> l |> Str.split ",")
        |> List.join
        |> List.map parseSteps

    boxes = List.repeat [] 256

    steps
    |> List.walk
        boxes
        (\state, Step label action focalLength ->
            id = holidayASCIIStringHelperAlgorithm label
            when state |> List.get id is
                Err _ -> crash "impossible"
                Ok box ->
                    newBox =
                        when action is
                            Remove ->
                                box |> List.dropIf (\(lens, _power) -> lens == label)

                            Add ->
                                when focalLength is
                                    Err _ ->
                                        crash "bad input, missing focal length"

                                    Ok fLValue ->
                                        when box |> List.findFirstIndex (\(lens, _power) -> lens == label) is
                                            Err _ ->
                                                box |> List.append (label, fLValue)

                                            Ok idx ->
                                                box |> List.set idx (label, fLValue)
                    state |> List.set id newBox
        )
    |> List.mapWithIndex countFocusingPower
    |> List.sum
    |> Num.toStr

parseSteps = \step ->
    when stepParser |> parseStr step is
        Ok v -> v
        Err _ -> crash "parsing failed"

stepParser =
    const (\a -> \b -> \c -> Step a b c)
    |> keep
        (
            chompWhile (\c -> !(c == '=' || c == '-'))
            |> map (\l -> l |> Str.fromUtf8 |> Result.withDefault "")
        )
    |> keep (anyCodeunit |> map (\c -> if c == '=' then Add else Remove))
    |> keep (maybe digit)

countFocusingPower = \box, boxIndex ->
    box
    |> List.mapWithIndex
        (\(_lens, power), lensIndex ->
            (boxIndex + 1) * (lensIndex + 1) * power
        )
    |> List.sum

exampleData2 =
    "rn=1,cm-,qp=3,cm=2,qp-,pc=4,ot=9,ab=5,pc-,pc=6,ot=7"

expect
    got = solvePart2 exampleData2
    got == "145"
