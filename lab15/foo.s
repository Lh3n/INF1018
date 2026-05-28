/*
void foo (int a[], double b[], int n) {
  int *pint;
  double *pdouble;

  for (pint = a, pdouble = b; n-- ; pint++, pdouble++) {
    *pdouble = (double)*pint * 2.0;
  }
}
*/
/*
DIC
rdi -> a[]
rsi -> b[]
edx -> n
*/

.text
.globl foo
foo:
    pushq   %rbp
    movq    %rsp, %rbp

