use crate::ShirtColor::Blue;
use crate::ShirtColor::Red;

fn main() {
  #[derive(Debug)]
  struct Rect {
    width: u32,
    height: u32,
  }

  let list = [
    Rect {
      width: 100,
      height: 20,
    },
    Rect {
      width: 20,
      height: 10,
    },
    Rect {
      width: 30,
      height: 30,
    },
  ];

  let new_list = list.iter().map(|r| Rect {
    width: r.height,
    height: r.width,
  });

  let new_list = dbg!(new_list);
  println!("{:?}", new_list);
}

#[derive(PartialEq, Debug)]
enum ShirtColor {
  Red,
  Blue,
}

struct Store {
  shirts: Vec<ShirtColor>,
}

impl Store {
  fn give(&self, want: Option<ShirtColor>) -> ShirtColor {
    want.unwrap_or_else(|| self.most_stocked())
  }

  fn most_stocked(&self) -> ShirtColor {
    let mut num_red = 0;
    let mut num_blue = 0;
    for c in &self.shirts {
      if c == &Red {
        num_red += 1;
      } else {
        num_blue += 1;
      }
    }

    if num_red > num_blue {
      Red
    } else {
      Blue
    }
  }
}

fn try_store() {
  let store = Store {
    shirts: vec![Blue, Red, Blue],
  };

  let user_pref1 = Some(Red);
  let given1 = store.give(user_pref1);
  dbg!(given1);

  let given2 = store.give(None);
  dbg!(given2);
}
