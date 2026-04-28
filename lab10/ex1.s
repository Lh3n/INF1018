/*
struct X {
  int val;
  struct X *next;
};
# int (4 bytes) + 4 bytes (PP) + pointer (8 bytes) = 16 bytes
int add (struct X *x) {
  int a = 0;
  for (; x != NULL; x = x->next)
    a += x->val;
  return a;
}
*/
/*
DICIONARIO:
a -> %r9d
val -> %r8d
*next -> %rcx
*x -> %rdi
*/

.text
.globl add

add:
  pushq   %rbp
  movq    %rsp, %rbp

  movl    (%rdi), %r8d        # val -> %r8d
  movq    8(%rdi), %rcx       # *next -> %rcx
  movl    $0, %r9d            # a = 0

Loop:
  cmpq    $0, %rdi            # x != NULL
  je      Lend

  # a += x->val
  movl    (%rdi), %r8d
  addl    %r8d, %r9d

  # x = x->next
  movq    8(%rdi), %rdi

  jmp     Loop

Lend:
  # return a
  movl    %r9d, %eax
  leave
  ret
