#include <stdio.h>

#define M_PI 3.14159265358979323846
#define M_PI_2 (M_PI/2.0)

float foo1(float a, float b);

int main(void){
    float n1 = M_PI_2;
    float n2 = 1.0f;

    printf("resultado: %f\n", foo1(n1, n2));
    return 0;
}