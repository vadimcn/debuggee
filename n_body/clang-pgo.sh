set -v

LIBS="-L /usr/local/google/home/vadimcn/NW/rust/build/x86_64-unknown-linux-gnu/stage1/lib/rustlib/x86_64-unknown-linux-gnu/lib -Wl,-Bstatic -Wl,-Bdynamic /usr/local/google/home/vadimcn/NW/rust/build/x86_64-unknown-linux-gnu/stage1/lib/rustlib/x86_64-unknown-linux-gnu/lib/libstd-836a4172.rlib /usr/local/google/home/vadimcn/NW/rust/build/x86_64-unknown-linux-gnu/stage1/lib/rustlib/x86_64-unknown-linux-gnu/lib/libpanic_unwind-836a4172.rlib /usr/local/google/home/vadimcn/NW/rust/build/x86_64-unknown-linux-gnu/stage1/lib/rustlib/x86_64-unknown-linux-gnu/lib/libunwind-836a4172.rlib /usr/local/google/home/vadimcn/NW/rust/build/x86_64-unknown-linux-gnu/stage1/lib/rustlib/x86_64-unknown-linux-gnu/lib/librand-836a4172.rlib /usr/local/google/home/vadimcn/NW/rust/build/x86_64-unknown-linux-gnu/stage1/lib/rustlib/x86_64-unknown-linux-gnu/lib/libcollections-836a4172.rlib /usr/local/google/home/vadimcn/NW/rust/build/x86_64-unknown-linux-gnu/stage1/lib/rustlib/x86_64-unknown-linux-gnu/lib/librustc_unicode-836a4172.rlib /usr/local/google/home/vadimcn/NW/rust/build/x86_64-unknown-linux-gnu/stage1/lib/rustlib/x86_64-unknown-linux-gnu/lib/liballoc-836a4172.rlib /usr/local/google/home/vadimcn/NW/rust/build/x86_64-unknown-linux-gnu/stage1/lib/rustlib/x86_64-unknown-linux-gnu/lib/liballoc_jemalloc-836a4172.rlib /usr/local/google/home/vadimcn/NW/rust/build/x86_64-unknown-linux-gnu/stage1/lib/rustlib/x86_64-unknown-linux-gnu/lib/liblibc-836a4172.rlib /usr/local/google/home/vadimcn/NW/rust/build/x86_64-unknown-linux-gnu/stage1/lib/rustlib/x86_64-unknown-linux-gnu/lib/libcore-836a4172.rlib -l dl -l pthread -l gcc_s -l pthread -l c -l m -l rt -l util"

cargo rustc --release -- --emit llvm-bc

opt -O2 -pgo-instr-gen -instrprof target/release/n_body.bc -o pgo.bc

llc -O2 -filetype=obj pgo.bc
clang -O2 -flto -fprofile-instr-generate pgo.o $LIBS -o pgo-instr
./pgo-instr 100000

llvm-profdata merge -output=pgo.profdata default.profraw

opt -O2 -pgo-instr-use -pgo-test-profile-file=pgo.profdata target/release/n_body.bc -o pgo-opt.bc
llc -O2 -filetype=obj pgo-opt.bc
clang -O2 -flto -fprofile-instr-use=pgo.profdata pgo-opt.o $LIBS -o pgo-opt

rustc -O src/main.rs
time ./main 20000000

time ./pgo-opt 20000000

set +v
