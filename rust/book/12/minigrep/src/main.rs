use minigrep::Config;
use std::{env, process};

fn main() {
  let args: Vec<String> = env::args().collect();
  let config = Config::new(&args).unwrap_or_else(|e| {
    eprintln!("Problem parsing args: {}", e);
    process::exit(1);
  });

  if let Err(e) = minigrep::run(config) {
    eprintln!("Application error: {}", e);
    process::exit(1);
  }
}
