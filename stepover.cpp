extern "C" {
__attribute__((noinline)) 
void x_____x(int x) {
	__asm("");
}
}

__attribute__((always_inline))
void inlined() {
    x_____x(101);
    {
        x_____x(102);
        {
            x_____x(103);
        }
    }
}

__attribute__((always_inline))
void inlined2() {
    x_____x(201);
    inlined();
    x_____x(202);
}

__attribute__((noinline)) 
int main() {
    x_____x(10);
    inlined();
    x_____x(20);
    int a = 0;
    inlined2();
    x_____x(30);
}