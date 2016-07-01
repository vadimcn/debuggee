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

macro_rules! quox{
    ($($a:stmt;)*) => { $($a;)* }
}

macro_rules! quox2{
    ($($a:stmt;)*) => { quox!($($a;)*) }
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
    x__________x(1);
    inlined(10);
    x__________x(2);
    quox2!{
        let a = 1;
    }
    x__________x(3);
    let x = vec![42];
    x__________x(4);
    println!("Hello world");
    x__________x(999);    
}
