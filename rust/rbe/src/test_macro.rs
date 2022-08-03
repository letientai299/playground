use std::ops::Add;

fn sum_two<T>(x: T, y: T) -> T
where
  T: Add<Output = T>,
{
  x + y
}

#[cfg(test)]
mod tests {
  use super::*;

  #[test]
  fn simple_test() {
    assert_eq!(sum_two(1, 2), 3);
    assert_eq!(sum_two(1.0, 2_f32), 3_f32);
  }

  // failed attempt to create table driven test via macro.
  macro_rules! tab_test {
    ($id: ident=($input: literal, $want: literal), $f: expr) => {
      #[test]
      fn $id() {
        $f($input, $want);
      }
    };

    (
      $id: ident=($input: literal, $want: literal),
      $($s: ident=($i: literal, $w: literal)),+
      $body: expr
    ) => {
      tab_test!($id=($input, $output), $body);
      tab_test!($($s=($i, $w)),+, $body);
    };
  }

  tab_test!(simple_1 = ("some", "more"), |input, want| println!(
    "{} -- {}",
    input, want
  ));

  // doesn't work
  // tab_test!(
  //   simple_1 = ("some", "more"),
  //   simple_2 = ("some", "more"),
  //   |input, want| println!(
  //   "{} -- {}",
  //   input, want
  // ));
}
