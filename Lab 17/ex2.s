/*
double foo (double a, int b) {
  return a * (-b);
}
*/

.globl foo
foo:
  pushq       %rbp
  movq        %rsp, %rbp

  negl        %esi            # b = -b
  cvtsi2sd    %esi, %xmm1     # xmm1 = (double) (-b)
  mulsd       %xmm1, %xmm0    # xmm0 = a * xmm1

  popq        %rbp
  ret
