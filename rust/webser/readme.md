# Building web server/service in Rust

This project use [systemfd](https://github.com/mitsuhiko/systemfd) to pair with
`cargo-watch` for auto reload the server.

- `systemfd` creates and keep socket alive
- `cargo-watch` rebuilds and restarts the project on code change and pass it the
  old sockets.

```sh
$ systemfd --no-pid -s http::5000 -- cargo watch -x run
```
