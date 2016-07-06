#![allow(bad_style)]
#![allow(unused)]
#![allow(private_no_mangle_fns)] 
#![feature(test)]
extern crate test;

#[no_mangle]
#[inline(never)]
fn x__________x(label: i32) {
	test::black_box(label);
}

macro_rules! quox {
    () => { let a = 111; }
}

macro_rules! quox2 {
    () => {
        let x = 222;
        quox!();
        let y = 333;
    }
}

#[inline(always)]
fn inlined<T>(x: T) {
    x__________x(101);
    test::black_box(x);
    x__________x(199);
}

#[inline(never)]
fn main() {
    x__________x(0);
    inlined(42);
    x__________x(1);
    quox2!();
    x__________x(2);
    // let x = vec![42];
    // x__________x(4);
    // println!("Hello {}", "world");
    x__________x(999);    
}
