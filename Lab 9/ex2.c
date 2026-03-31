#include <stdio.h>

int fat(int n);

int main(void) {
    for (int i = 0; i <= 5; i++) {
        printf("fat(%d) = %d\n", i, fat(i));
    }
    return 0;
}
