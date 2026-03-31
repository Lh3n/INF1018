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
  movl  $0, %r13d      # sum = 0 (usar %r13d como acumulador)

L1:
  cmpl  $4, %ebx       # if (i == 4) ?
  je    L2             # sai do loop se i == 4

  movl  (%r12), %eax   # eax = *p
  addl  %eax, %r13d    # sum += *p

  addl  $1, %ebx       # i++
  addq  $4, %r12       # p++
  jmp   L1             # volta para o loop

L2:
  # printf("%d\n", sum)
  movq  $Sf, %rdi      # primeiro argumento: formato
  movl  %r13d, %esi    # segundo argumento: sum
  call  printf

/***************************************************************/
/* mantenha este trecho aqui e nao mexa - finalizacao!!!!      */
  movq  $0, %rax       # valor de retorno da main
  movq  -8(%rbp), %rbx
  movq  -16(%rbp), %r12
  leave
  ret
/***************************************************************/