#include <ctype.h>
#include <stdio.h>

int string2num (char *s, int base) {
  int a = 0;
  for (; *s; s++) {
    if (!isdigit(*s)) break;
    int d = *s - '0';
    if (d >= base) break;
    a = a * base + d;
  }
  return a;
}

int main (void) {
  printf("%d\n", string2num("777", 8));
  printf("%d\n", string2num("777", 10));
  return 0;
}