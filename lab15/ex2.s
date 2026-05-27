/*
float foo1 (float a, float b) {
  return sin(a) + b;
}
*/

.text
.globl foo1
foo1:
    pushq   %rbp
    movq    %rsp, %rbp
    subq    $16, %rsp
    movss   %xmm1, -8(%rbp)     # guarda b

    cvtss2sd    %xmm0, %xmm0    # converte a pra double
    call        sin             # chama sen(a)
    cvtsd2ss    %xmm0, %xmm0    # converte a pra float

    movss       -8(%rbp), %xmm1     # recupera b
    addss       %xmm1, %xmm0        # sen(a) + b
    leave
    ret
