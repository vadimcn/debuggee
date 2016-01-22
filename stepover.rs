#![feature(test)]
extern crate test;

#[inline(never)]
fn xxx(x: i32) {
	test::black_box(x);
}

macro_rules! quox{
    ($a:expr) => {
		xxx($a + 1);
		xxx($a + 2);
		xxx($a + 3);
     }
}

#[inline]
fn inlined(x: i32) {
    xxx(x+1);
    xxx(x+2);
    xxx(x+3);
}

#[inline(never)]
fn main() {
    xxx(1);
    xxx(10);
    inlined(10);
    xxx(20);
    quox!(20);
    xxx(30);
    println!("Hello {}", "world");
    xxx(40);
}