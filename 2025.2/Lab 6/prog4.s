.data
nums:  .byte  10, -21, -30, 45
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

  movl  $0, %ebx        # i = 0
  movq  $nums, %r12     # p = nums (endereço do array)

L1:
  cmpl  $4, %ebx        # if (i == 4) ?
  je    L2              # sai do loop

  movsbl (%r12), %eax   # carrega 1 byte com sinal e expande para 32 bits
                        # eax = (int)*p

/*************************************************************/
/* este trecho imprime o valor de %eax (estraga %eax)  */
  movq    $Sf, %rdi     # primeiro argumento: formato
  movl    %eax, %esi    # segundo argumento: valor convertido
  call    printf
/*************************************************************/

  addl  $1, %ebx        # i++
  addq  $1, %r12        # p++ (agora soma 1, não 4)
  jmp    L1

L2:
/***************************************************************/
/* mantenha este trecho aqui e nao mexa - finalizacao!!!!      */
  movq  $0, %rax        # valor de retorno da main
  movq  -8(%rbp), %rbx
  movq  -16(%rbp), %r12
  leave
  ret
/***************************************************************/