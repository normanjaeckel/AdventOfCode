interface Solution.Day2
    exposes [
        part1,
        part2,
    ]
    imports [
        "Day2.input" as puzzleInput : Str,
        parser.String.{ parseStr, string, digits },
        parser.Core.{ skip, keep, const, sepBy, oneOf, map },
    ]

part1 =
    solvePart1 puzzleInput

contentOfBagRed = 12
contentOfBagGreen = 13
contentOfBagBlue = 14

solvePart1 = \input ->
    solution =
        input
        |> Str.split "\n"
        |> List.dropIf Str.isEmpty
        |> List.walkTry
            []
            (\state, line ->
                gameParser
                |> parseStr line
                |> Result.try (\parsedLine -> state |> List.append parsedLine |> Ok)
            )
        |> Result.try
            (
                \games ->
                    games
                    |> List.walk
                        0
                        (\state, Game id grabs -> if grabs |> checkGrabs then state + id else state)
                    |> Num.toStr
                    |> Ok
            )

    when solution is
        Err e ->
            when e is
                ParsingFailure f -> "failure: \(f)"
                ParsingIncomplete f -> "incomplete: \(f)"

        Ok v -> v

checkGrabs = \grabs ->
    grabs
    |> List.keepIf
        (\grab -> grab
            |> List.any
                (\GrabElem count color ->
                    when color is
                        Red -> count > contentOfBagRed
                        Green -> count > contentOfBagGreen
                        Blue -> count > contentOfBagBlue
                ))
    |> List.isEmpty

exampleData1 =
    """
    Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
    Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
    Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
    Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
    Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
    """

expect solvePart1 exampleData1 == "8"

gameParser =
    const (\gameId -> \grabs -> Game gameId grabs)
    |> skip (string "Game ")
    |> keep digits
    |> skip (string ": ")
    |> keep (grabParser |> sepBy (string "; "))

grabParser =
    cubeParser |> sepBy (string ", ")

cubeParser =
    const (\count -> \color -> GrabElem count color)
    |> keep digits
    |> skip (string " ")
    |> keep
        (
            oneOf [
                string "red" |> map \_ -> Red,
                string "blue" |> map \_ -> Blue,
                string "green" |> map \_ -> Green,
            ]
        )

part2 =
    solvePart2 puzzleInput

solvePart2 = \_input ->
    ""

exampleData2 =
    """
    """

expect solvePart2 exampleData2 == ""
