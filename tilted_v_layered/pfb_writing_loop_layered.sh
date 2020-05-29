#!/bin/bash

#loop for start and stop times as py script args
end_time=200

for d in {1..25}
do
  echo "$d"
  e=$(($d - 1))
  echo "$e"
  time1=$(($end_time * $e))
  time2=$(($end_time * $d))
  ./csv2pfb_automated_layered.py $time1 $time2
  echo "$time1"
  echo "$time2"
done
