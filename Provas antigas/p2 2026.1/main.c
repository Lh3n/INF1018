#include <stdio.h>

struct S {
    double d;
    int i;
};

float foo(int i, double d);
float bar(double ent, float *sai, int n);

/* Implementação apenas para teste */
float foo(int i, double d) {
    printf("foo(%d, %.2f)\n", i, d);
    return i + d;
}

int main(void) {
    float vet[] = {-2.5f, -3.0f, 4.2f, -1.0f, 5.0f};
    int n = 5;
    double entrada = 10.0;

    printf("Vetor antes:\n");
    for (int i = 0; i < n; i++)
        printf("%.2f ", vet[i]);
    printf("\n");

    float r = bar(entrada, vet, n);

    printf("\nVetor depois:\n");
    for (int i = 0; i < n; i++)
        printf("%.2f ", vet[i]);
    printf("\n");

    printf("\nRetorno de bar = %.2f\n", r);

    return 0;
}