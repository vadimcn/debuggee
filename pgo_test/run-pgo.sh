set -v

cargo rustc --release --  -Ctarget-cpu=native --emit=llvm-ir,asm,link
mv target/release/pgo_test.ll target/release/pgo_test.before.ll
mv target/release/pgo_test.s target/release/pgo_test.before.s
time target/release/pgo_test
time target/release/pgo_test
time target/release/pgo_test

cargo pgo instr run --  -Ctarget-cpu=native

cargo pgo opt rustc --  -Ctarget-cpu=native --emit=llvm-ir,asm,link
time target/release/pgo_test
time target/release/pgo_test
time target/release/pgo_test

set +v
