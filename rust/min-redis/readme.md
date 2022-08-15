- `tokio::sync::Mutex` is an `async` `Mutex` that is locked across call to
  `await`. Normally, use `std::sync::Mutex` is fine when only locking within 1
  `await`.

- For echo server, `tokio::io::copy()` is faster than manual byte buffer
  handling (mean time 20.5 ms vs 25.3 ms). Tested via
  ```
  $ hyperfine 'cat Cargo.lock | nc 127.0.0.1 8989'
  ```
