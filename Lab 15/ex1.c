#include <stdio.h>

float foo(double a, float b);

int main() {
    double a = 5.0;
    float  b = 2.0f;

    float r = foo(a, b);

    printf("foo(%f, %f) = %f\n", a, b, r);

    return 0;
}