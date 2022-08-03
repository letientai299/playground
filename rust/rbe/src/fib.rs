struct Fib {
  cur: u32,
  next: u32,
}

impl Fib {
  pub fn new() -> Self {
    Self { cur: 0, next: 1 }
  }
}

impl Iterator for Fib {
  type Item = u32;

  fn next(&mut self) -> Option<Self::Item> {
    let cur = self.cur;
    self.cur = self.next;
    self.next = cur + self.cur;
    Some(self.cur)
  }
}

#[cfg(test)]
mod tests {
  use super::*;

  #[test]
  fn fib() {
    let f = Fib::new();
    f.take(10)
      .enumerate()
      .for_each(|(i, x)| println!("Fib[{i}] = {x}"));
  }
}
