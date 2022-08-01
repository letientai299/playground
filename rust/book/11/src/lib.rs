fn add_two(x: i32) -> i32 { x + 2 }


#[cfg(test)]
mod tests {
    use crate::add_two;

    #[test]
    fn it_works() {
        println!("some output here");
        assert_eq!(4, add_two(2));
    }
}