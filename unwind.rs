use std::panic;

fn main() {

    let x = panic::catch_unwind(|| {
        println!("Foo");
        panic!("Всем стоятъ боятъся!!!");
    });
    
    println!("Caught {:?}", x); 
}
