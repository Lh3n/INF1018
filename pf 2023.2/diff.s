/*
double diff(double a, double b, int n)
{
 double s[2] = {0.0, 0.0};
 while (n--)
 {
 s[0] += a;
 s[1] += b;
 }
 return (s[0] - s[1]);
}

%xmm0 -> double a
%xmm1 -> double b
%edx  -> int n

*/

.text
.globl diff
diff:
    pushq           %rbp
    movq            %rsp, %rbp
    # subq            $16, %rsp
    xorpd           %xmm2, %xmm2
    xorpd           %xmm3, %xmm3

Loop:
    testl           %edi, %edi
    je              Lend
    decl            %edi                    # n--

    addsd           %xmm0, %xmm2
    addsd           %xmm1, %xmm3

    # movsd           %xmm2, -8(%rbp)
    # movsd           %xmm3, -16(%rbp)

    jmp             Loop

Lend:
    # movsd       -8(%rbp), %xmm0
    # subsd       -16(%rbp), %xmm0

    movsd           %xmm2, %xmm0
    subsd           %xmm3, %xmm0

    popq            %rbp
    ret
