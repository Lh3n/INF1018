.data
nums:  .int  10, -21, -30, 45
Sf:    .string "%d\n"     # string de formato para printf

.text
.globl  main
main:

/********************************************************/
/* mantenha este trecho aqui e nao mexa - prologo !!!   */
  pushq   %rbp
  movq    %rsp, %rbp
  subq    $16, %rsp
  movq    %rbx, -8(%rbp)
  movq    %r12, -16(%rbp)
/********************************************************/

  movl  $0, %ebx       # i = 0
  movq  $nums, %r12    # p = nums

L1:
  cmpl  $4, %ebx       # if (i == 4) ?
  je    L2             # sai do loop

  movl  (%r12), %eax   # eax = *p
  movl  %eax, %edx     # salva cópia em edx (não perder valor)

  andl  $1, %edx       # edx = (*p & 1)
  jne   skip_print     # se != 0, número é ímpar → pula

  # se chegou aqui, é par → imprime
  movq  $Sf, %rdi      # primeiro argumento: formato
  movl  %eax, %esi     # segundo argumento: valor *p
  call  printf

skip_print:
  addl  $1, %ebx       # i++
  addq  $4, %r12       # p++
  jmp   L1             # volta para o loop

L2:
/***************************************************************/
/* mantenha este trecho aqui e nao mexa - finalizacao!!!!      */
  movq  $0, %rax       # valor de retorno da main
  movq  -8(%rbp), %rbx
  movq  -16(%rbp), %r12
  leave
  ret
/***************************************************************/