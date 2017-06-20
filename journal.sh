#! /bin/sh

t="5"
u="minutes"

if [ $# -gt 0 ]; then
   echo $1
   t=$1
fi

if [ $# -gt 1 ]; then
   echo $2
   u=$2
fi

journalctl  --since `date +%T --date="-$t $u"`
