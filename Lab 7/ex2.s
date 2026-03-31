.data
S2:    .byte 65, 108, 111, 32, 123, 103, 97, 108, 101, 114, 97, 125, 33, 0
Sf:    .string "%c"
Sf2:   .string "\n"

.text
.globl  main
main:

/********************************************************/
  pushq   %rbp
  movq    %rsp, %rbp
  subq    $16, %rsp
  movq    %rbx, -8(%rbp)
  movq    %r12, -16(%rbp)
/********************************************************/

  movq  $S2, %r12       /* r12 = &S2 */

L1:
  cmpb  $0, (%r12)      /* if (*pc == 0)? */
  je    L2              /* fim do loop */

  movsbl (%r12), %eax   /* eax = *r12, estendido p/ 32 bits */

/* Testa se caractere é '{' (123) */
  cmpl  $123, %eax
  je    SkipPrint       /* se for, pula a impressão */

/* Testa se caractere é '}' (125) */
  cmpl  $125, %eax
  je    SkipPrint       /* se for, pula a impressão */

/* Imprime o caractere */
  movq   $Sf, %rdi
  movl   %eax, %esi
  movl   $0, %eax
  call   printf

SkipPrint:
  addq  $1, %r12        /* pc++ */
  jmp   L1              /* repete loop */

L2:
/* imprime o \n */
  movq   $Sf2, %rdi
  movl   $0, %eax
  call   printf

/********************************************************/
  movq  $0, %rax
  movq  -16(%rbp), %r12
  movq  -8(%rbp), %rbx
  leave
  ret
/********************************************************/
