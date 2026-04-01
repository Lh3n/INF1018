#include <stdio.h>
double foo(double, int);

int main() {
    printf("%f\n", foo(2.5, 3));    // -7.5
    printf("%f\n", foo(-1.0, -4));  // -4.0
}
