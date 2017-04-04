#!/bin/sh

mkdir -p /var/lib/varnish/$(hostname) && \
chown nobody /var/lib/varnish/$(hostname)

echo "Success!"
