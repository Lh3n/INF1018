/*
int nums[] = {10, -21, -30, 45};
int main() {
  int i, *p;
  for (i = 0, p = nums; i != 4; i++, p++)
    if ((*p % 2) == 0)
      printf("%d\n", *p);
  return 0;
}
*/
/*
DIC
%ebx = i
%r12 = *p
%edx = temp
*/

.data
nums:  .int  10, -21, -30, 45
Sf:  .string "%d\n"    # string de formato para printf

.text
.globl main
main:
  pushq   %rbp
  movq    %rsp, %rbp
  subq    $16, %rsp
  movq    %rbx, -8(%rbp)
  movq    %r12, -16(%rbp)

  movl    $0, %ebx            # i = 0
  movq    $nums, %r12         # p = nums

L1:
  cmpl    $4, %ebx            # if (i == 4)?
  je      L2

  movl    (%r12), %edx        # temp = *p

  andl    $1, %edx            # ebx = (*p & 1)
  jne     skip_print          # se != 0, número ímpar (pular)

  movq    $Sf, %rdi
  movl    (%r12), %esi
  call    printf

skip_print:
  addl    $1, %ebx            # i++
  addq    $4, %r12            # p++
  jmp     L1                  # votla pro loop

L2:
  movq    $0, %rax            # valor de retorno da main
  movq    -8(%rbp), %rbx
  movq    -16(%rbp), %r12
  leave
  ret
