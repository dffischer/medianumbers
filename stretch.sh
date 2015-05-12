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
    inputs+=("$(realpath "${!OPTIND}")")
    let OPTIND++
  fi
done

# Encode.
for input in "${inputs[@]}"
do
  name="${input##*/}"
  ffmpeg -i "$input" \
    -filter:a "atempo=${factor=4/3}" -filter:v "setpts=PTS/($factor)" \
    -map_metadata 0 "$(env - file="$name" name="${name%.*}" ext="${name##*.}" \
      path="${input%%/*}" envsubst <<< "${output-"\$name.stretched.\$ext"}")"
done
