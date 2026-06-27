/*
int foo(short *v, int n, long filtro) {
    int i;
    double soma = 0;
    for(i=0; i<n; i++) {
        if(v[i] > filtro) {
            soma += passa_alta(v[i], 3);
        }
    }
}
*/

.text
.globl foo

foo:
    pushq %rbp
    movq  %rsp,%rbp
    subq  $16, %rsp
    pxor  %xmm1,%xmm1      # soma = 0
    movl  $0,%ecx          # i = 0
    movl  %esi, -4(%rbp)  # n -> pilha
    movq  %rdi, -16(%rbp)  # *v -> pilha

Lfor:
    movl  -4(%rbp), %esi    # restaura n antes de comparar
    movq  -16(%rbp), %rdi   # restaura *v antes de indexar

    cmpl  %esi,%ecx        # i < n
    jge   Lfim

    movswq (%rdi,%rcx,2), %rax   # short v[i] -> long %rax
    cmpq  %rdx,%rax        # v[i] > filtro
    jle   Lnext

    movq  %rax,%rdi
    movl  $3,%esi
    call  passa_alta

    cvtss2sd %xmm0,%xmm0  # float -> double
    addsd    %xmm0,%xmm1  # soma += passa_alta()

Lnext:
    incl %ecx             # i++
    jmp  Lfor

Lfim:
    cvttsd2si  %xmm1, %eax
    leave
    ret
