#include <stdio.h>

int g(char *s1, char *s2);

int i = 0;
int k = 0;
char s1[] = "ola";
char s2[] = " mundo";

int f(char *p) {
  return 1;
}

int main() {
  int j = g(s1, s2);
  printf("%d\n", k); //exibe o valor de k que é 0
 }
