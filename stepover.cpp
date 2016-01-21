
__attribute__((noinline)) 
void xxx(int x) {
	__asm("");
}

__attribute__((always_inline))
void inlined() {
    xxx(31);
    xxx(32);
    xxx(33);
}

__attribute__((noinline)) 
int main() {
    xxx(10);
    inlined();
    xxx(20);
    //quox!(1);
    //xxx(30);
}