fn main() {
    let is = [1, 2, 4, 1, 3, 21];
    println!("Largest of {:?} is {}", is, top(&is).unwrap());

    let fs = [1.0, 123.1, 0.23, 12.];
    println!("Largest of {:?} is {}", fs, top(&fs).unwrap());

    let s = "some string here";
    let c = *top(s.as_bytes()).unwrap() as char;
    println!("Largest of {:?} is {}", s, c);

    println!("{}", greet(true).hi());
    println!("{}", greet(false).hi());

    let u = "some";
    println!("longer is '{}'", longer(s, u));
    dbg!(some_string());
}

fn top<T: PartialOrd>(arr: &[T]) -> Option<&T> {
    if arr.len() == 0 {
        return None;
    }

    let mut r = &arr[0];
    for v in arr {
        if r < v {
            r = v;
        }
    }

    return Some(r);
}

trait Hi {
    fn hi(&self) -> String;
}

struct Person {}

impl Hi for Person {
    fn hi(&self) -> String { String::from("Hello") }
}

struct Cat {}

impl Hi for Cat {
    fn hi(&self) -> String { String::from("Meow") }
}

fn greet(human: bool) -> Box<dyn Hi> {
    if human {
        Box::new(Person {})
    } else {
        Box::new(Cat {})
    }
}

fn longer<'a>(a: &'a str, b: &'a str) -> &'a str {
    if a.len() > b.len() { a } else { b }
}

// won't work, &str doesn't own the memory, it's just a reference,
// need an "owned type", i.e. String.
// fn some_str() -> &'static str {
//     let s = String::from("some_str");
//     s.as_str()
// }

fn some_string() -> String {
    String::from("some_string")
}
