#include <stdio.h>

void foo(int a[], int n);

int main(void) {
    int nums[6] = {1, 2, 0, 4, 0, 5};
    int i;

    foo(nums, 6);

    for (i = 0; i < 6; i++) {
        printf("%d ", nums[i]);
    }
    printf("\n");
    return 0;
}
