#!/bin/bash

number='[[:digit:]]{1,2}'
for arg
do
  if [ "$arg" == -h ]
  then
    echo "usage: $0 [hh:mm:ss.ff ...]"
    echo 'add up timespans'
    exit
  elif  [[ "$arg" =~ ^((($number):)?($number):)?($number)(\.($number))?$ ]]
  then
    let "result+= \
      360000 * 10#${BASH_REMATCH[3]:-0} + \
      6000 * 10#${BASH_REMATCH[4]:-0} + \
      100 * 10#${BASH_REMATCH[5]} + \
      10#${BASH_REMATCH[7]:-0}"
  else
    echo "$0: $arg is not in hh:mm:ss.ff format"
    exit 1
  fi
done

printf '%02i:%02i:%02i.%02i\n' \
  "$((${result=0} / 360000))" \
  "$(($result / 6000 % 60))" \
  "$(($result / 100 % 60))" \
  "$(($result % 100))" \
| sed 's/^[0:]\{0,7\}//;s/\(.0\)\?0$//'
