/*
struct S{
    double d;
    int i;

    sizeof(struct S) = 16
}

float foo(int i , double d);

float bar(double ent, float *sai, int n){
    struct S v[5];                            # v[5] = 5 x 16 = 80 bytes
    float r = 0, *p = sai;                    # r = 4 bytes & *p = 8 bytes

    for (int i = 0; i < n; i++){
        if (*p < 0)
            *p = 0;
        r += foo(v[i].i, ent);
        p++;
    }
    return r;
}
*/
/*
DIC

bar:
%xmm0 - double ent
%rdi  - float *sai
%esi  - int n
%ebx  - int i
%r12  - *p

foo:
%edi  - int i
%xmm0 - double d

*/

.text
.globl bar
bar:
    pushq   %rbp
    movq    %rsp, %rbp
    pushq   %rbx
    pushq   %r12
    subq    $80, %rsp

    # callee-saved
    movl    $0, %ebx        # i
    movq    %rdi, %r12      # p = sai

    pxor    %xmm1, %xmm1
    movss   %xmm1, -32(%rbp)    # r = 0.0f
    movl    %esi, -28(%rbp)     # n -> mem
    movsd   %xmm0, -24(%rbp)    # ent -> mem

Lfor:
    # if(i < n)
    cmpl    %esi, %ebx
    jge     Lend

    # if(*p < 0)
    movss   (%r12), %xmm1       # *p -> xmm1
    pxor    %xmm2, %xmm2        # xmm2 == 0.0f
    ucomiss %xmm2, %xmm1        # xmm1 < xmm2
    jae     ForaIF

    movss   %xmm2, (%r12)       # *p = 0.0f

ForaIF:
    # r += foo(v[i].i, ent);
    # calcula endereço de v[i]
    movslq  %ebx, %rdx
    shlq    $4, %rdx
    
    leaq    -112(%rbp), %rcx     # endereço de v -> rcx
    addq    %rdx, %rcx          # avança para v[i]

    movl    8(%rcx), %edi       # primeiro argumento = v[i].i
                                # segundo argumento já está em %xmm0
    call    foo

    # atualiza r
    movss   -32(%rbp), %xmm1
    addss   %xmm0, %xmm1
    movss   %xmm1, -32(%rbp)

    # prepara nova iteracao
    movsd   -24(%rbp), %xmm0     # recupera ent
    movl    -28(%rbp), %esi     # recupera o n

    addq    $4, %r12            # p++
    incl    %ebx                # i++
    jmp     Lfor

Lend:
    movss   -32(%rbp), %xmm0    # r -> xmm0
    addq    $80, %rsp
    popq    %r12
    popq    %rbx
    popq    %rbp
    ret
