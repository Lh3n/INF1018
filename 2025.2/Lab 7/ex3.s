.data
Sf:   .string "%d\n"     # string de formatação para printf

.text
.globl main
main:
/********************************************************/
/* prólogo - configuração do frame da função main       */
    pushq   %rbp
    movq    %rsp, %rbp
    subq    $16, %rsp
    movq    %rbx, -8(%rbp)
/********************************************************/

    movl    $1, %ebx        # i = 1

L1:
    cmpl    $10, %ebx       # if (i <= 10)?
    jg      L2              # se i > 10, sai do loop

    movl    %ebx, %eax      # eax = i
    imull   %eax, %eax      # eax = eax * eax (quadrado)

/*************************************************************/
/* imprime o valor de %eax                                   */
    movq    $Sf, %rdi       # primeiro parâmetro: ponteiro p/ string
    movl    %eax, %esi      # segundo parâmetro: inteiro (quadrado)
    movl    $0, %eax        # necessário para chamadas variádicas
    call    printf
/*************************************************************/

    addl    $1, %ebx        # i++
    jmp     L1              # repete o loop

L2:
/********************************************************/
/* finalização - restaura valores salvos                */
    movq    -8(%rbp), %rbx
    movq    $0, %rax        # valor de retorno da main = 0
    leave
    ret
/********************************************************/
