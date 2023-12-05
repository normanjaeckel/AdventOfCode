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
    input
    |> Str.concat "\n"
    |> Str.split "\n\n"
    |> List.dropIf Str.isEmpty
    |> parseEverything

parseEverything = \paragraphs ->
    seedsRaw = paragraphs |> List.first |> Result.withDefault ""
    seeds =
        when seedsParser |> parseStr seedsRaw is
            Ok s -> s
            Err _ -> crash "bad input 1"
    almanacMaps =
        when paragraphs |> List.dropFirst 1 |> List.mapTry (\rawMap -> mapParser |> parseStr rawMap) is
            Ok am -> am
            Err e ->
                dbg
                    e

                crash "bad input 2"

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

solvePart2 = \_input ->
    ""

exampleData2 =
    """
    """

expect
    got = solvePart2 exampleData2
    got == ""
