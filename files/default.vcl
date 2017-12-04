vcl 4.0;

import directors;
import std;

probe health_check {
    .url = "/probe.htm";
    .timeout = 1s;
    .interval = 10s;
    .window = 5;
    .threshold = 3;
}

# Required to satisfy varnish's insatiable need for something to do.
backend default {
    .host = "172.17.0.1";
    .port = "8080";
}

include "/varnish/config.vcl";

sub vcl_init {
}

sub vcl_recv {
}
