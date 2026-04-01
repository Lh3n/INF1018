/*
double pack (struct X *px) {
  double acc = 0;
  while (px != NULL) {
    acc += foo(px->vd, px->vi);
    px = px->next;
  }
  return acc;
}
*/

.globl pack
pack:
    xorpd   %xmm2, %xmm2        # acc = 0.0 em xmm2

Lloop:
    test    %rdi, %rdi          # px == NULL
    je      Lend

    movsd   8(%rdi), %xmm0      # xmm0 = px->vd   (arg 1)
    mov     (%rdi), %esi        # esi  = px->vi   (arg 2)
    call    foo                 # resultado em xmm0

    addsd   %xmm0, %xmm2        # acc += foo(...)
                                # acumulador continua em xmm2

    mov     16(%rdi), %rdi      # px = px->next

    jmp     Lloop

Lend:
    movsd   %xmm2, %xmm0        # retorno em xmm0
    ret
