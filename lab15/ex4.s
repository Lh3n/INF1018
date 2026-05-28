/*
double foo3 (double *a, int n) {
  int i;
  double r = 0.0;
  for (i=0; i<n; i++) {
    r += sin(*a);
    a++;
  }
  return r;
}
*/
/*
DIC
%rdi -> *a
%esi -> n
%ecx -> i
*/

.text
.globl foo3
foo3:
    pushq   %rbp
    movq    %rsp, %rbp
    subq    $16, %rsp

    pxor    %xmm1, %xmm1    # r = 0.0
    movl    $0, %ecx        # i = 0

    movsd   %xmm1, -16(%rbp)    # salva r

LFor:
    cmpl    %esi, %ecx      # i >= n
    jge     Lend

    movsd (%rdi), %xmm0     # *a -> %xmm0
    call    sin

    movsd   -16(%rbp), %xmm1    # recupera r
    addsd   %xmm0, %xmm1        # r += sin(a)
    movsd   %xmm1, -16(%rbp)    # salva novo r

    addq    $8, %rdi    # a++
    incl    %ecx        # i++

    jmp     LFor

Lend:
    movsd   %xmm1, %xmm0
    leave
    ret
