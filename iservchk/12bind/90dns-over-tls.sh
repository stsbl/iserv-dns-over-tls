#!/bin/sh

ServiceName=named

if [ "$(iservdebianrelease)" = "buster" ]
then
  ServiceName=bind9
fi

if ! [ -f "/usr/share/iserv/iconf/etc/resolvconf/update.d/bind/20portal" ] && [ -f "/etc/resolvconf/update.d/bind.distrib" ]
then
  echo "Check /etc/resolvconf/update.d/bind"
  echo "Start ${ServiceName} named"
  echo "Start ${ServiceName}-resolvconf"
  echo
fi
