#!/bin/bash

output() {
  echo "$1"
}
while [ $OPTIND -le $# ]
do
  if getopts 'vh' argument
  then
    case $argument in
      h)
        echo "usage: $0 [file ...]"
        echo 'outputs media duration'
        echo ' -h  show this text'
        echo ' -v  also output file names'
        exit ;;
      v)
        output() {
          echo "$1 $2"
        } ;;
      \?) exit 1 ;;
    esac
  else
    input+=("${!OPTIND}")
    let OPTIND++
  fi
done

for input in "${input[@]}"
do
  output "$(
    ffprobe "$input" 2>&1 | grep -Po '(?<=Duration: )[^,]+(?=,)'
  )" "$input"
done
