    .text
    .globl fat
fat:
    pushq   %rbp
    movq    %rsp, %rbp
    subq    $16, %rsp         # espaço para variáveis locais

    movl    %edi, -4(%rbp)    # salva n em variável local

    cmpl    $0, %edi
    jne     Lrec
    movl    $1, %eax          # retorna 1 se n==0
    jmp     Lend

Lrec:
    movl    -4(%rbp), %eax    # eax = n
    subl    $1, %eax
    movl    %eax, %edi        # prepara argumento fat(n-1)
    call    fat
    movl    -4(%rbp), %ecx    # recupera n em ecx
    imull   %ecx, %eax        # eax = n * fat(n-1)

Lend:
    leave
    ret
