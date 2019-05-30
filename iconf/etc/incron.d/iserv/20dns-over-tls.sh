#!/bin/bash

shopt -s nullglob

if [ -d "/var/lib/iserv/portal/bind.restricted-ips.d" ]
then
  for iplist in /var/lib/iserv/portal/bind.restricted-ips.d/*
  do
    echo "$iplist IN_CLOSE_WRITE /usr/lib/iserv/sleep_exec_once 3 dns-over-tls-update-iplist /usr/lib/iserv/dns-over-tls_update-ipset"
    echo "$iplist IN_OPEN /usr/lib/iserv/sleep_exec_once 3 dns-over-tls-update-iplist /usr/lib/iserv/dns-over-tls_update-ipset"
  done
  echo
fi
