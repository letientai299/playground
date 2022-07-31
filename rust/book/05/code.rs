#[derive(Debug)]
struct Rect {
  w: i32,
  h: i32,
}

// try method with struct
impl Rect {
  fn area(&self) -> i32 {
    self.w * self.h
  }
}

fn main() {
  let rect = Rect { w: 10, h: 20 };
  println!("area: {}", rect.area());
  println!("w: {}, h: {}", rect.w, rect.h);
  println!("{:?}", rect);
  println!("{:#?}", rect);
  dbg!(&rect);
}
