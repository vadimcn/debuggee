
macro_rules! bar {
    () => { let a = 555; }
}

macro_rules! bar2 {
    () => {
        let x = 666;
        bar!();
        let y = 777;
    }
}
