#![allow(unused)]

use std::collections::HashMap;

enum RegularEnum {
    A(i32),
    B(i32),
    C(i64)
}

enum CStyleEnum {
    A = 0,
    B = 1,
    C = 2
}

struct TupleStruct<'a>(i32, &'a str, f32);

fn main() {
    let i = 0;
    let z = 1.0;
    let x = (1, "a", 42.0);
    let x2 = &(1, "a", 42.0);
    let re = RegularEnum::A(322);
    let ce = CStyleEnum::B;
    let opt1: Option<&str> = Some("some");
    let opt2: Option<&str> = None;
    let ts = TupleStruct(3, "xxx", -3.0);
    let a = "string slice";
    let b = "string".to_owned();
    let c = vec![1,2,3,4,5,6,7,8,9,10];
    let d = vec!["111", "2222", "3333", "4444", "5555"];
    // let mut vikings = HashMap::new();
    // vikings.insert("Einar", 25);
    // vikings.insert("Olaf", 24);
    // vikings.insert("Harald", 12);
    println!("---");
}