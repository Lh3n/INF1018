/*
double foo2 (float a, float b) {
  return sin(a) + cos(b);
}

DICIONARIO
reg     val
%xmm0   flaot a
%xmm1   float b
%xmm2   double temp
*/

.text
.globl foo2

foo2:
    pushq   %rbp
    movq    %rsp, %rbp
    subq    $16, %rsp

    # converte 'a' de float para double e armazena temporariamente na pilha
    cvtss2sd    %xmm0, %xmm0
    movsd       %xmm0, -8(%rbp)
    call        sin
    movsd       %xmm0, -16(%rbp)    # guarda sin(a) na pilha



    # converte 'b' de float para double
    cvtsd2ss    %xmm1, %xmm0        # %xmm0 = (double)b
    call        cos                 # %xmm0 = cos(b)



    # recupera sin(a) e soma
    movsd       -16(%rbp), %xmm2    # %xmm2 = sin(a)
    addsd       %xmm2, %xmm0        # %xmm0 = sin(a) + cos(b)

    leave
    ret
