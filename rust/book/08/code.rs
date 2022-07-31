use std::collections::HashMap;

fn main() {
  let mut m = HashMap::new();
  m.insert(String::from("some"), 10);
  m.insert(String::from("thing"), 22);
  println!("{:?}", m);
}
