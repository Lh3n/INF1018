/*
double trata(int u){
    return (double) u;
}

%xmm0 -> retorno
%edi  -> int u

*/

.text
.globl trata
trata:
    pushq       %rbp
    movq        %rsp, %rbp
    cvtsi2sd    %edi, %xmm0
    leave
    ret
