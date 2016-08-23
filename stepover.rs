#![allow(unused)]
#![feature(test)]
extern crate test;

macro_rules! MACRO {
    () => ({
        let a = 890242;
        zzzzzzzzzzzzzzzzzzz(line!()); // #break 
    })
}

macro_rules! MACRO2 {
    ($x:expr) => {
        test::black_box($x)
    }
}

macro_rules! MACRO3 {
    ($x:ident) => {
        fn $x() {
            println!(stringify!($x));
        }
    }
}

fn foo() {
    println!("Foo");
}

macro_rules! MACRO4 {
    ($x:ident, $y:expr) => {
        let $x = $y;
        foo();
    }
}

MACRO3!(expanded);

fn main() {
    MACRO3!(expanded2);

    // let a = 10;
    // let b = 33;
    // zzzzzzzzzzzzzzzzzzz(line!()); // #break
    // MACRO!(); 
    // zzzzzzzzzzzzzzzzzzz(line!()); // #break
    // MACRO2!("Hello");
    // zzzzzzzzzzzzzzzzzzz(line!()); // #break
    // expanded();
    // zzzzzzzzzzzzzzzzzzz(line!()); // #break
    // expanded2();
    // zzzzzzzzzzzzzzzzzzz(line!()); // #break
    // println!("Hello");
    // zzzzzzzzzzzzzzzzzzz(line!()); // #break
    // println!("Hello {}", "world");
    zzzzzzzzzzzzzzzzzzz(line!()); // #break
    MACRO4!(x, 42);
    zzzzzzzzzzzzzzzzzzz(line!()); // #break
}

#[no_mangle]
pub fn zzzzzzzzzzzzzzzzzzz(n:u32) {()}
