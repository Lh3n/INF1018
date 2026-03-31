.data
  nums: .int 3, -5, 7, 8, -2
  s1:   .string "%d\n"

.text
.globl main
main:
  /* prologo */
     pushq %rbp
     movq  %rsp, %rbp
     subq  $16, %rsp
     movq  %rbx, -8(%rbp)
     movq  %r12, -16(%rbp)

  /* inicializações: i = 0; p = nums */
     movl  $0, %ebx         # i = 0 em %ebx
     movq  $nums, %r12      # p = &nums em %r12

L1:
  /* testa condição do for: i < 5 ? */
     cmpl  $5, %ebx
     jge   L2

  /* carrega *p em %edi para passar ao filtro */
     movl  (%r12), %edi     # primeiro argumento: *p
     movl  $1, %esi         # segundo argumento: LIM = 1
     call  filtro           # chama filtro(*p, LIM), retorno em %eax

  /* preparar argumentos de printf */
     movq  $s1, %rdi        # string de formato
     movl  %eax, %esi       # valor retornado de filtro
     movl  $0, %eax         # por convenção
     call  printf

  /* incrementa i e p */
     addl  $1, %ebx
     addq  $4, %r12
     jmp   L1

L2:
  /* retorno */
     movl  $0, %eax

  /* finalizacao */
     movq -8(%rbp), %rbx
     movq -16(%rbp), %r12
     leave
     ret
