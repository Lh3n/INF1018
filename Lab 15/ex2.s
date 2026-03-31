/*
float foo1 (float a, float b) {
  return sin(a) + b;
}

DICIONARIO
reg     val
%xmm0   flaot a
%xmm1   float b
*/

.text
.globl  foo1

foo1:
    pushq       %rbp
    movq        %rsp, %rbp

    subq        $16, %rsp       # espaço na pilha para a
    movsd       %xmm1, -8(%rbp)     # guarda o a 

    cvtss2sd    %xmm0, %xmm0        # chama sin com o a do %xmm0
    call        sin     # retorna em double

    cvtsd2ss    %xmm0, %xmm0        # converte devolta para float

    addss       %xmm1, %xmm0        # sin(a) + b

    leave
    ret
