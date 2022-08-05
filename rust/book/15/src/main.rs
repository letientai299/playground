use std::{
  cell::RefCell,
  ops::{AddAssign, Deref},
};

struct MyBox<T>(T);

impl<T> Deref for MyBox<T> {
  type Target = T;

  fn deref(&self) -> &Self::Target {
    &self.0
  }
}

trait Animal {
  fn say(&self);
}
struct Cat {
  n: RefCell<i32>,
}

impl Cat {
  pub fn new() -> Self {
    Self { n: RefCell::new(0) }
  }

  fn count(&self) {
    println!("Meowed {} times", self.n.borrow());
  }
}

impl Animal for Cat {
  fn say(&self) {
    println!("meow");
    self.n.borrow_mut().add_assign(1);
  }
}

fn main() {
  let x = 5;
  let y = Box::new(x);
  let z = MyBox(x);
  assert_eq!(5, x);
  assert_eq!(5, *y);
  assert_eq!(5, *z);

  let c = Cat::new();
  let animal = &c;
  for _ in 1..=5 {
    animal.say();
  }
  c.count();
}
