#include <stdio.h>

union u1{
    int a;
    int b;
};

union u2{
    int a;
    short b;
};

int main(void){
    union u1 x;
    x.a = 10;
    x.b = 20;
    printf("x.a = %d\n", x.a);
    printf("x.b = %d\n", x.b);

    union u2 y;
    y.a = 0x10001234;
    y.b = 0x20;
    printf("\ny.a = 0x%x\n", y.a);
    printf("y.b = 0x%x\n", y.b);

    return 0;
}