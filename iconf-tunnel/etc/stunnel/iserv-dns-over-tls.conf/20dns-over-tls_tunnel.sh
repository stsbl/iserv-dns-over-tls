#!/bin/bash

COUNT=1

while read ip
do
  echo "[dns_tls$COUNT]"
  echo "accept = $ip:853"
  echo "connect = $ip:53"
  echo "cert = /etc/ssl/certs/iserv.combined"
  echo "key = /etc/ssl/private/iserv.key"
  echo
  let COUNT++
done < <(netquery -p ip)

if [ -x "$(which netquery6)" ]
then
  while read ip
  do
    echo "[dns_tls$COUNT]"
    echo "accept = $ip:853"
    echo "connect = $ip:53"
    echo "cert = /etc/ssl/certs/iserv.combined"
    echo "key = /etc/ssl/private/iserv.key"
    echo
    let COUNT++
done < <(netquery6 -gul ip)

fi
