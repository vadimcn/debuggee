
__attribute__((noinline))
void foo() {
    asm("nop");
}

__attribute__((noinline))
void bar() {
    asm("nop");
}

int main() {
    for (int i = 0; i < 1000000000; ++i) {
        if (i % 256) 
            foo();
        else
            bar();
    }
    return 0;
}
