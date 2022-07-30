fn main() {
  let mut s = String::from("some key word here");
  let f = first_word(&s);
  println!("First word of '{s}' is '{f}'");
  s.clear();
  println!("First word of the old s is '{f}'");
}

fn first_word(s: &String) -> String {
  match s.find(' ') {
    Some(i) => s[0..i].into(),
    _ => s.into(),
  }
}
