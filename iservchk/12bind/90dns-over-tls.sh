if ! [ -f "/usr/share/iserv/iconf/etc/resolvconf/update.d/bind/20portal" ] && [ -f "/etc/resolvconf/update.d/bind.distrib" ]
then
  echo "Check /etc/resolvconf/update.d/bind"
  echo "Start bind9 named"
  echo "Start bind9-resolvconf"
  echo
fi
