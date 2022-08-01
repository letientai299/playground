extern crate core;

use std::error::Error;
use std::{env, fs};

pub fn run(config: Config) -> Result<(), Box<dyn Error>> {
  let contents = fs::read_to_string(config.filename)?;

  let lines = if config.ignore_case {
    search_case_insensitive(&config.query, &contents)
  } else {
    search(&config.query, &contents)
  };

  for line in lines {
    println!("{}", line);
  }

  Ok(())
}

fn search<'a>(query: &str, contents: &'a str) -> Vec<&'a str> {
  contents
    .lines()
    .filter(|line| line.contains(query))
    .collect()
}

fn search_case_insensitive<'a>(query: &str, contents: &'a str) -> Vec<&'a str> {
  let q = &query.to_lowercase();
  contents
    .lines()
    .filter(|line| line.to_lowercase().contains(q))
    .collect()
}

pub struct Config {
  query: String,
  filename: String,
  ignore_case: bool,
}

impl Config {
  pub fn new(args: &[String]) -> Result<Config, &'static str> {
    if args.len() < 3 {
      return Err("not enough arguments");
    }

    let query = args[1].clone();
    let filename = args[2].clone();
    Ok(Self {
      query,
      filename,
      ignore_case: env::var("IGNORE_CASE").is_ok(),
    })
  }
}

#[cfg(test)]
mod tests {
  use super::*;
  use std::{assert_eq, vec};

  #[test]
  fn case_sensitive() {
    let query = "duct";
    let contents = "\
Rust:
safe, fast, productive.
Pick three.";

    assert_eq!(vec!["safe, fast, productive."], search(query, contents));
  }

  #[test]
  fn case_insensitive() {
    let query = "rUsT";
    let contents = "\
Rust:
safe, fast, productive.
Pick three.
Trust me.";

    assert_eq!(
      vec!["Rust:", "Trust me."],
      search_case_insensitive(query, contents)
    );
  }
}
