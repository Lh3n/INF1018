/*
int corta(int v[], int i);
long int boo (int *a, int n) {
 long int acc = 0;
 while (n--)
 {
 acc += corta(a, n);
 a++;
 }
 return acc;
}

%rdi -> int *a
%esi -> int n

*/

.text
.globl boo
boo:
    pushq   %rbp
    movq    %rsp, %rbp
    addq    $0, %r12         # acc = 0

Loop:
    testl       %esi, %esi
    je          Lend
    decl        %esi            # n--

    call        corta
    movslq      %eax, %rcx
    addq        %rcx, %r12      # acc += retorno de corta

    addq        $4, %rdi        # a++
    jmp         Loop

Lend:
    movq        %r12, %rax
    leave
    ret
