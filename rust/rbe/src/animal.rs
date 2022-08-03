use std::fmt::{Display, Formatter};

trait Animal: Display {
  fn new(name: &'static str) -> Self
  where
    Self: Sized;

  fn name(&self) -> &str;
  fn noise(&self) -> &str;
  fn talk(&self) {
    println!("{} says {}", self.name(), self.noise());
  }

  fn fmt(a: &Self, f: &mut Formatter<'_>) -> std::fmt::Result
  where
    Self: Sized,
  {
    write!(f, "{}", a.name())
  }
}

fn random_animal() -> Box<dyn Animal> {
  if rand::random() {
    Box::new(Cow::new("random cow"))
  } else {
    Box::new(Sheep::new("random sheep"))
  }
}

struct Cow {
  name: &'static str,
}

// impl Drop for Animal {
//   fn drop(&mut self) {
//     println!("Dropping {}", self.name());
//   }
// }

impl Display for Cow {
  fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
    Animal::fmt(self, f)
  }
}

impl Animal for Cow {
  fn new(name: &'static str) -> Self {
    Cow { name }
  }

  fn name(&self) -> &str {
    self.name
  }

  fn noise(&self) -> &str {
    "mooooo!"
  }
}

struct Sheep {
  naked: bool,
  name: &'static str,
}

impl Sheep {
  fn is_naked(&self) -> bool {
    self.naked
  }

  fn sheer(&mut self) {
    if self.is_naked() {
      println!("{} is already naked", self.name());
      return;
    }

    self.naked = true;
    println!("{} gets a haircut!", self.name());
  }
}

impl Display for Sheep {
  fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
    Animal::fmt(self, f)
  }
}

impl Animal for Sheep {
  fn new(name: &'static str) -> Self {
    Sheep { naked: false, name }
  }

  fn name(&self) -> &str {
    self.name
  }

  fn noise(&self) -> &str {
    if self.is_naked() {
      "baaaaah?"
    } else {
      "baaaaah!"
    }
  }
}

#[cfg(test)]
mod tests {
  use super::*;

  #[test]
  fn sheep() {
    let mut s: Sheep = Animal::new("a sheep");
    s.talk();
    s.sheer();
    s.talk();
    s.sheer();
    s.talk();

    random_animal().talk();
    random_animal().talk();
    random_animal().talk();

    println!("{}", s);
    println!("{}", random_animal());
    println!("{}", random_animal());
    println!("{}", random_animal());
  }
}
