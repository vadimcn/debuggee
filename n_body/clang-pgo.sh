
set -v

rm pgo.prof* *.bc *.ll *.o n_body*

# plain
LINK=`rustc src/main.rs -Copt-level=3 -o n_body -Zprint-link-args`

# instrumented
rustc src/main.rs -Copt-level=3 -Cllvm-args=-profile-generate=pgo.profraw -Lnative=$HOME/NW/cargo-pgo/target/debug -Clink-args=-lprofiler-rt -o n_body-instr

# rustc src/main.rs -Copt-level=3 --emit=llvm-ir -o n_body.ll 
# opt n_body.ll -O3 -profile-generate=pgo.profraw -S -o pgo-instr.ll
# llc pgo-instr.ll -filetype=obj -o n_body-instr.o
# eval ${LINK/n_body.0.o/n_body-instr.o} -o n_body-instr -L$HOME/NW/cargo-pgo/target/debug -lprofiler-rt

./n_body-instr 100000
llvm-profdata merge pgo.profraw -output=pgo.profdata

# rust pgo
rustc src/main.rs -Copt-level=3 -o n_body-rustc -Cllvm-args=-profile-use=pgo.profdata

# opt pgo
rustc src/main.rs -Copt-level=3 --emit=llvm-ir -o n_body.ll #-Cllvm-args=-profile-use=pgo.profdata
opt n_body.ll -O3 -S -o n_body-opt.ll -profile-use=pgo.profdata
opt n_body-opt.ll -O3 -S -o n_body-opt2.ll
llc n_body-opt2.ll -filetype=obj -o n_body-opt.o
eval ${LINK/n_body.0.o/n_body-opt.o} -o n_body-opt

# multiopt
rustc src/main.rs -Copt-level=3 --emit=llvm-ir -o n_body.ll 
opt n_body.ll -O3 -S -o n_body-multiopt.ll 
opt n_body-multiopt.ll -O3 -S -o n_body-multiopt.ll
llc n_body-multiopt.ll -filetype=obj -o n_body-multiopt.o
eval ${LINK/n_body.0.o/n_body-multiopt.o} -o n_body-multiopt

time ./n_body 20000000
time ./n_body-rustc 20000000
time ./n_body-opt 20000000
time ./n_body-multiopt 20000000

set +v
