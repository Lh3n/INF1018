#include <stdio.h>
#include <math.h>

// Protótipo da função em assembly
double foo2(float a, float b);

int main() {
    float a = 3.14f;
    float b = 1.5f;

    double resultado = foo2(a, b);

    printf("foo2(%f, %f) = %f\n", a, b, resultado);

    return 0;
}
