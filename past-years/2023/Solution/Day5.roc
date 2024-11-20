interface Solution.Day5
    exposes [
        part1,
        part2,
    ]
    imports [
        "Day5.input" as puzzleInput : Str,
        parser.String.{ parseStr, string, digits },
        parser.Core.{ many, sepBy, keep, const, skip, chompUntil },
    ]

part1 =
    solvePart1 puzzleInput

solvePart1 = \input ->
    paragraphs =
        input
        |> Str.concat "\n"
        |> Str.split "\n\n"
        |> List.dropIf Str.isEmpty
    seeds = getSeeds1 paragraphs
    almanacMaps = getAlmanacMaps paragraphs

    seeds
    |> List.map
        (\seed ->
            almanacMaps
            |> List.walk
                seed
                (\state, am -> transformElement state am)
        )
    |> List.min
    |> Result.withDefault 0
    |> Num.toStr

getSeeds1 = \paragraphs ->
    seedsRaw = paragraphs |> List.first |> Result.withDefault ""
    when seedsParser |> parseStr seedsRaw is
        Ok s -> s
        Err _ -> crash "bad input 1"

getAlmanacMaps = \paragraphs ->
    when paragraphs |> List.dropFirst 1 |> List.mapTry (\rawMap -> mapParser |> parseStr rawMap) is
        Ok am -> am
        Err _ -> crash "bad input 2"

seedsParser =
    const (\s -> s)
    |> skip (string "seeds: ")
    |> keep (digits |> sepBy (string " "))

mapParser =
    const (\am -> AlmanacMap am)
    |> skip (chompUntil '\n')
    |> keep
        (
            many
                (
                    const (\a -> \b -> \c -> AlamacMapLine a b c)
                    |> skip (string "\n")
                    |> keep digits
                    |> skip (string " ")
                    |> keep digits
                    |> skip (string " ")
                    |> keep digits

                )
        )

transformElement = \elem, AlmanacMap am ->
    am
    |> List.walkUntil
        elem
        (\state, AlamacMapLine destStart srcStart len ->
            if state < srcStart then
                Continue state
            else if state >= (srcStart + len) then
                Continue state
            else
                Break (state - srcStart + destStart)
        )

exampleData1 =
    """
    seeds: 79 14 55 13

    seed-to-soil map:
    50 98 2
    52 50 48

    soil-to-fertilizer map:
    0 15 37
    37 52 2
    39 0 15

    fertilizer-to-water map:
    49 53 8
    0 11 42
    42 0 7
    57 7 4

    water-to-light map:
    88 18 7
    18 25 70

    light-to-temperature map:
    45 77 23
    81 45 19
    68 64 13

    temperature-to-humidity map:
    0 69 1
    1 0 69

    humidity-to-location map:
    60 56 37
    56 93 4

    """

expect
    got = solvePart1 exampleData1
    got == "35"

part2 =
    solvePart2 puzzleInput

solvePart2 = \input ->
    paragraphs =
        input
        |> Str.concat "\n"
        |> Str.split "\n\n"
        |> List.dropIf Str.isEmpty
    seeds = getSeeds2 paragraphs
    almanacMaps = getAlmanacMaps paragraphs

    almanacMaps
    |> List.walk
        seeds
        (\state, AlmanacMap am ->
            am
            |> List.walk
                state
                (\state2, AlamacMapLine destStart srcStart almaLen ->
                    srcEnd = srcStart + almaLen - 1
                    move =
                        if destStart >= srcStart then
                            Forward (destStart - srcStart)
                        else
                            Backward (srcStart - destStart)

                    state2
                    |> List.walk
                        []
                        (\state3, Seed seedStart seedEnd shifted ->
                            when shifted is
                                AlreadyShifted -> state3 |> List.append (Seed seedStart seedEnd shifted)
                                NotYetShifted ->
                                    if (seedEnd < srcStart) || (seedStart > srcEnd) then
                                        state3 |> List.append (Seed seedStart seedEnd NotYetShifted)
                                    else if (seedStart >= srcStart) && (seedEnd <= srcEnd) then
                                        when move is
                                            Forward m ->
                                                state3 |> List.append (Seed (seedStart + m) (seedEnd + m) AlreadyShifted)

                                            Backward m ->
                                                state3 |> List.append (Seed (seedStart - m) (seedEnd - m) AlreadyShifted)
                                    else if (seedStart < srcStart) && (seedEnd <= srcEnd) then
                                        when move is
                                            Forward m ->
                                                p1 = Seed seedStart (srcStart - 1) NotYetShifted
                                                p2 = Seed (srcStart + m) (seedEnd + m) AlreadyShifted
                                                state3 |> List.concat [p1, p2]

                                            Backward m ->
                                                p1 = Seed seedStart (srcStart - 1) NotYetShifted
                                                p2 = Seed (srcStart - m) (seedEnd - m) AlreadyShifted
                                                state3 |> List.concat [p1, p2]
                                    else if (seedStart >= srcStart) && (seedEnd > srcEnd) then
                                        when move is
                                            Forward m ->
                                                p1 = Seed (seedStart + m) (srcEnd + m) AlreadyShifted
                                                p2 = Seed (srcEnd + 1) (seedEnd) NotYetShifted
                                                state3 |> List.concat [p1, p2]

                                            Backward m ->
                                                p1 = Seed (seedStart - m) (srcEnd - m) AlreadyShifted
                                                p2 = Seed (srcEnd + 1) (seedEnd) NotYetShifted
                                                state3 |> List.concat [p1, p2]
                                    else
                                        when move is
                                            Forward m ->
                                                p1 = Seed seedStart (srcStart - 1) NotYetShifted
                                                p2 = Seed (srcStart + m) (srcEnd + m) AlreadyShifted
                                                p3 = Seed (srcEnd + 1) (seedEnd) NotYetShifted
                                                state3 |> List.concat [p1, p2, p3]

                                            Backward m ->
                                                p1 = Seed seedStart (srcStart - 1) NotYetShifted
                                                p2 = Seed (srcStart - m) (srcEnd - m) AlreadyShifted
                                                p3 = Seed (srcEnd + 1) (seedEnd) NotYetShifted
                                                state3 |> List.concat [p1, p2, p3]
                        )
                )
            |> List.map (\Seed a b _ -> Seed a b NotYetShifted)
        )
    |> List.map (\Seed a _ _ -> a)
    |> List.min
    |> Result.withDefault 0
    |> Num.toStr

getSeeds2 = \paragraphs ->
    seedsRaw = paragraphs |> List.first |> Result.withDefault ""
    seedsList =
        when seedsParser |> parseStr seedsRaw is
            Ok s -> s
            Err _ -> crash "bad input 1"
    fn seedsList

fn = \seedsList ->
    when seedsList is
        [a, b, ..] -> List.prepend (fn (seedsList |> List.dropFirst 2)) (Seed a (a + b - 1) NotYetShifted)
        [] -> []
        [_] -> crash "bad list"

exampleData2 =
    exampleData1

expect
    got = solvePart2 exampleData2
    got == "46"
