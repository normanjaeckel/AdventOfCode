app "advent-of-code-2023"
    packages {
        pf: "https://github.com/roc-lang/basic-cli/releases/download/0.7.1/Icc3xJoIixF3hCcfXrDwLCu4wQHtNdPyoJkEbkgIElA.tar.br",
        parser: "https://github.com/lukewilliamboswell/roc-parser/releases/download/0.3.0/-e3ebWWmlFPfe9fYrr2z1urfslzygbtQQsl69iH1qzQ.tar.br",
    }
    imports [
        pf.Arg,
        pf.Stderr,
        pf.Stdout,
        pf.Task,
        Solution.Day1,
        Solution.Day2,
        Solution.Day3,
        Solution.Day4,
        Solution.Day5,
        # Solution.Day6,
        Solution.Day7,
        Solution.Day8,
        Solution.Day9,
        Solution.Day10,
        Solution.Day11,
        Solution.Day12,
        Solution.Day13,
        Solution.Day14,
        Solution.Day15,
        Solution.Day16,
        Solution.Day17,
        Solution.Day18,
        Solution.Day19,
        Solution.Day20,
        Solution.Day21,
        Solution.Day22,
        Solution.Day23,
        # Solution.Day24,
        # Solution.Day25,
    ]
    provides [main] to pf

main =
    l <- Task.await Arg.list

    when l |> List.get 1 is
        Err _ -> Stderr.line "Missing argument for day (from 1 to 25)"
        Ok day ->
            when day is
                "1" -> writeSolutions Solution.Day1.part1 Solution.Day1.part2
                "2" -> writeSolutions Solution.Day2.part1 Solution.Day2.part2
                "3" -> writeSolutions Solution.Day3.part1 Solution.Day3.part2
                "4" -> writeSolutions Solution.Day4.part1 Solution.Day4.part2
                "5" -> writeSolutions Solution.Day5.part1 Solution.Day5.part2
                "6" -> Stdout.line "The solution ist commented out because you have to use the build flag --linker=legacy for this part of the code."
                # "6" -> writeSolutions Solution.Day6.part1 Solution.Day6.part2
                "7" -> writeSolutions Solution.Day7.part1 Solution.Day7.part2
                "8" -> writeSolutions Solution.Day8.part1 Solution.Day8.part2
                "9" -> writeSolutions Solution.Day9.part1 Solution.Day9.part2
                "10" -> writeSolutions Solution.Day10.part1 Solution.Day10.part2
                "11" -> writeSolutions Solution.Day11.part1 Solution.Day11.part2
                "12" -> writeSolutions Solution.Day12.part1 Solution.Day12.part2
                "13" -> writeSolutions Solution.Day13.part1 Solution.Day13.part2
                "14" -> writeSolutions Solution.Day14.part1 Solution.Day14.part2
                "15" -> writeSolutions Solution.Day15.part1 Solution.Day15.part2
                "16" -> writeSolutions Solution.Day16.part1 Solution.Day16.part2
                "17" -> writeSolutions Solution.Day17.part1 Solution.Day17.part2
                "18" -> writeSolutions Solution.Day18.part1 Solution.Day18.part2
                "19" -> writeSolutions Solution.Day19.part1 Solution.Day19.part2
                "20" -> writeSolutions Solution.Day20.part1 Solution.Day20.part2
                "21" -> writeSolutions Solution.Day21.part1 Solution.Day21.part2
                "22" -> writeSolutions Solution.Day22.part1 Solution.Day22.part2
                "23" -> writeSolutions Solution.Day23.part1 Solution.Day23.part2
                # "24" -> writeSolutions Solution.Day24.part1 Solution.Day24.part2
                # "25" -> writeSolutions Solution.Day25.part1 Solution.Day25.part2
                d ->
                    _ <- Stderr.line "There is no code for day \(d) yet." |> Task.await
                    Task.err 1 # TODO: Is this correct?

writeSolutions = \part1, part2 ->
    _ <- Stdout.line "Solution for part 1: \(part1)" |> Task.await
    Stdout.line "Solution for part 2: \(part2)"
