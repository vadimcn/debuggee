LIBS="-L /usr/local/google/home/vadimcn/NW/rust/build/x86_64-unknown-linux-gnu/stage1/lib/rustlib/x86_64-unknown-linux-gnu/lib -Wl,-Bstatic -Wl,-Bdynamic /usr/local/google/home/vadimcn/NW/rust/build/x86_64-unknown-linux-gnu/stage1/lib/rustlib/x86_64-unknown-linux-gnu/lib/libstd-836a4172.rlib /usr/local/google/home/vadimcn/NW/rust/build/x86_64-unknown-linux-gnu/stage1/lib/rustlib/x86_64-unknown-linux-gnu/lib/libpanic_unwind-836a4172.rlib /usr/local/google/home/vadimcn/NW/rust/build/x86_64-unknown-linux-gnu/stage1/lib/rustlib/x86_64-unknown-linux-gnu/lib/libunwind-836a4172.rlib /usr/local/google/home/vadimcn/NW/rust/build/x86_64-unknown-linux-gnu/stage1/lib/rustlib/x86_64-unknown-linux-gnu/lib/librand-836a4172.rlib /usr/local/google/home/vadimcn/NW/rust/build/x86_64-unknown-linux-gnu/stage1/lib/rustlib/x86_64-unknown-linux-gnu/lib/libcollections-836a4172.rlib /usr/local/google/home/vadimcn/NW/rust/build/x86_64-unknown-linux-gnu/stage1/lib/rustlib/x86_64-unknown-linux-gnu/lib/librustc_unicode-836a4172.rlib /usr/local/google/home/vadimcn/NW/rust/build/x86_64-unknown-linux-gnu/stage1/lib/rustlib/x86_64-unknown-linux-gnu/lib/liballoc-836a4172.rlib /usr/local/google/home/vadimcn/NW/rust/build/x86_64-unknown-linux-gnu/stage1/lib/rustlib/x86_64-unknown-linux-gnu/lib/liballoc_jemalloc-836a4172.rlib /usr/local/google/home/vadimcn/NW/rust/build/x86_64-unknown-linux-gnu/stage1/lib/rustlib/x86_64-unknown-linux-gnu/lib/liblibc-836a4172.rlib /usr/local/google/home/vadimcn/NW/rust/build/x86_64-unknown-linux-gnu/stage1/lib/rustlib/x86_64-unknown-linux-gnu/lib/libcore-836a4172.rlib -l dl -l pthread -l gcc_s -l pthread -l c -l m -l rt -l util"


set -v

rm default.profraw pgo.profdata unopt pgo-instr pgo-opt *.bc *.ll *.o

rustc src/main.rs -O --emit=llvm-ir -o n_body.ll

#opt -O2 -profile-generate n_body.ll -S -o pgo.ll
#llc -filetype=obj pgo.ll
#clang -O2 -fprofile-instr-generate pgo.o $LIBS -o pgo-instr
rustc src/main.rs -O -o pgo-instr -Cllvm-args=-profile-generate=pgo.profraw -Lnative=/usr/local/google/home/vadimcn/NW/cargo-pgo/target/debug -Clink-args=-lprofiler-rt

#-Clink-args="-L/usr/local/google/home/vadimcn/ll/build/lib/clang/4.0.0/lib/linux -lclang_rt.profile-x86_64"

./pgo-instr 100000
llvm-profdata merge pgo.profraw -output=pgo.profdata

# opt -O2 -profile-use=pgo.profdata n_body.ll -S -o pgo-opt.ll
# llc -filetype=obj pgo-opt.ll
# clang -O2 pgo-opt.o $LIBS -o pgo-opt
# #rustc -O -Cllvm-args=-profile-use=pgo.profdata src/main.rs -o pgo-opt

# rustc -O src/main.rs -o unopt
# time ./unopt 20000000

# time ./pgo-opt 20000000

set +v
