/*
int nums[] = {10, -21, -30, 45};
int main() {
  int i, *p;
  int sum = 0;
  for (i = 0, p = nums; i != 4; i++, p++)
    sum += *p;
  printf("%d\n", sum);
  return 0;
}
*/
/*
DICIONARIO
%ebx = i
%r12 = *p
%r13 = sum
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

  movl    $0, %ebx        # i = 0
  movq    $nums, %r12     # p = nums
  movl    $0, %r13d       # sum = 0

L1:
  cmpl    $4, %ebx        # if (i == 4)?
  je      L2              # sai do loop se i == 4

  movl    (%r12), %eax    # eax = *p
  addl    %eax, %r13d     # sum += *p

  addl    $1, %ebx        # i++
  addq    $4, %r12        # p++
  jmp     L1              # volta para o loop

L2:
  # printf("%d\n", sum)
  movq    $Sf, %rdi       # primeiro argumento: formato    
  movl    %r13d, %esi      # segundo argumento: sum
  call    printf

  movq    $0, %rax
  movq    -8(%rbp), %rbx
  movq    -16(%rbp), %r12
  leave
  ret
