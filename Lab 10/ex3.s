/*
struct X {
  int val1;
  int val2;
};

int f(int i, int v);

void boo (struct X *px, int n, int val) {
  while (n--) {
    px->val2 = f(px->val1, val);
    px++;
  }
}

DICIONARIO
px -> rdi
n -> esi
val -> edx
*/

.text
.globl boo

boo:
    pushq   %rbp
    movq    %rsp, %rbp

    pushq   %r12            # preservar registrador calle-saved
    pushq   %r13            # preservar registrador calle-saved

    movq    %rdi, %r12      # px -> r12 (endereço da struct)
    movl    %esi, %r13d     # n -> r13d
    movl    %edx, %r14d      # val -> r14d (preservar val)

WHILE:
    cmpl    $0, %r13d
    je      FORA_WHILE

    # preparar chamada para f(px->val1, val)
    movl    (%r12), %edi
    movl    %r14d, %esi
    call    f

    # armazenar resultado em px->val2 (offset 4 bbytes)
    movl    %eax, 4(%r12)

    # incrementar px para próxima struct (8 bytes: 2 ints)
    addq    $8, %r12

    # decrementar n
    decl    %r13d
    jmp     WHILE

FORA_WHILE:
    popq    %r13    # restaurar registrador
    popq    %r12    # restaurar registrador
    leave
    ret
