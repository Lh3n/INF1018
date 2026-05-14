/*
int foo (int x) {
  return x+1;
}
*/

# código
.text
# função
foo:
.globl foo
    # salvar RA da chamadora e criar o RA
    pushq   %rbp
    movq    %rsp, %rbp
    #subq    $???, %rsp

    # salvar callee-saved usados na função

    # return x+1
    incl    %edi
    movl    %edi, %eax

    # restaurar callee-saved salvos

    # destruir o RA
    leave

    # retornar
    ret
