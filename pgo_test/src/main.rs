#![feature(test)]
#![allow(private_no_mangle_fns)]
extern crate test;

#[no_mangle]
#[inline(never)]
fn foo() { test::black_box(1); }

#[no_mangle]
#[inline(never)]
fn bar() { test::black_box(2); }

#[no_mangle]
#[inline(never)]
fn runit(iters: u32) {
    for i in 0..iters {
        if i % 256 == 0 {
            foo();
        } else {
            bar();
        }
    }
}

fn main() {
    runit(1000000000);
}

#[bench]
fn bench_main(b: &mut test::Bencher) {
    b.iter(|| runit(10000000));
}
