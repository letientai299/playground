#[cfg(test)]
mod tests {
  use indoc::indoc;

  #[test]
  fn raw_string() {
    let s = "\
      this is a long\n\
        multiline\n\
      string\
      ";
    println!("{}", s);
  }

  #[test]
  fn raw_string_indo() {
    let s = indoc! {r###"
      #[test]
      fn raw_string() {
        let s = "\
          this is a long\n\
            multiline\n\
          string\
          ";
        println!("{}", s);
      }
    "###};

    println!("{}", s);
  }
}
