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

DICIONARIO
%xmm0   double(*a)
%xmm1   double r
%esi    int n
*/

.text
.globl foo3

foo3:
    pushq %rbp
    movq %rsp, %rbp
    subq $16, %rsp


    movl $0, %r10d
    cvtsi2sd %r10d, %xmm1       # double r = 0.0

    movsd %xmm1, -8(%rbp)       # salvando r na pilha

    movl $0, %r12d              # r12d = i = 0

FOR:
    cmpl %esi, %r12d
    jge FIM

    movsd (%rdi), %xmm0         # %xmm0 = *a
    call sin                    # xmm0 = sin(*a)

    movsd  -8(%rbp), %xmm1      # restaura r
    addsd %xmm0, %xmm1          # xmm1 = r + sin(*a)
    movsd %xmm1, -8(%rbp)       # guarda novo r

    addq $8, %rdi               # a++
    addl $1, %r12d              # i++
    jmp FOR

FIM:
    movsd -8(%rbp), %xmm0 
    leave
    ret
