#define _USE_MATH_DEFINES
#include <stdio.h>
#include <math.h>

#ifndef M_PI
#define M_PI 3.14159265358979323846
#endif

#ifndef M_PI_2
#define M_PI_2 1.57079632679489661923
#endif

// --- Versão em C ---
double foo3_c(double *a, int n) {
    int i;
    double r = 0.0;
    for (i = 0; i < n; i++) {
        r += sin(*a);
        a++;
    }
    return r;
}

// --- Versão em Assembly ---
double foo3(double *a, int n);  // declarada externamente (em foo3.s)

int main(void) {
    double v[] = {0.0, M_PI_2, M_PI};
    int n = 3;

    double r_c = foo3_c(v, n);
    double r_asm = foo3(v, n);

    printf("=== Teste de foo3 ===\n");
    printf("Soma dos senos (C):      %.6f\n", r_c);
    printf("Soma dos senos (Assembly): %.6f\n", r_asm);
    printf("----------------------------\n");
    printf("Diferença: %.10f\n", fabs(r_c - r_asm));

    return 0;
}