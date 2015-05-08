# strech(1) -- modify playback speed

## SYNOPSIS

`strech` [`factor`] <`input`> [`output`]


## DESCRIPTION

Invoking this command re-encodes the given input audio or video, speeding up or slowing down its playback by the given factor, saving the result to the given output file.


## OPTIONS

The factor denotes the change in playback speed. A factor of 1 leaves the original unchanged, greater number speed up, smaller numbers slow down. The length of the result will respectively grow or shrink. To be precise, a factor of x will make everything x times as fast, yielding a track that is 1/x times as long as the input.

If the factor is omitted, it defaults to *4/3*, speeding up by one third, reducing the length by 25 percent. This should be a significant speed up just low enough that even quick speakers stay understandable.

If no output file name is given, the name of the input file will be used, with the marker *.stretched* inserted just before the extension.


## EXIT STATUS

An exit code of 1 signals erroneous formatting of any input value, for example a non-numeric factor.

The exit code of the encoding ffmpeg(1) process will be passed through. As the encoding will deal with fractions of the original timespans, it is completely normal for warning messages like "Past duration ... too large" to be emitted.


## SEE ALSO

ffmpeg(1), ffmpeg-filters(1), in particular _atempo_ and _setpts_.
