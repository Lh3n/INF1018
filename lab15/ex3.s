/*
double foo2 (float a, float b) {
  return sin(a) + cos(b);
}
*/

.text
.globl foo2
foo2:
    pushq   %rbp
    movq    %rsp, %rbp
    subq    $16, %rsp

    cvtss2sd    %xmm0, %xmm0        #converte para double a
    cvtss2sd    %xmm1, %xmm1        #converte para double b

    movsd       %xmm1, -8(%rbp)     #salva b
    call        sin
    
    movsd       %xmm0, -16(%rbp)    #salva sin(a)
    movsd       -8(%rbp), %xmm0     #recupera b
    call        cos

    movsd       -16(%rbp), %xmm1    #recupera sin(a)
    addsd       %xmm1, %xmm0        #sin(a) + cos(b)
    leave
    ret
