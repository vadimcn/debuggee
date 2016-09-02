
set -v

rm n_body*

LINK=`rustc src/main.rs -O -o n_body-rustc -Zprint-link-args`

rustc src/main.rs --emit=llvm-ir -o n_body.ll
opt n_body.ll -O2 -S -o n_body-opt.ll
llc n_body-opt.ll -filetype=obj -o n_body-opt.o
eval ${LINK/n_body-rustc.0.o/n_body-opt.o} -o n_body-opt

time ./n_body-rustc 20000000
time ./n_body-opt 20000000

set +v
