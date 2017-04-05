#!/bin/sh

mkdir -p /var/lib/varnish/$(hostname) && chown nobody /var/lib/varnish/$(hostname)

# Start varnish or die trying.
varnishd -f /etc/varnish/default.vcl -s malloc,${VARNISH_MEMORY} ${VARNISHD_PARAMS} || exit 1
echo "Varnish started successfully."

# When config.vcl changes, recompile and load new vcl.
while true; do
  if inotifywait -e modify /varnish/config.vcl > /dev/null 2>&1 ; then
    echo "Config changed, recompiling varnish."
    timestamp=$(date +%Y%m%d.%H%M%S)
    varnishadm vcl.load $timestamp /etc/varnish/default.vcl && varnishadm vcl.use $timestamp
  fi
done
