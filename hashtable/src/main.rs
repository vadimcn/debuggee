#![feature(test)]
extern crate test;

fn main() {
    let mut m = std::collections::HashMap::<u32, u32>::new();
    for i in 0..100_000 {
        *m.entry(i % 1000).or_insert(0) += 1;
    }
    test::black_box(m[&400]);
}

#[bench]
fn bench(b: &mut test::Bencher) {
    b.iter(|| main());
}