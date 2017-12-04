probe health_check {
    .url = "/probe.htm";
    .timeout = 1s;
    .interval = 10s;
    .window = 5;
    .threshold = 3;
}

backend my_app {
  .host = "172.17.0.1";
  .port = "8000";
  .connect_timeout = 1s;
  .first_byte_timeout = 30s;
  .between_bytes_timeout = 10s;
  .max_connections = 10;
  .probe = health_check;
}

sub vcl_recv {
  if (req.url ~ "^/my-app-path") {
    set req.backend_hint = my_app;
  }
}
