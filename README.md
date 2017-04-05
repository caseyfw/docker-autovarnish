# caseyfw/autovarnish

Varnish 4 image that updates automatically when its config is changed.

## Usage

Volume a directory containing your custom `config.vcl` into `/varnish` - e.g.

```
docker run --detach --volume ${PWD}:/varnish --publish 80:80 caseyfw/autovarnish
```

Now any changes made to `config.vcl` will result in a vcl.load and vcl.use in
the container.

If you're having problems, you may find the log output useful - it will output
unsuccessful VCL compilations if they occur.

```
docker logs -f autovarnish
```

## Sample config.vcl file

The following `config.vcl` would result in requests for /my-app-path being
directed to 172.17.0.1:8080.

```
backend my_app {
  .host = "172.17.0.1";
  .port = "8080";
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
```
