use std::env;
 
fn main() {
    let mut entries = Vec::new();

    let mut args = env::args().skip(1);
    let high = args.next().unwrap().parse::<i32>().unwrap();

    for arg in args {
        let parts: Vec<&str> = arg.split(":").collect();
        let divisor = parts[0].parse::<i32>().unwrap();
        let word = parts[1].to_string();
        entries.push((divisor, word));
    }
 
    for i in 1..(high + 1) {
        let mut line = String::new();
        for &(divisor, ref word) in &entries {
            if i % divisor == 0 {
                line = line + &word;
            }
        }
        if line.is_empty() {
            println!("{}", i);
        } else {
            println!("{}", line);
        }
    }
}
