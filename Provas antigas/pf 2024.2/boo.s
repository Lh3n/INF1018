/*
float boo(double d, float bias) {
    int i;
    struct exam temp[5];
    for (i=0; i<5; i++) {
        temp[i].val = inv(d);
        temp[i].tipo = i;
    }
    return temp[0].val + bias;
}

Dicionario
xmm0 -> double d
xmm1 -> float bias
%ecx -> int i
*/

.text
.globl boo
boo:
    pushq   %rbp
    movq    %rsp, %rbp
    subq    $64, %rsp
    movsd   %xmm0,-24(%rbp)             # xmm0 -> mem
    movss   %xmm1,-16(%rbp)             # xmm1 -> mem
    movl    $0, %ecx                    # i = 0
    movl    %ecx, -12(%rbp)             # i -> mem
LFOR:
    cmpl    $5, %ecx                    # i < 5
    jge     LEND
    call    inv
    cvtsd2ss    %xmm0, %xmm0

    movl    -12(%rbp), %ecx             # ecx = i
    movslq  %ecx, %rcx                  # rcx = i(64 bits)
    leaq    -64(%rbp), %rdx             # rdx = endereco base de temp[0]
    movss   %xmm0, (%rdx, %rcx, 8)      # temp[i].val = inv(d)

    movl    %ecx, 4(%rdx, %rcx, 8)      # temp[i].tipo = i

    addl    $1, %ecx                    # i++
    movl    %ecx, -12(%rbp)             # atualiza i
    movsd   -24(%rbp), %xmm0            # restaura xmm0
    movss   -16(%rbp), %xmm1            # restaura xmm1
    jmp     LFOR
LEND:
    movss   -64(%rbp), %xmm0            # temp[0].val -> xmm0
    addss    %xmm1, %xmm0
    leave
    ret
