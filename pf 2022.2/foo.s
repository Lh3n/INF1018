/*
double foo (int v[], int n) {
 double m = 1.0;
 int i;
 int indice;
 for(i=0; i< n; i++) {
 indice = calculaIndice(i);
 m *= trata(v[indice]);
 }
 return m;
}
*/

.section .rodata
one_double:
    .double 1.0     # Constante 1.0 para inicializar 'm'

.text
.globl foo
foo:
    # PRESERVAÇÃO: Esta função precisa preservar RBP.
    pushq   %rbp
    movq    %rsp, %rbp
    
    # ----------------------------------------------------
    # 1. PRÓLOGO E INICIALIZAÇÃO
    # %rdi: v[] (Base do vetor)
    # %esi: n (Tamanho)
    
    movl    $0, %ecx          # i = 0 (usamos %ecx para o contador)
    movsd   one_double(%rip), %xmm1 # m = 1.0. Usamos %xmm1 como acumulador.
                                    # %xmm0 é reservado para retorno.

Loop_start:
    # ----------------------------------------------------
    # 2. CONDIÇÃO DO LOOP: i < n?
    
    cmpl    %esi, %ecx        # Compara n (%esi) com i (%ecx)
    jge     Loop_end          # Se i >= n, sai

    # ----------------------------------------------------
    # 3. CHAMADA: indice = calculaIndice(i)
    
    movl    %ecx, %edi        # Argumento 1: %edi = i
    call    calculaIndice     # Resultado (indice) em %eax

    # ----------------------------------------------------
    # 4. PREPARAÇÃO DA MULTIPLICAÇÃO: m *= trata(v[indice])
    
    # a) Determinar o endereço de v[indice]
    #    %rdi (v) é a base. %rax (indice) é o índice. Scale = 4 (sizeof(int))
    movl    (%rdi, %rax, 4), %edi # Argumento 1: %edi = v[indice] (int)
    
    # b) Chamar trata(v[indice])
    call    trata             # Resultado (double) de trata() em %xmm0
    
    # c) m *= resultado
    mulsd   %xmm0, %xmm1      # m (%xmm1) = m * %xmm0

    # ----------------------------------------------------
    # 5. INCREMENTO DO LOOP
    
    incl    %ecx              # i++
    jmp     Loop_start        # Volta para o início do loop

Loop_end:
    # ----------------------------------------------------
    # 6. EPÍLOGO E RETORNO
    
    movsd   %xmm1, %xmm0      # Mover o resultado final (m) para %xmm0
    
    popq    %rbp
    ret
