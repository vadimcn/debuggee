#![feature(test)]
extern crate test;

fn test(iters: u32) {
    let mut m = std::collections::HashMap::<u32, u32>::new();
    for i in 0..iters {
        *m.entry(i % 1000).or_insert(0) += 1;
    }
    test::black_box(m[&400]);
}

fn main() {
    test(200_000_000);
}

#[bench]
fn bench(b: &mut test::Bencher) {
    b.iter(|| test(100_000));
}