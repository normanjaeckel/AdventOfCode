module Day24 exposing (run)

import Parser exposing ((|.), (|=))
import Set


run : String -> ( String, String )
run puzzleInput =
    ( runPart puzzleInput PuzzlePartA, runPart puzzleInput PuzzlePartB )


type PuzzlePart
    = PuzzlePartA
    | PuzzlePartB


runPart : String -> PuzzlePart -> String
runPart puzzleInput puzzlePart =
    case puzzleInput |> Parser.run puzzleParser of
        Err _ ->
            "Error"

        Ok valley ->
            let
                currentPos : Set.Set Position
                currentPos =
                    Set.singleton valley.entrance

                currentPath : Int
                currentPath =
                    0

                targets : List Position
                targets =
                    case puzzlePart of
                        PuzzlePartA ->
                            [ valley.exit ]

                        PuzzlePartB ->
                            [ valley.exit, valley.entrance, valley.exit ]
            in
            walk valley targets currentPos currentPath
                |> String.fromInt


type alias Valley =
    { width : Int
    , height : Int
    , entrance : Position
    , exit : Position
    , blizzards : List Blizzard
    }


type alias Position =
    ( Int, Int )


type alias Blizzard =
    { position : Position
    , direction : Direction
    }


type Direction
    = North
    | South
    | West
    | East



-- Parse puzzle input


puzzleParser : Parser.Parser Valley
puzzleParser =
    Parser.succeed
        (\start middle end ( row, col ) ->
            { width = col - 1
            , height = row
            , entrance = start
            , exit = end
            , blizzards = middle

            --, minimumLength = abs (Tuple.first end - Tuple.first start) + abs (Tuple.second end - Tuple.second start)
            }
        )
        |= startOrEndParser
        |. Parser.symbol "\n"
        |= middleParser
        |= startOrEndParser
        |= Parser.getPosition
        |. Parser.symbol "\n"
        |. Parser.end


startOrEndParser : Parser.Parser Position
startOrEndParser =
    Parser.succeed (\( row, col ) -> ( col - 1, row - 1 ))
        |. Parser.chompWhile ((==) '#')
        |= Parser.getPosition
        |. Parser.symbol "."
        |. Parser.chompWhile ((==) '#')


middleParser : Parser.Parser (List Blizzard)
middleParser =
    Parser.loop []
        (\blizzards ->
            Parser.oneOf
                [ Parser.backtrackable <|
                    Parser.succeed (\line -> blizzards ++ line |> Parser.Loop)
                        |. Parser.symbol "#"
                        |= parserValleyLine
                        |. Parser.symbol "#\n"
                , Parser.succeed () |> Parser.map (\_ -> Parser.Done blizzards)
                ]
        )


parserValleyLine : Parser.Parser (List Blizzard)
parserValleyLine =
    Parser.loop []
        (\blizzards ->
            Parser.oneOf
                [ Parser.succeed
                    (\mbb ->
                        case mbb of
                            Just blizz ->
                                blizz :: blizzards |> Parser.Loop

                            Nothing ->
                                blizzards |> Parser.Loop
                    )
                    |= Parser.oneOf
                        [ Parser.succeed (\( row, col ) arrow -> Just { position = ( col - 1, row - 1 ), direction = arrow |> toDirection })
                            |= Parser.getPosition
                            |= Parser.getChompedString (Parser.chompIf (\c -> c == '<' || c == '>' || c == 'v' || c == '^'))
                        , Parser.succeed Nothing
                            |. Parser.symbol "."
                        ]
                , Parser.succeed () |> Parser.map (\_ -> blizzards |> List.reverse |> Parser.Done)
                ]
        )


toDirection : String -> Direction
toDirection arrow =
    case arrow of
        "<" ->
            West

        ">" ->
            East

        "^" ->
            North

        _ ->
            South



-- Walk


walk : Valley -> List Position -> Set.Set Position -> Int -> Int
walk valley targets currentPos currentPath =
    case targets of
        [] ->
            currentPath - 1

        target :: nextTargets ->
            let
                newBlizzards : List Blizzard
                newBlizzards =
                    valley.blizzards
                        |> List.map
                            (\blizz ->
                                let
                                    newBlizzPos =
                                        (case blizz.direction of
                                            North ->
                                                blizz.position |> Tuple.mapSecond ((+) -1)

                                            South ->
                                                blizz.position |> Tuple.mapSecond ((+) 1)

                                            West ->
                                                blizz.position |> Tuple.mapFirst ((+) -1)

                                            East ->
                                                blizz.position |> Tuple.mapFirst ((+) 1)
                                        )
                                            |> Tuple.mapBoth
                                                (\x -> 1 + ((x - 1) |> modBy (valley.width - 2)))
                                                (\y -> 1 + ((y - 1) |> modBy (valley.height - 2)))
                                in
                                { blizz | position = newBlizzPos }
                            )

                newValley : Valley
                newValley =
                    { valley | blizzards = newBlizzards }

                newPos : Set.Set Position -> Set.Set Position
                newPos curPos =
                    curPos
                        |> Set.foldl extendPositions Set.empty
                        |> Set.filter (freePosition newValley)
            in
            if currentPos |> Set.member target then
                walk newValley nextTargets (newPos (Set.singleton target)) (currentPath + 1)

            else
                walk newValley targets (newPos currentPos) (currentPath + 1)


extendPositions : Position -> Set.Set Position -> Set.Set Position
extendPositions ( x, y ) all =
    Set.fromList [ ( x, y ), ( x + 1, y ), ( x - 1, y ), ( x, y + 1 ), ( x, y - 1 ) ]
        |> Set.union all


freePosition : Valley -> Position -> Bool
freePosition valley pos =
    if pos |> isWallOf valley then
        False

    else if pos |> isBlizzard valley then
        False

    else
        True


isWallOf : Valley -> Position -> Bool
isWallOf valley (( x, y ) as pos) =
    if x <= 0 || x >= (valley.width - 1) then
        True

    else if y <= 0 && pos /= valley.entrance then
        True

    else if y >= (valley.height - 1) && pos /= valley.exit then
        True

    else
        False


isBlizzard : Valley -> Position -> Bool
isBlizzard valley pos =
    valley.blizzards |> List.any (\blizz -> blizz.position == pos)
