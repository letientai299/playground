#![cfg_attr(
    all(not(debug_assertions), target_os = "windows"),
    windows_subsystem = "windows"
)]

use std::time::Duration;
use tauri::Window;

// the payload type must implement `Serialize` and `Clone`.
#[derive(Clone, serde::Serialize, serde::Deserialize)]
struct Payload {
    seconds: u32,
    id: String,
}

const TIMER_EVENT: &str = "timer-event";

fn countdown(seconds: u32, tick: impl Fn(u32)) {
    let mut rem = seconds;
    while rem > 0 {
        let second = Duration::from_secs(1);
        spin_sleep::sleep(second);
        rem -= 1;
        tick(rem)
    }
}

#[tauri::command]
async fn start_countdown(window: Window, seconds: u32, id: String) {
    countdown(seconds, |rem| {
        let _ = window.emit(
            TIMER_EVENT,
            Payload {
                seconds: rem,
                id: id.clone(),
            },
        );
    });
}

fn main() {
    tauri::Builder::default()
        .invoke_handler(tauri::generate_handler![start_countdown])
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}
