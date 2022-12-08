module Day07 exposing (run)

import Dict


run : String -> ( String, String )
run puzzleInput =
    ( runPartA puzzleInput, "No solution" )


runPartA : String -> String
runPartA puzzleInput =
    puzzleInput
        |> parseCommands
        |> buildFilesystem
        |> countDirectories "/"
        |> filterAtMost 100000
        |> List.sum
        |> String.fromInt


type alias Directory =
    Dict.Dict String File


type Command
    = CD String
    | LS Directory


type File
    = Dir Directory
    | Datafile Int


parseCommands : String -> List Command
parseCommands puzzleInput =
    let
        parseCommand : String -> Maybe Command
        parseCommand input =
            if String.startsWith "cd" input then
                Just <| CD (String.dropLeft 3 input)

            else if String.startsWith "ls" input then
                Just <| LS <| parseLS <| String.dropLeft 3 input

            else
                Nothing

        parseLS : String -> Dict.Dict String File
        parseLS s =
            s
                |> String.split "\n"
                |> List.filterMap
                    (\sub ->
                        if sub |> String.startsWith "dir" then
                            Just ( sub |> String.dropLeft 4, Dir Dict.empty )

                        else
                            case sub |> String.split " " of
                                a :: b :: _ ->
                                    Just ( b, Datafile (String.toInt a |> Maybe.withDefault 0) )

                                _ ->
                                    Nothing
                    )
                |> Dict.fromList
    in
    ("\n" ++ puzzleInput)
        |> String.split "\n$ "
        |> List.filterMap parseCommand


type alias Container =
    { cwd : List String
    , dir : Directory
    }


buildFilesystem : List Command -> Directory
buildFilesystem commands =
    let
        fn : Command -> Container -> Container
        fn cmd acc =
            case cmd of
                CD pattern ->
                    if pattern == "/" then
                        { acc | cwd = [] }

                    else if pattern == ".." then
                        { acc | cwd = acc.cwd |> List.take (List.length acc.cwd - 1) }

                    else
                        { acc | cwd = acc.cwd ++ [ pattern ] }

                LS files ->
                    { acc | dir = goDown acc.cwd acc.dir files }

        goDown : List String -> Directory -> Directory -> Directory
        goDown pwd dir files =
            case pwd of
                [] ->
                    files

                a :: restPwd ->
                    let
                        innerDict =
                            case dir |> Dict.get a |> Maybe.withDefault (Dir Dict.empty) of
                                Dir d ->
                                    d

                                Datafile _ ->
                                    Dict.empty
                    in
                    dir
                        |> Dict.insert
                            a
                            (Dir <| goDown restPwd innerDict files)
    in
    commands
        |> List.foldl fn (Container [] Dict.empty)
        |> .dir


countDirectories : String -> Directory -> Dict.Dict String Int
countDirectories name dir =
    let
        fn : String -> File -> Dict.Dict String Int -> Dict.Dict String Int
        fn innerName innerType acc =
            case innerType of
                Datafile size ->
                    acc |> Dict.insert name ((acc |> Dict.get name |> Maybe.withDefault 0) + size)

                Dir d ->
                    let
                        innerDict =
                            countDirectories (name ++ "/" ++ innerName) d
                    in
                    acc
                        |> Dict.insert name
                            ((acc |> Dict.get name |> Maybe.withDefault 0)
                                + (innerDict |> Dict.get (name ++ "/" ++ innerName) |> Maybe.withDefault 0)
                            )
                        |> Dict.union innerDict
    in
    dir |> Dict.foldl fn Dict.empty


filterAtMost : Int -> Dict.Dict String Int -> List Int
filterAtMost count d =
    d |> Dict.filter (\_ v -> v <= count) |> Dict.values
