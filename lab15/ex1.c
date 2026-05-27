#include <stdio.h>

float foo(double a, float b);

int main(void){
    double n1 = 5.0;
    float n2 = 5.0f;
    printf("resultado: %f\n", foo(n1, n2));
    return 0;
}