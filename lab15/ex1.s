/*
float foo (double a, float b) {
  return (a+b)*(a-b);
}
*/

.text
.globl foo
foo:
    pushq   %rbp
    movq    %rsp, %rbp

    cvtss2sd    %xmm1, %xmm1
    movsd       %xmm0, %xmm2
    addsd       %xmm1, %xmm2    # %xmm2 = a + b
    subsd       %xmm1, %xmm0    # %xmm0 = a - b
    mulsd       %xmm2, %xmm0    # %xmm0 = (a+b)*(a-b)
    cvtsd2ss    %xmm0, %xmm0
    leave
    ret
