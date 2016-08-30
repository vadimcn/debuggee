set -v
ITERS=50000000

cargo rustc --release -vv --  -Ctarget-cpu=native --emit=llvm-ir,asm,link
mv target/release/n_body.ll target/release/n_body.before.ll
mv target/release/n_body.s target/release/n_body.before.s
time target/release/n_body $ITERS
time target/release/n_body $ITERS
time target/release/n_body $ITERS

cargo pgo clean
cargo pgo instr run --  -Ctarget-cpu=native

cargo pgo opt rustc -vv --  -Ctarget-cpu=native --emit=llvm-ir,asm,link
time target/release/n_body $ITERS
time target/release/n_body $ITERS
time target/release/n_body $ITERS

set +v
