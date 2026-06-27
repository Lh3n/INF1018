#include <stdio.h>

float passa_alta(short *v, int limite);
int foo(short *v, int n, long filtro);

float passa_alta(short *v, int limite) {
    return (*v) * limite;
}

int main(void) {
    short v[] = {1, 5, 10, 3, 8, 12};
    int n = sizeof(v) / sizeof(v[0]);
    long filtro = 4;

    int resultado = foo(v, n, filtro);

    printf("resultado = %d\n", resultado);

    return 0;
}