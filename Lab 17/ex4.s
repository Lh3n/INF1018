/*
double pack1 (struct X1 *px, int n) {
  double acc = 0;
  int i;
  for (i=0;i<n;i++)
    acc += foo(px[i].vf, px[i].vi);
  return acc;
}
*/

.globl pack1

pack1:
    xorpd       %xmm0, %xmm0                        # acc = 0
    xorl        %ecx,  %ecx                         # i = 0

Lloop:
    cmp         %esi, %ecx
    jge         Lend

    movss       4(%rdi, %rcx, 8), %xmm0
    cvtss2sd    %xmm0, %xmm0

    mov         (%rdi, %rcx, 8), %esi

    call        foo

    addsd       %xmm0, %xmm2

    inc         %ecx
    jmp         Lloop

Lend:
    movsd       %xmm2, %xmm0
    ret
