/*
int boba(float v[], float lim, int n) {
 int i;
 int a = 0;
 for(i = 0; i < n; i++) {
 if(v[i] > lim) a += 1;
 }
 return a;
}
%rdi - float[v]
%xmm1 - float lim
%esi - int n
%eax - retorno
*/

.globl boba
boba:
    pushq   %rbp
    movq    %rsp, %rbp

    movl    $0, %eax       # a = 0
    movl    $0, %edx       # i = 0

Lfor:
    cmpl    %esi, %edx      # i < n ?
    jge      Lend           # jump if greater or equal

    movss       (%rdi,%rdx,4), %xmm1    # xmm1 = v[i]
    ucomiss     %xmm0, %xmm1            # v[i] > lim ?
    jbe         Lnext                   # jump if below

    addl    $1, %eax        # a++
    incl    %edx        # i++

Lnext:
    incl    %edx        # i++
    jmp     Lfor


Lend:
    popq    %rbp
    ret
