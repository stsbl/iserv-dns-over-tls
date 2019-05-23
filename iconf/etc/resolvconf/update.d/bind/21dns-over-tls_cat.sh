#!/bin/sh


if [ ! -f "/usr/share/iserv/iconf/etc/resolvconf/update.d/bind/20portal" ]
then
  if [ -f "$FN.distrib" ]
  then
    cat "$FN.distrib"
  else
    echo "Template missing" >&2
    exit 1
  fi
fi
