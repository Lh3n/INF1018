/*
DICIONARIO
%rsi    a
%ecx    i
%edi    num
*/

.text
.globl bemboba

bemboba:
    pushq   %rbp
    movq    %rsp, %rbp
    sub     $32, %rsp

    leaq    -16(%rbp), %rsi
    movl    $0, %ecx

Lloop:
    cmpl    $4, %ecx        # compara i com 4
    jge     Lend_loop       # se i >= 4, sai do Lloop

    movl    %edi, (%rsi)    # *a = num
    addq    $4, %rsi        # rsi += 4 (proximo inteiro)

    incl    %ecx            # i++
    jmp     Lloop

Lend_loop:
    leaq    -16(%rbp), %rdi
    movl    $4, %esi
    call    addl

    addq    $32, %rsp
    popq    %rbp
    ret
