struct Prime {
  cache: Vec<u32>,
}

impl Iterator for Prime {
  type Item = u32;

  fn next(&mut self) -> Option<Self::Item> {
    let last = self.cache.last();
    if last.is_none() {
      self.cache.push(2);
      return Some(2);
    }

    let mut p = *last.unwrap() + 1;
    while self
      .cache
      .iter()
      .filter(|&&x| x * x <= p)
      .any(|&x| p % x == 0)
    {
      p += 1
    }

    self.cache.push(p);
    Some(p)
  }
}

#[cfg(test)]
mod tests {
  use super::*;

  #[test]
  fn first_10_primes() {
    let p = Prime { cache: vec![] };
    for (i, v) in p.take(10).enumerate() {
      println!("prime {i}: {v}");
    }
  }
}
