app "advent-of-code-2023"
    packages {
        pf: "https://github.com/roc-lang/basic-cli/releases/download/0.7.0/bkGby8jb0tmZYsy2hg1E_B2QrCgcSTxdUlHtETwm5m4.tar.br",
        parser: "https://github.com/lukewilliamboswell/roc-parser/releases/download/0.2.0/dJQSsSmorujhiPNIvJKlQoI92RFIG_JQwUfIxZsCSwE.tar.br",
    }
    imports [
        pf.Arg,
        pf.Stderr,
        pf.Stdout,
        pf.Task,
        Solution.Day0,
        Solution.Day1,
        Solution.Day2,
    ]
    provides [main] to pf

main =
    l <- Task.await Arg.list
    when l |> List.get 1 is
        Err _ -> Stderr.line "Missing argument for day (from 1 to 25)"
        Ok day ->
            when day is
                "0" ->
                    _ <- Stdout.line "Solution for part 1: \(Solution.Day0.part1)" |> Task.await
                    Stdout.line "Solution for part 2: \(Solution.Day0.part2)"

                "1" ->
                    _ <- Stdout.line "Solution for part 1: \(Solution.Day1.part1)" |> Task.await
                    Stdout.line "Solution for part 2: \(Solution.Day1.part2)"

                "2" ->
                    _ <- Stdout.line "Solution for part 1: \(Solution.Day2.part1)" |> Task.await
                    Stdout.line "Solution for part 2: \(Solution.Day2.part2)"

                d ->
                    _ <- Stderr.line "There is no code for day \(d) yet." |> Task.await
                    Task.err 1 # TODO: Is this correct?

