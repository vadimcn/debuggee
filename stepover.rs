#![allow(bad_style)]
#![allow(unused)]
#![allow(private_no_mangle_fns)] 
#![feature(test)]
extern crate test;

#[macro_use]
#[path = "stepover_macros.rs"]
mod macros;

#[no_mangle]
#[inline(never)]
fn x__________x(label: i32) {
	test::black_box(label);
}

macro_rules! foo {
    () => { let a = 111; }
}

macro_rules! foo2 {
    () => {
        let x = 222;
        foo!();
        let y = 333;
    }
}

#[inline(always)]
fn inlined<T>(x: T) {
    x__________x(101);
    test::black_box(x);
    x__________x(199);
}

#[inline(always)]
fn inlined2<T>(x: T) {
    x__________x(201);
    inlined(x);
    x__________x(299);
}

#[inline(never)]
fn main() {
    x__________x(0);
    foo2!();
    x__________x(1);
    bar2!();
    // x__________x(2);
    // let x = vec![42];
    // test::black_box(x);
    // x__________x(4);
    // println!("Hello {}", "world");
    x__________x(999);    
}
