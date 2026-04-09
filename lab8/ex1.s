.data
s1: .string "ls -ls"

.text
.globl main
main:
/* prologo */
    pushq   %rbp
    movq    %rsp, %rbp

/* chamada de system("ls -ls") */
    movq    $s1, %rdi
    movl    $0, %eax
    call    system

    movl    $0, %eax        # return 0

/* finalizacao */
    leave
    ret
