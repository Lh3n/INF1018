.data
nums:   .int 65, -105, 111, 34
Sf:     .string "soma = %d\n"

.text
.globl main
main:
/********************************************************/
/* prólogo - configuração do frame da função main       */
    pushq   %rbp
    movq    %rsp, %rbp
    subq    $16, %rsp
    movq    %rbx, -8(%rbp)     # guarda rbx
    movq    %r12, -16(%rbp)    # guarda r12
/********************************************************/

    movl    $0, %ebx       # i = 0
    movl    $0, %r12d      # s = 0 (usar parte de 32 bits de r12)

L1:
    cmpl    $4, %ebx       # if (i < 4)?
    jge     L2             # se i >= 4, sai do loop

    movslq  %ebx, %rcx     # rcx = i (64 bits, sign-extended)
    imulq   $4, %rcx       # rcx = i * 4 (tamanho de int)
    leaq    nums(%rcx), %rcx  # rcx = endereço de nums[i]
    movl    (%rcx), %eax   # eax = nums[i]
    addl    %eax, %r12d    # s = s + nums[i]

    addl    $1, %ebx       # i++
    jmp     L1

L2:
/********************************************************/
/* imprime o valor de s                                */
    movq    $Sf, %rdi      # primeiro parâmetro: string
    movl    %r12d, %esi    # segundo parâmetro: soma
    movl    $0, %eax       # necessário para printf
    call    printf
/********************************************************/

/********************************************************/
/* finalização - restaura registradores                */
    movq    -8(%rbp), %rbx
    movq    -16(%rbp), %r12
    movq    $0, %rax       # valor de retorno
    leave
    ret
/********************************************************/
