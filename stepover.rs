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
fn inlined() {
    xxx(31);
    xxx(32);
    xxx(33);
}

#[inline(never)]
fn main() {
    xxx(10);
    inlined();
    xxx(20);
    quox!(1);
    xxx(30);
}