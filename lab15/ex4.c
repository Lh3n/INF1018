#include <stdio.h>

#define M_PI 3.14159265358979323846
#define M_PI_2 (M_PI/2.0)


double foo3 (double *a, int n);

int main(void) {
    double v[] = {0.0, M_PI/2, M_PI};
    printf("resultado = %f\n", foo3(v, 3));
    return 0;
}