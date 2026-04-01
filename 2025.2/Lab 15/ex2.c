#include <stdio.h>
#include <math.h>

float foo1(float a, float b);

int main(){
    float a, b;
    a = 3.14f;
    b = 1.0f;

    printf("resultado: %f\n", foo1(a,b)); // saída esperada: 2
}