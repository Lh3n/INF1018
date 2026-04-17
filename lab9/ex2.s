/*
int fat (int n) {
  if (n==0) return 1;
  else return n*fat(n-1);
}
*/

/*
DIC
n -> %edi
*/

.text
.globl fat
fat:
    pushq   %rbp
    movq    %rsp, %rbp
    subq    $16, %rsp

    movl    %edi, -16(%rbp)

    cmpl    $0, %edi
    je      IF_ZERO
    jmp     LREC

LREC:
    movl    -16(%rbp), %eax
    subl    $1, %eax
    movl    %eax, %edi
    call    fat
    movl    -16(%rbp), %ecx
    imull   %ecx, %eax

IF_ZERO:
    movl    $1, %eax
    leave
    ret
