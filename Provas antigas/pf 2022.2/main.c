#include <stdio.h>

extern double foo(int v[], int n);
extern double trata(int u);

int calculaIndice(int valor) {
    return valor;
}

int main() {
    int v[] = {10, 2, 5};
    int n = 3;

    // Cálculo Esperado:
    /*
    i = 0: indice = calculaIndice(0) = 0. m *= trata(v[0]) = 1.0 * trata(10) = 10.0
    i = 1: indice = calculaIndice(1) = 1. m *= trata(v[1]) = 10.0 * trata(2) = 20.0
    i = 2: indice = calculaIndice(2) = 2. m *= trata(v[2]) = 20.0 * trata(5) = 100.0
    Resultado esperado: 100.0
    */

    double resultado = foo(v, n);
    printf("Resultado de foo: %f\n", resultado);
    return 0;
}