Example Timer app from Tauri.

TODO:

- [ ] Make the timer works accurately when running in background
  - The problem is probably because rust thread sleep is not accurate. Tried
    [`spin_sleep`](https://crates.io/crates/spin_sleep), but it's not enough.
    Need to separate the timing with event sending as well. Need something like
    goroutine.
- [ ] Bug: currently, if we reset, start a new timer, the background thread
      runing `countdown` is not killed, thus, wasting resources.
- [ ] Handle sleeping/shutting down state
- [ ] Integrate with MacOS menu bar.
- [ ] Multiple concurrent timer
