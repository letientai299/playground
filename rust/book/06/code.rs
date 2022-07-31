#[derive(Debug)]
enum Message {
  Quit,
  Write(String),
}

fn main() {
  impl Message {
    fn call(&self) {
      dbg!(self);

      fn internal_call() {
        println!("From internal");
      }

      internal_call();
    }
  }

  let m = Message::Write("something else".into());
  m.call();
}
