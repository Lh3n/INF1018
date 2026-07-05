#include <stdio.h>

double inv(double val);
float boo(double d, float bias);

double inv(double val){
    return val;
}

int main(void) {
    double d = 4;
    float bias = 4.0f;
    float resultado = boo(d, bias);
    printf("resultado = %f\n", resultado);
    return 0;
}