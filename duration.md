# duration(1) -- query media duration

## SYNOPSIS

`duration` [`input` ...]


## DESCRIPTION

Invoking this command on any video or audio file will output its duration in hh:mm:ss.ff format. The letters stand for hours, minutes, seconds and centiseconds, respectively.


## OPTIONS

  - `-h`:
    Show a summary of the options.

  - `-v`:
    Display the names of the queried files alongside their duration.

    This mode helps to keep track of the mapping when piping its output through further commands, like sort(1).


## EXIT STATUS

Any error in option specification will lead to an exit code of 1.


## SEE ALSO

ffmpeg(1), sum-time(1).
