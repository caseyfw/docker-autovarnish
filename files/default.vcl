vcl 4.0;

import directors;
import std;

# Required to satisfy varnish's insatiable need for something to do.
backend first {
    .host = "172.17.0.1";
    .port = "8080";
}

include "/varnish/config.vcl";

sub vcl_init {
}

sub vcl_recv {
}
