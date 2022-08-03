use std::fmt::{Display, Formatter};

pub mod animal;
pub mod fib;
pub mod list;
pub mod prime;
pub mod raw_str;
pub mod test_macro;
pub mod threads;

fn main() {
  for color in [
    Color {
      red: 128,
      green: 255,
      blue: 90,
    },
    Color {
      red: 0,
      green: 3,
      blue: 254,
    },
    Color {
      red: 0,
      green: 0,
      blue: 0,
    },
  ]
  .iter()
  {
    // Switch this to use {} once you've added an implementation
    // for fmt::Display.
    println!("{}", color);
  }
}

struct Color {
  red: u8,
  green: u8,
  blue: u8,
}

impl Display for Color {
  fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
    write!(
      f,
      "RGB ({r}, {g}, {b}) 0x{r:02X}{g:02X}{b:02X}",
      r = self.red,
      g = self.green,
      b = self.blue
    )
  }
}

#[cfg(test)]
mod tests {
  #[test]
  fn for_iter() {
    let names = vec!["A", "B", "C"];

    for name in names.iter() {
      match name {
        &"A" => println!("found it!"),
        _ => println!("Hello {}", name),
      }
    }

    println!("again ----");

    for name in names {
      match name {
        "A" => println!("found it!"),
        _ => println!("Hello {}", name),
      }
    }
  }
}
