# Medianumbers

This repository collects small scripts and outgrown aliases for the query and manipulation of video and audio time codes, durations and aspect ratios. It mostly wraps and thus depends on [ffmpeg](http://ffmpeg.org/). Time is usually formatted as `hh:mm:ss.ff`, in hours, minutes, seconds and optional centiseconds.

- [**duration**](duration.md) queries the play length of a file.

- [**sum-time**](sum-time.md) adds up timecodes.

- [**stretch**](stretch.md) re-encodes to a multiple of the original speed.


## Installation

The scripts can be used as they are here, or copied somewhere in your `$PATH` for frequent use.

All of them need [bash](http://tiswww.case.edu/php/chet/bash/bashtop.html) to function. The following table lists further runtime dependencies.

|          | [ffmpeg][1] | [grep][2] | [bc][3] |
| -------: | :---------: | :-------: | :-----: |
| duration |      ✗      |     ✗     |         |
| sum-time |             |           |         |
| stretch  |      ✗      |           |    ✗    |
[1]: http://ffmpeg.org/
[2]: https://www.gnu.org/software/grep/
[3]: https://www.gnu.org/software/bc/

Accompanying manual pages can be created from the respective markdown descriptions of the programs using [ronn](https://github.com/rtomayko/ronn).
