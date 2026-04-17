/*
int add (int a, int b, int c) {
  return a+b+c;
}
*/
/*
DIC
int a = %edi
int b = %esi
int c = %edx
*/
.text
.globl add
add:
    pushq   %rbp
    movq    %rsp, %rbp

    movl    %edi, %eax
    addl    %esi, %eax
    addl    %edx, %eax
    
    leave
    ret
