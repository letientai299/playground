Example Timer app from Tauri.

TODO:

- [x] Make the timer works accurately when running in background

  - The problem is probably because rust thread sleep is not accurate. Tried
    [`spin_sleep`](https://crates.io/crates/spin_sleep), but it's not enough.
    Need to separate the timing with event sending as well. Need something like
    goroutine.

  - Try `spin_sleep` with `channel` in Rust to move the communication to GUI
    our of the sleep, also implemnet some duration adjustment logic within the
    sleep loop.

  - Alert sound is played in the Rust side for accuracy.

  - Noti and alert are somewhat more accurate, but the GUI doesn't update when
    the time run to 0 because it can't receive the last even.

- [x] Bug: currently, if we reset, start a new timer, the background thread
      runing `countdown` is not killed, thus, wasting resources.

  - Use a global `HashSet` to store disposed counter ID, then check and drop the
    `Sender` if counter is disposed during the loop. This isn't a good solution.
    Much have some way better.

- [ ] Handle sleeping/shutting down state
- [ ] Integrate with MacOS menu bar.
- [ ] Multiple concurrent timer
- [ ] The editor could be smarter
