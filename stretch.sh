#!/bin/bash

# Parse arguments.
while [ $OPTIND -le $# ]
do
  if getopts 'ho:s:()' argument
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
      \()
        while [ "${!OPTIND}" != '-)' ]
        do
          if [ $OPTIND -ge $# ]
          then
            echo "$0: -( without -)"
            exit 1
          fi
          pass+=("${!OPTIND}")
          let OPTIND++
        done
        let OPTIND++
        ;;
      \))
        echo "$0: -) without -("
        exit 1 ;;
      \?) exit 1 ;;
    esac
  else
    inputs+=("$(realpath "${!OPTIND}")")
    let OPTIND++
  fi
done
: ${output="\$name.stretched.\$ext"}

# Compose filtergraph.
filter="setpts=PTS/(${factor=4/3});"
while [ $(bc <<< "$factor >= .5") -ne 1 ]
do
  filter+='atempo=.5,'
  factor="$(bc -l <<< "$factor * 2")"
done
while [ $(bc <<< "$factor <= 2") -ne 1 ]
do
  filter+='atempo=2,'
  factor="$(bc -l <<< "$factor / 2")"
done
filter+="atempo=$factor"

# Encode.
for input in "${inputs[@]}"
do
  name="${input##*/}"
  ffmpeg -i "$input" -map_metadata 0 -filter_complex "$filter" \
    "${pass[@]}" "$(env - file="$name" name="${name%.*}" ext="${name##*.}" \
      path="${input%%/*}" envsubst <<< "$output")"
done
