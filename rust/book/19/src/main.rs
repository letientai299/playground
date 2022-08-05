use std::fmt::{Display, Result};
use std::ops::{Deref, DerefMut};

struct ListView<T>(Vec<T>);

impl<T> DerefMut for ListView<T> {
  fn deref_mut(&mut self) -> &mut Self::Target {
    &mut self.0
  }
}

impl<T> Deref for ListView<T> {
  type Target = Vec<T>;
  fn deref(&self) -> &Self::Target {
    &self.0
  }
}

impl<T: Display> Display for ListView<T> {
  fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> Result {
    let v = &self.0;
    let ss: Vec<String> = v.into_iter().map(|x| x.to_string() + "->").collect();
    write!(f, "{}", ss.join("") + "end")
  }
}

pub fn main() {
  let mut lv = ListView(vec!["a", "b", "c"]);
  println!("{}", lv);
  lv.push("c");
  println!("{}", lv);
}
