#![allow(unused)]

macro_rules! trivial {
    ($e1:expr) => ($e1)
}

macro_rules! no_new_scope {
    ($e1:expr) => (($e1 + 2) - 1)
}

macro_rules! new_scope {
    () => ({
        let a = 890242;
        zzz(); // #break
        sentinel();
    })
}

macro_rules! shadow_within_macro {
    ($e1:expr) => ({
        let a = $e1 + 2;

        zzz(); // #break
        sentinel();

        let a = $e1 + 10;

        zzz(); // #break
        sentinel();
    })
}


macro_rules! dup_expr {
    ($e1:expr) => (($e1) + ($e1))
}


fn main() {

    let a = trivial!(10);
    let b = no_new_scope!(33);

    zzz(); // #break
    sentinel();

    new_scope!();

    zzz(); // #break
    sentinel();

    shadow_within_macro!(100);

    zzz(); // #break
    sentinel();

    let c = dup_expr!(10 * 20);



    zzz(); // #break
    sentinel();
 
    included();
    sentinel();
}

include!("macro-scopes-inc.rs"); 

fn zzz() {()}
fn sentinel() {()}
 