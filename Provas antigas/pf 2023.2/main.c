#include <stdio.h>

// protótipo da função feita em assembly
long int boo(int *a, int n);

// função corta simples apenas para teste
int corta(int v[], int i) {
    // só devolve v[i] mesmo (bobo, mas suficiente para testar)
    return v[i];
}

int main(void) {
    int vetor[] = {10, 20, 30, 40, 50};
    int n = 5;

    long int r = boo(vetor, n);

    printf("Resultado: %ld\n", r);

    return 0;
}
