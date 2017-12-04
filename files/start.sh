#!/bin/sh

mkdir -p /var/lib/varnish/$(hostname) && chown nobody /var/lib/varnish/$(hostname)

# Start varnish or die trying.
varnishd -f /etc/varnish/default.vcl -s malloc,${VARNISH_MEMORY} ${VARNISHD_PARAMS} || exit 1
echo "Varnish started successfully."

# When /varnish/*.vcl changes, recompile and load new vcl.
inotifywait -m -e close_write,moved_to --format %f /varnish |
while read -r file; do
  if [ "${file: -4}" == ".vcl" ]; then
    echo "Config changed, recompiling varnish."
    timestamp=$(date +%Y%m%d.%H%M%S)
    vcl_name="v_${timestamp}"
    varnishadm vcl.load ${vcl_name} /etc/varnish/default.vcl && varnishadm vcl.use ${vcl_name}
  fi
done
