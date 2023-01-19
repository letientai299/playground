#![cfg_attr(
    all(not(debug_assertions), target_os = "windows"),
    windows_subsystem = "windows"
)]

#[macro_use]
extern crate lazy_static;

use rodio::{Decoder, OutputStream, Sink, Source};
use std::collections::HashSet;
use std::error::Error;
use std::fs::File;
use std::io::BufReader;
use std::ops::Sub;
use std::sync::mpsc::{channel, Receiver};
use std::sync::Mutex;
use std::thread;
use std::time::{Duration, Instant};
use tauri::api::notification::Notification;
use tauri::Window;

// the payload type must implement `Serialize` and `Clone`.
#[derive(Clone, serde::Serialize, serde::Deserialize)]
struct Payload {
    seconds: u64,
    id: String,
}

const TIMER_EVENT: &str = "timer-event";

lazy_static! {
    static ref DISPOSED: Mutex<HashSet<String>> = Mutex::new(HashSet::new());
}

#[tauri::command]
async fn stop_countdown(_: Window, id: String) {
    DISPOSED.lock().unwrap().insert(id);
}

#[tauri::command]
async fn start_countdown(
    app: tauri::AppHandle,
    window: Window,
    seconds: u64,
    total: String,
    id: String,
) {
    let rx = countdown(Duration::from_secs(seconds), &id);
    for d in rx {
        println!("remaining: {}", d.as_millis());

        let res = window.emit(
            TIMER_EVENT,
            Payload {
                seconds: d.as_secs(),
                id: id.clone(),
            },
        );

        if let Err(e) = res {
            eprintln!("fail to send remaining time to GUI, err={:?}", e);
        }
    }

    if is_disposed(&id) {
        return;
    }

    let mp3_path = app.path_resolver().resolve_resource("noti.mp3").unwrap();
    let mp3 = mp3_path.to_str().unwrap();

    if let Err(e) = notify(&app, mp3, total.as_str()) {
        eprintln!("fail to play notification sound, err={}", e);
        return;
    }

    // ideally, we should stop righ there as the timer finished. However, when running in
    // background, the distance between each loop keep increasing due to some (unsure) OS power
    // saving. Hence, we can't be sure that the frontend get last timer event to reset the GUI
    // state. So, we keep sending ZERO event, wait for stop_countdown trigger.
    while !is_disposed(&id) {
        spin_sleep::sleep(Duration::from_secs(1));
        let _ = window.emit(
            TIMER_EVENT,
            Payload {
                seconds: 0,
                id: id.clone(),
            },
        );
    }
}

fn main() {
    println!("hello world some");
    tauri::Builder::default()
        .invoke_handler(tauri::generate_handler![start_countdown, stop_countdown])
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}

fn is_disposed(id: &String) -> bool {
    DISPOSED.lock().unwrap().contains(id)
}

fn countdown(d: Duration, id: &String) -> Receiver<Duration> {
    let mut d = d;
    let (tx, rx) = channel::<Duration>();
    let id = id.clone();
    eprintln!("Starting timer {} of duration {}ms", id, d.as_millis());

    thread::spawn(move || {
        let mut pre = Instant::now();
        while d.as_secs() > 0 {
            if is_disposed(&id) {
                eprintln!("Stopping timer {}", id);
                drop(tx);
                return;
            }

            let elapsed = pre.elapsed();
            if d < elapsed {
                break;
            }
            d = d.sub(elapsed);
            pre = Instant::now();

            // offset some ms for other logic.
            let mut sleep = Duration::from_millis(998);
            if sleep > d {
                sleep = d;
            }

            spin_sleep::sleep(sleep);
            if let Err(e) = tx.send(d) {
                println!("fail to send, err={}", e);
            }
        }

        if let Err(e) = tx.send(Duration::ZERO) {
            println!("fail to send, err={}", e);
        }
    });

    rx
}

fn notify(app: &tauri::AppHandle, path: &str, total: &str) -> Result<(), Box<dyn Error>> {
    let msg = format!("Timer of {} finished", total);
    Notification::new(&app.config().tauri.bundle.identifier)
        .title("Timer finished")
        .body(msg)
        .show()?;
    play_sound(path)?;
    Ok(())
}

fn play_sound(path: &str) -> Result<(), Box<dyn Error>> {
    println!("Playing sound");
    // we don't use the _stream, but if we don't keep a variable for it,
    // it will be dropped (due to Rust ownership, I guess), lead to NoDevice err.
    let (_stream, stream_handle) = OutputStream::try_default()?;
    let file = BufReader::new(File::open(path)?);
    let source = Decoder::new_mp3(file)?.repeat_infinite();
    let sink = Sink::try_new(&stream_handle)?;
    sink.set_volume(5.0);
    sink.append(source);
    thread::sleep(Duration::from_secs(5));
    Ok(())
}
