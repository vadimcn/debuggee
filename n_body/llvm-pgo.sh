set -v
ITERS=20000000

cargo rustc --release -vv --  --emit=llvm-ir,asm,link
mv target/release/n_body target/release/unopt
mv target/release/n_body.ll target/release/n_body.unopt.ll
mv target/release/n_body.s target/release/n_body.unopt.s

cargo pgo clean
cargo pgo instr run -- 100000

cargo pgo opt rustc -vv -- --emit=llvm-ir,asm,link

time target/release/unopt $ITERS
time target/release/n_body $ITERS

set +v
