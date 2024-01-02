# Advent Of Code 2023

![Number of stars](https://img.shields.io/badge/Advent_Of_Code_2023-38_*-success)

## Summary

My path through the current [Advent Of Code
2023](https://adventofcode.com/2023).

## Usage

First you have to get [Roc](https://www.roc-lang.org/) (see for example the [Roc
installation guide for x86_64 Linux
systems](https://github.com/roc-lang/roc/blob/main/getting_started/linux_x86_64.md)).

Download the latest nightly build and untar the archive:

    $ wget https://github.com/roc-lang/roc/releases/download/nightly/roc_nightly-linux_x86_64-latest.tar.gz
    $ tar -xf roc_nightly-linux_x86_64-latest.tar.gz

Get the `roc` binary under `roc_nightly-linux_x86_64-<VERSION>` into your path.
For example you can use [devenv](https://devenv.sh/):

    $ devenv shell

Build and run my code:

    $ roc build
    $ ./main 24  # Runs the code for Christmas Eve

## VSCode extension for Roc

To use [a VSCode extension for
Roc](https://github.com/ivan-demchenko/roc-vscode-unofficial) you have to
[install the Roc language server
binary](https://github.com/ayazhafiz/roc/blob/lang-srv/crates/lang_srv/).

## Hints

Day 6 works only when using the legacy linker. Thats why I commented it out.

## License

MIT
