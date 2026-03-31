.text
.globl add
add:
    /* prólogo padrão */
    pushq %rbp
    movq  %rsp, %rbp

    /* parâmetros:
       a → %edi
       b → %esi
       c → %edx
    */

    movl  %edi, %eax     # eax = a
    addl  %esi, %eax     # eax += b
    addl  %edx, %eax     # eax += c

    /* valor de retorno já está em %eax */
    popq  %rbp
    ret
