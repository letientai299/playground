use std::io;

fn main() {
  let mut count = 5;
  let mut tmp = 0;

  let sum = loop {
    println!("loop: count is {count}");
    tmp += count;
    count -= 1;
    if count <= 0 {
      break tmp;
    }
  };

  println!("loop: sum={sum}");

  count = 5;
  tmp = 0;
  while count > 0 {
    println!("while: count is {count}");
    count -= 1;
  }

  count = 5;
  for c in (1..=count).rev() {
    println!("for: count is {c}");
  }
}

fn try_index() {
  let a = [1, 2, 3];
  println!("The array: {a:?}");

  let mut index = String::new();
  println!("Enter an index to print its value: ");
  io::stdin()
    .read_line(&mut index)
    .expect("fail to read string");

  let index: usize = index.trim().parse().expect("Must be a valid index");
  println!("a[{index}] = {}", a[index]);
}
