/*
double foo (int v[], int n) {
 double m = 1.0;
 int i;
 int indice;
 for(i=0; i< n; i++) {
 indice = calculaIndice(i);
 m *= trata(v[indice]);
 }
 return m;
}
*/

.text
.globl foo
foo:
    pushq       %rbp
    movq        %rsp, %rbp
    subq        $16, %rsp
    movl        $1, %r10d
    cvtsi2sd    %r10d, %xmm1
    movsd       %xmm1, -8(%rbp)
    movl        $0, -12(%rbp)
    movl        $0, -16(%rbp)
    movl        %esi, %r12d
    movq        %rdi, %r11

Loop:
    cmpl    %r12d, -12(%rbp) 
    jge     Lend
    movl    -12(%rbp), %edi
    call    calculaIndice
    movl    %eax, -16(%rbp)
    movl    -16(%rbp), %ecx
    movl    (%r11, %rcx, 4), %edi
    call    trata
    movsd   -8(%rbp), %xmm1
    mulsd   %xmm0, %xmm1
    movsd   %xmm1, -8(%rbp)
    incl    -12(%rbp)
    jmp     Loop

Lend:
    movsd   -8(%rbp), %xmm0
    leave
    ret
