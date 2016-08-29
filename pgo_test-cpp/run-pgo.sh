set -v

clang++ main.cpp -m64 -O2 -S -o pgo_test.before.s
clang++ main.cpp -m64 -O2 -o pgo_test 
time ./pgo_test
time ./pgo_test
time ./pgo_test

rm *.profraw
clang++ main.cpp -m64 -fprofile-instr-generate -O2 -o pgo_test 
./pgo_test
xcrun llvm-profdata merge default.profraw -o pgo.profdata

clang++ main.cpp -m64 -fprofile-instr-use=pgo.profdata -O2 -S -o pgo_test.s
clang++ main.cpp -m64 -fprofile-instr-use=pgo.profdata -O2 -o pgo_test
time ./pgo_test
time ./pgo_test
time ./pgo_test

set +v
