/*
void foo (int a[], int n) {
  int i;
  int s = 0;
  for (i=0; i<n; i++) {
    s += a[i];
    if (a[i] == 0) {
      a[i] = s;
      s = 0;
    }
  }
}
*/
/*
Dicionario
REG     VAL
rdi     a
esi     n
r10d    s
r11d    i
r14d    temp
*/
.text
.global foo
#void foo (int a[], int n) {
foo:
    #criar o RA (registro de ativação)
    pushq   %rbp  #salva a base do RA da chamadora
    movq    %rsp, %rbp  #apontar para a base do RA da chamada
    subq    $16, %rsp  #abrir espaço para o RA da chamada

    #salvar os registradores callee-saved que vão ser usados
    movq    %r14, -8(%rbp)

    movl    $0, %r10d
    movl    $0, %r11d

WHILE:
    cmpl    %esi, %r11d
    jge     FORA_WHILE
    movl    %r11d, %r14d
    imull   $4, %r14d
    addq    %rdi, %r14
    addl    (%r14), %r10d
    cmpl    $0, (%r14)
    jne     FORA_IF
    movl    %r10d, (%r14)
    movl    $0, %r10d

FORA_IF:
    incl    %r11d

FORA_WHILE:

    #restaurar os registradores callee-saved salvos
    movq    -8(%rbp),   %r14

    #destruir o RA da função chamada e restaurar o RA da chamada
    leave

    #retornar
    ret