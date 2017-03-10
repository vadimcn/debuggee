fn factorial(n: i32) -> i32 {
    if n == 0 {
        1
    } else {
        n * factorial(n-1)
    }
}

fn main() {
    println!("10! = {}", factorial(10));
}
