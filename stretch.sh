#!/bin/bash

if [ $# -lt 1 ] || [ $# -gt 3 ] ||
  [ "$1" = -h ] || [ "$2" = -h ] || [ "$3" = -h ]
then
  echo "usage: $0 [factor] <input> [output]"
  echo 'strech playback speed'
  exit
fi

if [ -e "$1" ]
then
  # When the first argument already names a file, no factor was given.
  factor=3/4
else
  if [[ "$1" =~ ^[[:digit:]]+([/.][[:digit:]]+)?$ ]]
  then
    factor=$1
    shift
  else
    echo "factor $1 is not numeric"
    exit 1
  fi
fi

ffmpeg -i "$1" \
  -filter:a "atempo=$factor" -filter:v "setpts=PTS/($factor)" \
  -map_metadata 0 "${2-"${1%.*}.streched.${1##*.}"}"
