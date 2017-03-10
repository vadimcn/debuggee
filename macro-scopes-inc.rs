
fn included() {
    zzz();
    let x = trivial!(10);
    zzz();
    no_new_scope!(33);
    zzz();
    new_scope!();
    zzz();
}