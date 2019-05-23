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
  echo "[dns_tls_restricted$COUNT]"
  echo "accept = $ip:10853"
  echo "connect = 127.0.0.1:53"
  echo "local = 127.0.3.$COUNT"
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
    echo "[dns_tls_restricted$COUNT]"
    echo "accept = $ip:10853"
    echo "connect = 127.0.0.1:53"
    echo "local = 127.0.3.$COUNT"
    echo "cert = /etc/ssl/certs/iserv.combined"
    echo "key = /etc/ssl/private/iserv.key"
    echo
    let COUNT++
done < <(netquery6 -gul ip)

fi
