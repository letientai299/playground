#[cfg(test)]
mod tests {
  use std::thread;

  #[test]
  fn try_threads() {
    let mut kids = vec![];

    for id in 0..10 {
      kids.push(thread::spawn(move || {
        println!("Message from thread {}, {:?}", id, thread::current().id());
      }));
    }

    for k in kids {
      k.join().expect("TODO: panic message");
    }
  }
}
