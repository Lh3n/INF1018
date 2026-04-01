.data
s1: .string "ls -ls"

.text
.globl main
main:
/* prologo */
    pushq   %rbp
    movq    %rsp, %rbp

/* chamada a system("ls -ls") */
    movq    $s1, %rdi     # primeiro parâmetro: endereço da string
    movl    $0, %eax      # limpar %rax (chamada variádica)
    call    system        # chama a função system

/* retorno 0 (main deve retornar 0) */
    movl    $0, %eax

/* finalizacao */
    leave
    ret
