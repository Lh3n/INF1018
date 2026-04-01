.text
.globl foo
foo:
    # Prologo
    pushq   %rbp
    movq    %rsp, %rbp
    subq    $16, %rsp        # espaço para variáveis locais
    movl    %esi, -4(%rbp)   # n
    movq    %rdi, -16(%rbp)  # a (endereço base)

    movl    $0, -8(%rbp)     # s = 0
    movl    $0, -12(%rbp)    # i = 0

L1: # for (i < n)
    movl    -12(%rbp), %eax  # i
    cmpl    -4(%rbp), %eax   # compara i com n
    jge     Lend             # se i >= n, fim

    # calcular endereço de a[i]
    movslq  -12(%rbp), %rcx  # rcx = i (64 bits)
    movq    -16(%rbp), %rdx  # rdx = base de a
    movl    (%rdx,%rcx,4), %eax  # eax = a[i]

    # s += a[i]
    addl    %eax, -8(%rbp)

    # if (a[i] == 0)
    cmpl    $0, %eax
    jne     L2

    # a[i] = s
    movl    -8(%rbp), %eax
    movl    %eax, (%rdx,%rcx,4)

    # s = 0
    movl    $0, -8(%rbp)

L2: # incremento do for
    addl    $1, -12(%rbp)
    jmp     L1

Lend:
    leave
    ret
