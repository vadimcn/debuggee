
TARGET=x86_64-apple-darwin
HASH=836a4172
RUSTLIBS="-L $HOME/NW/rust/build/$TARGET/stage1/lib/rustlib/$TARGET/lib $HOME/NW/rust/build/$TARGET/stage1/lib/rustlib/$TARGET/lib/libstd-$HASH.rlib $HOME/NW/rust/build/$TARGET/stage1/lib/rustlib/$TARGET/lib/libpanic_unwind-$HASH.rlib $HOME/NW/rust/build/$TARGET/stage1/lib/rustlib/$TARGET/lib/libunwind-$HASH.rlib $HOME/NW/rust/build/$TARGET/stage1/lib/rustlib/$TARGET/lib/librand-$HASH.rlib $HOME/NW/rust/build/$TARGET/stage1/lib/rustlib/$TARGET/lib/libcollections-$HASH.rlib $HOME/NW/rust/build/$TARGET/stage1/lib/rustlib/$TARGET/lib/librustc_unicode-$HASH.rlib $HOME/NW/rust/build/$TARGET/stage1/lib/rustlib/$TARGET/lib/liballoc-$HASH.rlib $HOME/NW/rust/build/$TARGET/stage1/lib/rustlib/$TARGET/lib/liballoc_jemalloc-$HASH.rlib $HOME/NW/rust/build/$TARGET/stage1/lib/rustlib/$TARGET/lib/liblibc-$HASH.rlib $HOME/NW/rust/build/$TARGET/stage1/lib/rustlib/$TARGET/lib/libcore-$HASH.rlib"

function link {
    cc -m64 $1 -o $2 -Wl,-dead_strip -nodefaultlibs $RUSTLIBS -L$HOME/NW/cargo-pgo/target/debug -lprofiler-rt -lSystem -lpthread -lc -lm -lcompiler-rt
}


set -v

rm default.profraw pgo.profdata unopt pgo-instr pgo-opt *.bc *.ll *.o

rustc src/main.rs -O --emit=llvm-ir -o n_body.ll

opt n_body.ll -O2 -profile-generate=pgo.profraw -S -o pgo-instr.ll
llc pgo-instr.ll -filetype=obj -o pgo-instr.o
link pgo-instr.o pgo-instr

./pgo-instr 100000
llvm-profdata merge pgo.profraw -output=pgo.profdata

opt n_body.ll -O2 -profile-use=pgo.profdata  -S -o pgo-opt.ll
llc pgo-opt.ll -filetype=obj -o pgo-opt.o
link pgo-opt.o pgo-opt

rustc -O src/main.rs -o unopt
time ./unopt 20000000

time ./pgo-opt 20000000

set +v
