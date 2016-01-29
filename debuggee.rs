#![allow(unused)]

use std::thread;

struct Foo {
    a: u32,
    b: String,
}

enum Bar {
    Bar1,
    Bar2(i32),
    Bar3(String),
}

fn baz(n: i32) {
    println!("baz {} start", n);
    
    println!("baz {} end", n);
}

fn bar(n: i32) {
    println!("bar {} start", n);
    baz(n);
    println!("bar {} end", n);
}

fn foo(n: i32) {
    println!("foo {} start", n);
    let a = n;
    let b = n as f32;
    let c = "3333";
    let d = Foo { a: 42, b: "Foo".to_owned() };
    let e = [1, 2, 3, 4, 5];
    let f = vec![1, 2, 3, 4, 5];
    let g = [Bar::Bar1,
             Bar::Bar2(32),
             Bar::Bar3("DIQUEORUI".to_owned())];
    bar(n);
    println!("foo {} end", n);
}

fn thread_proc() {
    println!("thread_proc start");
    foo(2);
    println!("thread_proc end");
    inf_loop();
}

fn inf_loop() {
    let mut i:i64 = 0;
    loop {
        i += 1;
    }
}

fn main() {
    println!("main start");
    let thread = thread::spawn(thread_proc);
    foo(1);
    //thread.join().unwrap();
    println!("main end");
    inf_loop();
}