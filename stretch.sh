#!/bin/bash

if [ $# -lt 2 ] || [ $# -gt 3 ] ||
  [ "$1" = -h ] || [ "$2" = -h ] || [ "$3" = -h ]
then
  echo "usage: $0 <factor> <input> [output]"
  echo 'strech playback speed'
  exit
fi

if ! [[ "$1" =~ ^[[:digit:]]+([/.][[:digit:]]+)?$ ]]
then
  echo "factor $1 is not numeric"
  exit 1
fi

ffmpeg -i "$2" -filter:a "atempo=$1" -filter:v "setpts=PTS/($1)" \
  -map_metadata 0 "${3-"${2%.*}.streched.${2##*.}"}"
