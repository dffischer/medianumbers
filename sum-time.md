# sum-time(1) -- add up time values

## SYNOPSIS

`sum-time` [`hh:mm:ss.ff` ...]


## DESCRIPTION

This command adds up all time stamps passed to it.


## OPTIONS

Time values are accepted in full or degraded `hh:mm:ss.ff` format, which are colon-separated hours, minutes and seconds with an optional, dot-separated centisecond fragment. Hours and minutes may also be left out in this order, along with their colons. The result will be emitted to the standard output always in full format.

Passing `-h` in any position will only show a short help text.


## EXIT STATUS

An exit code of 1 signals erroneous formatting of any input value.


## SEE ALSO

duration(1).
