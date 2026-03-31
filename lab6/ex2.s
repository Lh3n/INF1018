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
%ebx = sum
%r12d = i
%r13 = p
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

    movl    $0, %ebx
    movl    $0, %r12d
    movq    $nums, %r11

L1:
    cmpl    $4, %r12d
    je      L2
    addl    %r11d, %ebx
    addl    $1, %r12d  
    addq    $4, %r11
    jmp     L1 

L2:
    movl    (%ebx), %eax
    movq    $Sf, %rdi    
    movl    %eax, %esi
    call    printf

    movq    $0, %rax
    movq    -8(%rbp), %rbx
    movq    -16(%rbp), %r12
    leave
    ret 
