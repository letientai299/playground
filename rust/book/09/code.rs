use std::fs::File;
use std::{fs, io};
use std::io::Read;

const FILE: &str = "./code.rs";

fn main() {
    let fns = [read_file, read_file_2, read_file_3, read_file_4];
    let pick = 4;
    let s = fns[pick - 1]().expect("fail to read file");
    println!("{}", s);
}

fn read_file_4() -> Result<String, io::Error> {
    fs::read_to_string(FILE)
}


fn read_file_3() -> Result<String, io::Error> {
    let mut s = String::new();
    File::open(FILE)?
        .read_to_string(&mut s)?;
    Ok(s)
}

fn read_file_2() -> Result<String, io::Error> {
    let mut s = String::new();
    File::open(FILE)
        .map(|mut f| {
            let _ = f.read_to_string(&mut s);
            s
        })
}

fn read_file() -> Result<String, io::Error> {
    let mut f = File::open(FILE).expect("Failed to open code.rs");
    let mut s = String::new();
    match f.read_to_string(&mut s) {
        Ok(_) => Ok(s),
        Err(e) => Err(e),
    }
}
