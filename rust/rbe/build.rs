macro_rules! p {
    ($($tokens: tt)*) => {
        println!("cargo:warning={clear}{msg}",
        clear ="\x08".repeat(9),
        msg = format!($($tokens)*))
    }
}

pub fn main() {
  println!(
    "cargo:warning={}[Debug] Hello from build.rs",
    "\x08".repeat(9)
  );
  p!("Hello again from build.rs");
}
