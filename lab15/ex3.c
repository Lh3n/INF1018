#include <stdio.h>

#define M_PI 3.14159265358979323846
#define M_PI_2 (M_PI/2.0)

double foo2(float a, float b);

int main(void){
    float n1 = M_PI_2;
    float n2 = M_PI;

    printf("resultado: %f\n", foo2(n1, n2));
    return 0;
}