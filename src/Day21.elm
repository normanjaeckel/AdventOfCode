module Day21 exposing (run)


run : String -> ( String, String )
run puzzleInput =
    ( runPartA puzzleInput, "No solution" )


runPartA : String -> String
runPartA puzzleInput =
    puzzleInput
