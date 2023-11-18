app "advent-of-code-2023"
    packages { pf: "https://github.com/roc-lang/basic-cli/releases/download/0.5.0/Cufzl36_SnJ4QbOoEmiJ5dIpUxBvdB3NEySvuH82Wio.tar.br" }
    imports [pf.Stdout, pf.Arg, pf.Task]
    provides [main] to pf

main =
    Task.await Arg.list \l ->
        when l |> List.get 1 is
            Ok s -> Stdout.line s
            Err _  -> Stdout.line "error"
