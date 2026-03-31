/* int f(int x) { return x+2; }

void map2 (int* um, int * outro, int n) {
  int i;
  for (i=0; i<n; i++)
    *(outro+i) = f(*(um+i));
}

DICIONARIO
um -> rdi
outro -> rsi
n -> edx
i -> ecx
*/

.text
.globl map2

map2:
    pushq   %rbp
    movq    %rsp, %rbp
    movl    $0, %ecx       # i = 0

Lfor:
    cmpl    %edx, %ecx      # compara i e n
    jge     Lend

    # salvar ponteiros pois call f pode sobrescrever %rdi e %rsi
    pushq   %rdi
    pushq   %rsi

    # carregar um[i] em %edi (argumento para f)
    movl    (%rdi,%rcx,4), %edi
    call    f               # f(um[i])

    # restaurar ponteiros
    popq    %rsi
    popq    %rdi

    # armazenar resultado em outro[i]
    movl    %eax, (%rsi,%rcx,4)
    
    incl    %ecx        # i++
    jmp     Lfor

Lend:
    popq    %rbp
    ret