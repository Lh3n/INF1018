#include <stdio.h>

int boba(float v[], float lim, int n);

int main() {
    float v[] = {1.0, 5.0, 3.2, 8.4, 2.0};
    float lim = 3.0;
    int n = 5;

    int r = boba(v, lim, n);
    printf("Resultado = %d\n", r);
}
