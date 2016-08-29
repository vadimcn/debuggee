
cargo rustc --release -- --test --emit=llvm-ir,asm,link
mv target/release/pgo_test.ll target/release/pgo_test.before.ll
mv target/release/pgo_test.s target/release/pgo_test.before.s
target/release/pgo_test --bench

cargo pgo clean
cargo pgo instr rustc -- --test --emit=llvm-ir,asm,link
target/release/pgo_test --bench

cargo pgo opt rustc -- --test --emit=llvm-ir,asm,link
target/release/pgo_test --bench
