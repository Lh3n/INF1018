#include <stdio.h>

struct X1 { int vi; float vf; };
double pack1(struct X1*, int);

int main() {
    struct X1 v[] = {
        {2, 1.0},
        {3, -2.5},
        {-1, 4.0}
    };

    printf("%f\n", pack1(v, 3));
}
