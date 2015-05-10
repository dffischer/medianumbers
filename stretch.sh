#!/bin/bash

# Parse arguments.
while [ $OPTIND -le $# ]
do
  if getopts 'ho:s:' argument
  then
    case $argument in
      h)
        echo "usage: $0 [options] <input>"
        echo 'strech playback speed'
        echo ' -h           only shows this help text'
        echo ' -s <factor>  new playback speed as factor of old'
        echo ' -o <output>  output file name'
        exit ;;
      o) output="$OPTARG" ;;
      s)
        if [[ "$OPTARG" =~ ^[[:digit:]]+([/.][[:digit:]]+)?$ ]]
        then
          factor="$OPTARG"
        else
          echo "factor $OPTARG is not numeric"
          exit 1
        fi ;;
      \?) exit 1 ;;
    esac
  else
    if [ -z ${input++} ]
    then
      readonly input="${!OPTIND}"
    else
      echo "$0: too many arguments" >&2
      exit 1
    fi
    let OPTIND++
  fi
done

# Require input.
if [ -z ${input++} ]
then
  echo "$0: no input file given" >&2
  exit 0
fi

# Encode.
ffmpeg -i "$input" \
  -filter:a "atempo=${factor=4/3}" -filter:v "setpts=PTS/($factor)" \
  -map_metadata 0 "${output-"${input%.*}.streched.${input##*.}"}"
