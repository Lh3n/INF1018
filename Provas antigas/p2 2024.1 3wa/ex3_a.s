/*
void foo (double *vd, int n){
    while (n--){
        *vd = 0.0;
        vd++;
    }
}

DICIONARIO
reg     val
%xmm0   double (vd)
%rdi    *vd
%esi    int(n)
%xmm1   double(aux)
*/

.text
.globl foo

foo:
    movl    $0, %r10d
    cvtsi2sd    %r10d, %xmm1    # double aux = 0.0

WHILE:
    cmpl    $0, %esi
    jle     FORA_WHILE      # jump se %esi for <= $0

    movsd   %xmm1, (%rdi)   # *vd = 0.0

    addq    $8, %rdi        # vd++
    decl    %esi            # n--
    jmp     WHILE

FORA_WHILE:
    ret
