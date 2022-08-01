use minigrep::Config;
use std::{env, process};

fn main() {
  let config = Config::new(env::args()).unwrap_or_else(|e| {
    eprintln!("Problem parsing args: {}", e);
    process::exit(1);
  });

  if let Err(e) = minigrep::run(config) {
    eprintln!("Application error: {}", e);
    process::exit(1);
  }
}
