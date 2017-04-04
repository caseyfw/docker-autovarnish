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

include "/varnish/config.vcl";

sub vcl_init {
}

sub vcl_recv {
}
