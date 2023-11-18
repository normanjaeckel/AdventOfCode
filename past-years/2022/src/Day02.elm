module Day02 exposing (run)


run : String -> ( String, String )
run content =
    ( innerRun content False, innerRun content True )


innerRun : String -> Bool -> String
innerRun content toBeTransformed =
    let
        transformFn : Element -> Element
        transformFn =
            if toBeTransformed then
                transformElement

            else
                identity

        fn : Element -> Int -> Int
        fn =
            \el acc ->
                acc + scoreShape el.you + scoreWin el
    in
    content
        |> String.split "\n"
        |> List.map (String.split " " >> List.take 2 >> parseElement >> transformFn)
        |> List.foldl fn 0
        |> String.fromInt


type alias Element =
    { opponent : Shape, you : Shape }


parseElement : List String -> Element
parseElement l =
    case l of
        char1 :: char2 :: _ ->
            let
                o =
                    if char1 == "A" then
                        Rock

                    else if char1 == "B" then
                        Paper

                    else if char1 == "C" then
                        Scissors

                    else
                        Invalid

                y =
                    if char2 == "X" then
                        Rock

                    else if char2 == "Y" then
                        Paper

                    else if char2 == "Z" then
                        Scissors

                    else
                        Invalid
            in
            Element o y

        _ ->
            Element Invalid Invalid


type Shape
    = Rock
    | Paper
    | Scissors
    | Invalid


scoreShape : Shape -> Int
scoreShape s =
    case s of
        Rock ->
            1

        Paper ->
            2

        Scissors ->
            3

        Invalid ->
            0


scoreWin : Element -> Int
scoreWin el =
    case el.you of
        Rock ->
            case el.opponent of
                Rock ->
                    3

                Paper ->
                    0

                Scissors ->
                    6

                Invalid ->
                    0

        Paper ->
            case el.opponent of
                Rock ->
                    6

                Paper ->
                    3

                Scissors ->
                    0

                Invalid ->
                    0

        Scissors ->
            case el.opponent of
                Rock ->
                    0

                Paper ->
                    6

                Scissors ->
                    3

                Invalid ->
                    0

        Invalid ->
            0


transformElement : Element -> Element
transformElement el =
    case el.you of
        Rock ->
            -- This was a X and means you need to loose.
            case el.opponent of
                Rock ->
                    Element Rock Scissors

                Paper ->
                    Element Paper Rock

                Scissors ->
                    Element Scissors Paper

                Invalid ->
                    Element Invalid Invalid

        Paper ->
            -- This was a Y and means you need to end the round in a draw.
            case el.opponent of
                Rock ->
                    Element Rock Rock

                Paper ->
                    Element Paper Paper

                Scissors ->
                    Element Scissors Scissors

                Invalid ->
                    Element Invalid Invalid

        Scissors ->
            -- This was a Z and means you need to win.
            case el.opponent of
                Rock ->
                    Element Rock Paper

                Paper ->
                    Element Paper Scissors

                Scissors ->
                    Element Scissors Rock

                Invalid ->
                    Element Invalid Invalid

        Invalid ->
            Element Invalid Invalid
