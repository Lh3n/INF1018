/*
struct exam {float val; int tipo;};

double inv (double val);

float boo (double d, float bias){
    int i;
    struct exam temp[5];

    for (i = 0; i < 5; i++){
        temp[i].val = inv(d);
        temp[i].tipo = i;
    }
    return temp[0].val + bias;
}

DICIONARIO
reg     val
%xmm0   double(d)
%xmm1   float(bias)
*/

.text
.globl boo

boo:
    pushq   %rbp
    movq    %rsp, %rbp
    subq    $48, %rsp   # abre espaço para exam[5] e i

    movl    $0, -4(%rbp)    # i = 0

FOR:
    cmpl    $5, -4(%rbp)
    jge     FIM     # if i >= 5, sai


    # temp[i].val = inv(d)
    movsd   %xmm0, %xmm0    # apenas para explicitar
    call    inv             # retorno: %xmm0 (double)

    cvtsd2ss    %xmm0, %xmm2    # %xmm2 = float(%xmm0)

    movl    -4(%rbp), %eax     # eax = i
    movslq  %eax, %rax          # rax = i (64bits)
    leaq    (-48(%rbp)), %rdx   # rdx = endereço base de temp[0]
    movss   %xmm2, (%rdx,%rax,8)    # temp[i].val = %xmm2


    # temp[i].tipo = i
    movl    -4(%rbp), %eax
    movl    %eax, 4(%rdx,%rax,8)    # temp[i].tipo = i

    addl    $1, -4(%rbp)    # i++
    jmp     FOR

FIM:
    # retorno: temp[0].val + bias
    movss   -48(%rbp), %xmm0    # carrega temp[0].val (float)
    cvtss2sd    %xmm0, %xmm0    # temp[0].val -> double
    cvtss2sd    %xmm1, %xmm1    # bias -> double

    addsd       %xmm1, %xmm0    # soma em double

    cvtsd2ss    %xmm0, %xmm0    # %xmm0 -> float

    leave
    ret
