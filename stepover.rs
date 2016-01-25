#![allow(bad_style)]
#![feature(test)]
extern crate test;

#[inline(never)]
fn x__________x(x: i32) {
	test::black_box(x);
}

// macro_rules! quox{
//     ($a:expr) => {
// 		x__________x($a + 1);
// 		x__________x($a + 2);
// 		x__________x($a + 3);
//      }
// }

// #[inline]
// fn inlined(x: i32) {
//     x__________x(x+1);
//     x__________x(x+2);
//     x__________x(x+3);
// }

#[inline(never)]
fn main() {
    x__________x(1);
    // x__________x(10);
    // inlined(10);
    // x__________x(20);
    // quox!(20);
    x__________x(30);
    //println!("Hello {}", "world");
    println!("Hello world");
    x__________x(40);
    // println!("Hello {}", "world");
    // x__________x(50);    
}