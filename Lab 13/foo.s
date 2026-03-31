/*
int foo(int x) {
    return x+1;
}
DICIONARIO
%edi    x


.globl foo
foo:
    movl    %edi, %eax      # copia o argumento x em %edi para %eax
    addl    $1, %eax        # soma 1 ao valor de retorno
    ret                     # retora ao chamador da função
*/
# nova função foo

/*
int foo (int x) {
    return add(x);
}
*/

.text
.globl foo

foo:
    movl    %edi, %edi      # argumento x já está em %edi, mas deixamos explícito
    jmp    add             # chama add(x)
