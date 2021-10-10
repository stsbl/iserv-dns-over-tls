#!/bin/sh


if [ ! -f "/usr/share/iserv/iconf/etc/resolvconf/update.d/bind/20portal" ]
then
  cat /usr/share/iserv/dns-over-tls/scripts/resolvconf-update-bind
fi
