#include <stdio.h>

void foo (int a[], double b[], int n) {
  int *pint;
  double *pdouble;

  for (pint = a, pdouble = b; n-- ; pint++, pdouble++) {
    *pdouble = (double)*pint * 2.0;
  }
}

double boo (double v);

int main() {
  printf("%f\n",boo(1.0));
  return 0;
}