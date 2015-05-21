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

echo-exist() {
  if [ "$1" -gt 0 ]
  then
    printf "$2%02d$3" "$1"
  fi
}
echo-exist "$((${result=0} / 360000))" '' :
echo-exist "$(($result / 6000 % 60))" '' :
printf "$(($result / 100 % 60))"
echo-exist "$(($result % 100))" .
echo
