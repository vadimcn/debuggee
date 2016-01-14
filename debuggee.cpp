#include <stdio.h>
#include <thread>
#include <string>
#include <vector>

struct Foo {
    int a;
    std::string b;
};


int baz(int n) {
    printf("baz %d start\n", n);
    
    printf("baz %d end\n", n);
}

int bar(int n) {
    printf("bar %d start\n", n);
    baz(n);
    printf("bar %d end\n", n);
}

int foo(int n) {
    printf("foo %d start\n", n);
    int a = n;
    float b = n;
    std::string c = "3333";
    Foo d = { 42, "Foo" };
    int e[] = { 1, 2, 3, 4, 5 };
    std::vector<int> f = {1, 2, 3, 4, 5};
    bar(n);
    printf("foo %d end\n", n);
}

void thread_proc() {
    printf("thread_proc start\n");
    foo(2);
    printf("thread_proc end\n");
}

int main() {
    printf("main start\n");
    auto thread = std::thread(thread_proc);
    foo(1);
    thread.join();
    printf("main end\n");
    return 0;
}