#include <stdio.h>

void foo(double *vd, int n);   // protótipo da função em assembly

int main() {
    double v[] = {3.14, -2.0, 5.5, 42.0};
    int n = 4;

    printf("Vetor antes:\n");
    for (int i = 0; i < n; i++) {
        printf("  v[%d] = %.2f\n", i, v[i]);
    }

    foo(v, n);   // chama a função escrita em assembly

    printf("\nVetor depois de foo:\n");
    for (int i = 0; i < n; i++) {
        printf("  v[%d] = %.2f\n", i, v[i]);
    }

    return 0;
}
