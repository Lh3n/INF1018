#include <stdio.h>

struct X { int vi; double vd; struct X* next; };

double pack(struct X*);

int main() {
    struct X a = { 2, 1.5, NULL };
    struct X b = { -3, 2.0, &a };
    struct X c = { 5, -1.25, &b };

    printf("%f\n", pack(&c));
}
