# strech(1) -- modify playback speed

## SYNOPSIS

`strech` [_`options`_] <`input`>


## DESCRIPTION

Invoking this command re-encodes the given input audio or video, speeding up or slowing down its playback.


## OPTIONS

  - `-h`:
    Show a summary of the options.

  - `-s` _factor_:
    Multiply playback speed. A factor of 1 leaves the original unchanged, greater number speed up, smaller numbers slow down. The length of the result will respectively grow or shrink. To be precise, a factor of x will make everything x times as fast, yielding a track that is 1/x times as long as the input.

    Valid factor values are floating point numbers or an integral fraction, always from the interval [0.5, 2]. If it is omitted, it defaults to *4/3*, speeding up by one third, reducing the length by 25 percent. This should be a significant speed up just low enough that even quick speakers stay understandable.

  - `-o` _output_:
    Place the resulting video with the given file name.

    The templates `$path`, `$file`, `$name` and `$ext` may be included in the argument to this option an are interpreted respectively as the file path, the the full file name, the basename and the extension of the input file.

    Without this option, the output file defaults to `$name.stretched.$ext`.


## EXIT STATUS

An exit code of 1 signals erroneous formatting of any input value, for example a non-numeric factor.

The exit code of the encoding ffmpeg(1) process will be passed through. As the encoding will deal with fractions of the original timespans, it is completely normal for warning messages like "Past duration ... too large" to be emitted.


## SEE ALSO

ffmpeg(1), ffmpeg-filters(1), in particular _atempo_ and _setpts_.
