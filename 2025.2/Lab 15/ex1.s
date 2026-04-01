/*
float foo (double a, float b) {
    return (a+b) * (a - b);
}
DICIONARIO
reg         valor
%xmm0       double a
%xmm1       float b
%xmm2       aux1
%xmm3       aux2
*/

.text
.globl foo

foo:
    cvtss2sd    %xmm1, %xmm1
    movsd       %xmm0, %xmm2
    addsd       %xmm1, %xmm2        # %xmm2 = a + b

    movsd       %xmm0, %xmm3
    subsd       %xmm1, %xmm3        # %xmm3 = a - b

    mulsd       %xmm3, %xmm2        # %xmm2 = (a + b) * (a - b)

    cvtsd2ss    %xmm2, %xmm0        # xmm0 = float(resultado)

    ret
