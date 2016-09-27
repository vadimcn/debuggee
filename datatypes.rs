#![allow(unused)]

use std::collections::HashMap;

enum RegularEnum {
    A(i32),
    B(i32, i32),
    C{x:f64, y:f64},
}

enum CStyleEnum {
    A = 0,
    B = 1,
    C = 2
}

enum CompressedEnum<T> {
    Some(T),
    Nothing
}

struct TupleStruct<'a>(i32, &'a str, f32);

struct RegularStruct<'a> {
    a: i32,
    b: &'a str,
    c: f32
}

fn make_hash() -> HashMap<String, i32> {
    let mut vikings = HashMap::new();
    vikings.insert("Einar".into(), 25);
    vikings.insert("Olaf".into(), 24);
    vikings.insert("Harald".into(), 12);
    vikings
}

fn main() {
    // let i = 0;
    // let z = 1.0;
    // let x = (1, "a", 42.0);
    // let x2 = &(1, "a", 42.0);
    let re = RegularEnum::B(100, 200);
    // let ce = CStyleEnum::B;
    let ce1: CompressedEnum<&str> = CompressedEnum::Some("string");
    let ce2: CompressedEnum<&str> = CompressedEnum::Nothing;
    let ts = TupleStruct(3, "xxx", -3.0);
    let rs = RegularStruct { a: 1, b: "b", c: 12.0 };
    let a = "string slice";
    let b = "string".to_owned();
    let c = vec![1,2,3,4,5,6,7,8,9,10];
    let d = vec!["111", "2222", "3333", "4444", "5555"];
    let vs = &d[2..4];
    let h = make_hash();
    println!("---");
}