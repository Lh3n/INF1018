#include <stdio.h>

int main (void) {
  int nums = 1;
  int temp = 0;
  for (int i = 0; i < 10; i++) {
    temp = nums * nums;
    printf("numero = %d\n", temp);
    nums++;
  }
  return 0;
}