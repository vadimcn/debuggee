use std::panic;

fn bar() {
    println!("bar");
    panic!("Всем стоятъ боятъся!!!");
}

fn foo() {
    println!("foo");
    bar();
}

fn main() {

    let x = panic::catch_unwind(|| {
        println!("closure");
        foo();
        println!("closure after");
    });
    
    let x = x.err().unwrap();
    let y = x.downcast_ref::<&str>().unwrap();  
    println!("caught `{}`", y); 
}
