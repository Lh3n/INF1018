/*
DICIONARIO
%r12d -> nums
%r11d -> temp
%ebx  -> i
*/

.data
Sf: .string "%d\n"

.text
.globl main

main:
    pushq   %rbp
    movq    %rsp, %rbp
    subq    $16, %rsp
    movl    %r12d, -16(%rbp)    # guarda r12d
    movl    %ebx, -12(%rbp)     # guarda i

    movl    $1, %r12d           # nums = 1
    movl    $0, %ebx            # i = 0
    movl    $0, %r11d           # temp = 0

L1:
    cmpl    $9, %ebx           # i < 10
    jg      FORA_FOR

    # temp = nums * nums
    movl    %r12d, %r11d
    imull   %r11d, %r11d

    movq    $Sf, %rdi           # 1º parametro (ponteiro)
    movl    %r11d, %esi         # 2º parametro  (inteiro)
    movl    $0, %eax
    call    printf

    addl    $1, %r12d           # nums++
    addl    $1, %ebx            # i++

    jmp     L1

FORA_FOR:
    movq    $0, %rax
    movl    -16(%rbp), %r12d
    movl    -12(%rbp), %ebx
    leave
    ret      
