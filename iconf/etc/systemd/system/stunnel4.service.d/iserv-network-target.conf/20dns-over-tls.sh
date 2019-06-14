#!/bin/bash

echo "[Unit]"

IFs=($(netquery -p if))
WANTS=""
AFTER=""

while read IF
do
  WANTS+="iserv-network-interface-$IF.target "
  AFTER+="iserv-network-interface-$IF.target "
done < <(echo ${IFs[@]} | tr ' ' '\n' | sort -u)

if [ -x "/usr/sbin/netquery6" ]
then
  IFs=($(netquery6 -gul nic))
  while read IF
  do
    WANTS+="iserv-network6-interface-$IF.target "
    AFTER+="iserv-network6-interface-$IF.target "
  done < <(echo ${IFs[@]} | tr ' ' '\n' | sort -u)
fi

echo "Wants=$WANTS"
echo "After=$AFTER"
echo

