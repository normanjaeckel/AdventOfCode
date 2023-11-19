app "advent-of-code-2023"
    packages {
        pf: "https://github.com/roc-lang/basic-cli/releases/download/0.5.0/Cufzl36_SnJ4QbOoEmiJ5dIpUxBvdB3NEySvuH82Wio.tar.br",
    }
    imports [
        pf.Arg,
        pf.Stderr,
        pf.Stdout,
        pf.Task,
        Solution.Day0,
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

                # "1" ->
                #     _ <- Stdout.line "Solution for part 1: \(part1)" |> Task.await
                #     Stdout.line "Solution for part 2: \(part2)"
                d ->
                    _ <- Stderr.line "There is no code for day \(d) yet." |> Task.await
                    Task.err 1 # TODO: Is this correct?

