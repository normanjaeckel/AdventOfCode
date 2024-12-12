app [part1, part2] {
    pf: platform "https://github.com/ostcar/roc-aoc-platform/releases/download/v0.0.8/lhFfiil7mQXDOB6wN-jduJQImoT8qRmoiNHDB4DVF9s.tar.br",
    parser: "https://github.com/lukewilliamboswell/roc-parser/releases/download/0.9.0/w8YKp2YAgQt5REYk912HfKAHBjcXsrnvtjI0CBzoAT4.tar.br",
}

import parser.Parser exposing [Parser, many]
import parser.String exposing [parseStr, digit]

example : Str
example =
    "2333133121414131402"

expect
    got = part1 example
    expected = Ok "1928"
    got == expected

part1 : Str -> Result Str [ParsingFailure Str, ParsingIncomplete Str]
part1 = \rawInput ->
    parseStr puzzleParser (rawInput |> Str.trim)
    |> Result.map
        \diskMap ->
            diskMap
            |> extendDiskMap
            |> calcChecksum
            |> Num.toStr

puzzleParser : Parser (List U8) (List U64)
puzzleParser =
    many digit

Filesystem : List Block
Block : [File U64, Free]

extendDiskMap : List U64 -> Filesystem
extendDiskMap = \diskMap ->
    extendDiskMapHelper diskMap 0 []

extendDiskMapHelper : List U64, U64, Filesystem -> Filesystem
extendDiskMapHelper = \diskMap, index, fs ->
    when diskMap is
        [] -> fs
        [first, .. as rest] ->
            newBlocks =
                List.range { start: At 0, end: Length first }
                |> List.map
                    \_ ->
                        if index % 2 == 0 then
                            File (index // 2)
                        else
                            Free
            extendDiskMapHelper rest (index + 1) (fs |> List.concat newBlocks)

calcChecksum : Filesystem -> U64
calcChecksum = \fs ->
    calcChecksumHelper fs 0 0

calcChecksumHelper : Filesystem, U64, U64 -> U64
calcChecksumHelper = \fs, index, checksum ->
    when fs is
        [] ->
            checksum

        [first, .. as rest] ->
            when first is
                File id ->
                    newChecksum = checksum + id * index
                    calcChecksumHelper rest (index + 1) newChecksum

                Free ->
                    when rest is
                        [] ->
                            checksum

                        [.. as rest2, last] ->
                            when last is
                                Free ->
                                    calcChecksumHelper (fs |> List.dropLast 1) index checksum

                                File id ->
                                    newChecksum = checksum + id * index
                                    calcChecksumHelper rest2 (index + 1) newChecksum

expect
    got = part2 example
    expected = Ok "2858"
    got == expected

part2 : Str -> Result Str [ParsingFailure Str, ParsingIncomplete Str, BadInput]
part2 = \rawInput ->
    parseStr puzzleParser (rawInput |> Str.trim)
    |> Result.try
        \diskMap ->
            diskMap
            |> checkDiskMapHasOddLen?
            |> locateFullAndFree
            |> rearrangeBlocks
            |> calcChecksumPartTwo
            |> Num.toStr
            |> Ok

checkDiskMapHasOddLen : List U64 -> Result (List U64) [BadInput]
checkDiskMapHasOddLen = \diskMap ->
    if List.len diskMap |> Num.isEven then
        Err BadInput
    else
        Ok diskMap

Block2 : [File2 U64 U64, Free2 U64]

locateFullAndFree : List U64 -> List Block2
locateFullAndFree = \diskMap ->
    diskMap
    |> List.mapWithIndex
        \blockLen, index ->
            if index % 2 == 0 then
                File2 blockLen (index // 2)
            else
                Free2 blockLen

rearrangeBlocks : List Block2 -> List Block2
rearrangeBlocks = \diskMap ->
    diskMap |> rearrangeBlocksHelper [] |> List.reverse

rearrangeBlocksHelper : List Block2, List Block2 -> List Block2
rearrangeBlocksHelper = \diskMap, result ->
    when diskMap is
        [] ->
            result

        [.. as previous, block] ->
            when block is
                File2 len _fileId ->
                    previous
                    |> List.walkWithIndexUntil
                        (Err NotFound)
                        \state, block2, index ->
                            when block2 is
                                File2 _ _ ->
                                    Continue state

                                Free2 space ->
                                    if space < len then
                                        Continue state
                                    else
                                        Break (Ok (index, space))
                    |> \state ->
                        when state is
                            Ok (index, space) ->
                                restFreeSpace =
                                    if space - len == 0 then
                                        []
                                    else
                                        [Free2 (space - len)]
                                newPrevious =
                                    [
                                        List.takeFirst previous index,
                                        [block],
                                        restFreeSpace,
                                        List.dropFirst previous (index + 1),
                                    ]
                                    |> List.join
                                rearrangeBlocksHelper newPrevious (result |> List.append (Free2 len))

                            Err NotFound ->
                                rearrangeBlocksHelper previous (result |> List.append block)

                Free2 _len ->
                    rearrangeBlocksHelper previous (result |> List.append block)

calcChecksumPartTwo : List Block2 -> U64
calcChecksumPartTwo = \blocks ->
    blocks
    |> List.walk
        { checksum: 0, index: 0 }
        \state, block ->
            when block is
                File2 len fileId ->
                    newChecksum =
                        List.range { start: At state.index, end: Length len }
                        |> List.map \i -> i * fileId
                        |> List.sum
                        |> Num.add state.checksum
                    { checksum: newChecksum, index: state.index + len }

                Free2 len ->
                    { state & index: state.index + len }
    |> .checksum
