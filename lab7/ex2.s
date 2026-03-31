/*
#include <stdio.h>

char S2[] = {65, 108, 111, 32, 123, 103, 97, 108, 101, 114, 97, 125, 33, 0};

int main (void) {
  char *pc = S2;
  while (*pc){
    if (*pc != 123 && *pc != 125){
      printf ("%c", *pc);
    }
    pc++;
  }
  printf("\n");
  return 0;
}
*/
/*
DICONARIO

*/

#include <stdio.h>

.data
S2: .byte 65, 108, 111, 32, 123, 103, 97, 108, 101, 114, 97, 125, 33, 0
Sf1: .string "%c"
Sf2: .string "\n"

.text
.globl main

main:
    pushq   %rbp
    movq    %rsp, %rbp
    subq    $16, %rsp
    movq    %rbx, -8(%rbp)      /* guarda rbx */
    movq    %r12, -16(%rbp)     /* guarda r12 */

    movq    $S2, %r12           /* r12 = &S2 */

L1:
    cmpb    $0, (%r12)          /* r12 != 0 */
    jz      FORA_LOOP
    cmpb    $123, (%r12)
    je      FORA_IF
    cmpb    $125, (%r12)
    je      FORA_IF

    movsbl  (%r12), %eax

    movq    $Sf1, %rdi           /* primeiro parametro (ponteiro)*/
    movl    %eax, %esi          /* segundo parametro  (inteiro) */
    movl    $0, %eax
    call    printf

FORA_IF:
    incq    %r12
    jmp     L1

FORA_LOOP:
  movq   $Sf2, %rdi
  movl   $0, %eax
  call   printf

  movq  $0, %rax
  movq  -16(%rbp), %r12
  movq  -8(%rbp), %rbx
  leave
  ret
