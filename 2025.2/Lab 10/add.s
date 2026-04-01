/*
struct X {
  int val;
  struct X *next;
};

int add (struct X *x) {
  int a = 0;
  for (; x != NULL; x = x->next)
    a += x->val;
  return a;
}
*/
/*
DICIONARIO
eax     a
rdi     x
*/
.text
.globl add
add:
    pushq   %rbp
    movq    %rsp, %rbp
    movl    $0, %eax

WHILE:
    cmpq    $0, %rdi    #while (x != NULL)
    je      FORA_WHILE  #se x == NULL, sai do loop

    addl    (%rdi), %eax    #a += x->val
    movq    8(%rdi), %rdi   #x = x->next
    jmp     WHILE           #repete

FORA_WHILE:
    popq    %rbp
    ret     #return a