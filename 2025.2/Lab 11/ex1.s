/*
int novonum(void) {
  int minhalocal;
  printf("numero: ");
  scanf("%d",&minhalocal);
  return minhalocal;
}
DICIONARIO


*/

.text
.globl novonum

novonum:
    pushq   %rbp
    movq    %rsp, %rbp
    subq    $16, %rsp

    leaq    msg(%rip), %rdi
    movl    $0, %eax
    call    printf

    leaq    -4(%rbp), %rsi
    leaq    fmt(%rip), %rdi
    movl    $0, %eax
    call    scanf

    movl    -4(%rbp), %eax

    leave
    ret

.section .rodata
msg:    .string "numero: "
fmt:    .string "%d"