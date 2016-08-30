set -v

ITERS=50000000

clang++ main.cpp -O2 -std=c++11 -o plain 
time ./plain $ITERS
time ./plain $ITERS
time ./plain $ITERS

clang++ main.cpp -O2 -std=c++11 -fprofile-instr-generate -o instrumented
./instrumented 1000000

xcrun llvm-profdata merge default.profraw -o pgo.profdata
clang++ main.cpp -O2 -std=c++11 -fprofile-instr-use=pgo.profdata -o optimized

time ./optimized $ITERS
time ./optimized $ITERS
time ./optimized $ITERS

set +v
