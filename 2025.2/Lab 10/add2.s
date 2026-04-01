/*
struct X {
  int val;
  struct X *next;
};

int add (struct X *x) {
  if (x == NULL) return 0;
  else return x->val + add(x->next);
}
*/

/*
DICIONARIO
rdi     x
edx     x->valor
*/

.text
.globl add
add:
    pushq   %rbp
    movq    %rsp,   %rbp

    cmpq    $0, %rdi    #if(x == NULL)
    jne     .Lelse
    movl    $0, %eax    #return 0
    jmp     .Lend

.Lelse:
    movl    (%rdi), %edx    #edx = x->val
    movq    8(%rdi), %rdi   # rdi = x->next
    call    add            #eax = add(x->next)
    addl    %edx, %eax      #eax += x->val

.Lend:
    popq %rbp
    ret