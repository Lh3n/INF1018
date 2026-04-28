/*
int add2 (struct X *x) {
  if (x == NULL) return 0;
  else return x->val + add2(x->next);
}
*/
/*
DICIONARIO:
rdi     x
edx     x->valor
*/

.text
.globl add2

add2:
    pushq   %rbp
    movq    %rsp, %rbp

    cmpq    $0, %rdi
    jne     Lelse
    movl    $0, %eax
    jmp     Lend

Lelse:
    movl    (%rdi), %edx        # edx = x->valor
    movq    8(%rdi), %rdi       # rdi = x->next
    call    add2                # eax = add(x->next)
    addl    %edx, %eax          # eax += x->valor
    
Lend:
    leave
    ret
