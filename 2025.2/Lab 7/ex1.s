#include <stdio.h> 

.data # variaveis globais e strings constrantes
S2: .byte 65, 108, 111, 32, 123, 103, 97, 108, 101, 114, 97, 125, 33, 0
Sf: .string "%c"
MUDA_LINHA: .string "\n"

.text
.globl main
main:

/********************************************************/
/* mantenha este trecho aqui e nao mexa - prologo !!!   */
  pushq   %rbp
  movq    %rsp, %rbp
  subq    $16, %rsp
  movq    %rbx, -8(%rbp)  /* guarda rbx */
  movq    %r12, -16(%rbp)  /* guarda r12 */
/********************************************************/

movq $S2, %rbx
WHILE:
cmpb $0, (%rbx)
je  FORA_WHILE
movsbl (%rbx), %eax

/*************************************************************/
/* este trecho imprime o valor de %eax (estraga %eax)  */
movq    $Sf, %rdi    /* primeiro parametro (ponteiro)*/
movl    %eax, %esi   /* segundo parametro  (inteiro) */
movl  $0, %eax
call  printf       /* chama a funcao da biblioteca */
/*************************************************************/

incq %rbx
jmp WHILE

FORA_WHILE:
    
/*************************************************************/
/* este trecho imprime o valor de %eax (estraga %eax)  */
movq    $MUDA_LINHA, %rdi    /* primeiro parametro (ponteiro)*/
movl    %eax, %esi   /* segundo parametro  (inteiro) */
movl  $0, %eax
call  printf       /* chama a funcao da biblioteca */
/*************************************************************/

/***************************************************************/
/* mantenha este trecho aqui e nao mexa - finalizacao!!!!      */
movq  $0, %rax  /* rax = 0  (valor de retorno) */
movq    -16(%rbp), %r12 /* recupera r12 */
movq    -8(%rbp), %rbx  /* recupera rbx */
leave
ret      
/***************************************************************/
