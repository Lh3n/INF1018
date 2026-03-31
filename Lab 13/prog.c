/*
#include <stdio.h>

typedef int (*funcp)(int x);

int main() {

     Código de máquina da função:
       int foo(int x) { return x+1; }

       Instruções:
       89 f8       movl %edi, %eax
       83 c0 01    addl $1, %eax
       c3          ret
    

    unsigned char codigo[] = {
        0x89, 0xF8,
        0x83, 0xC0, 0x01,
        0xC3
    };

    funcp f = (funcp)codigo;

    int i = (*f)(10);

    printf("Resultado da função: %d\n", i);

    return 0;
}
*/

/*#include <stdio.h>
#include <stdint.h>

// Função real add
int add(int x) {
    return x + 1;
}

// Ponteiro para função que recebe int e retorna int
typedef int (*funcp)(int);

int main() {

    
        Código de máquina da função foo:

        foo:
            movl   %edi, %edi     → 89 FF
            call   add            → E8 xx xx xx xx  (deslocamento será preenchido)
            ret                   → C3
    

    unsigned char codigo[] = {
        0x89, 0xFF,                    // movl %edi, %edi
        0xE8, 0x00, 0x00, 0x00, 0x00,  // call add  (corrigir)
        0xC3                            // ret
    };

    // Transformar o array em função
    funcp f = (funcp)codigo;

    // ----- calcular deslocamento da instrução call -----

    // endereço real de add
    uintptr_t end_add = (uintptr_t)&add;

    // endereço base do array contendo o código
    uintptr_t base = (uintptr_t)codigo;

    // posição onde começa a instrução call (opcode E8)
    int pos_call = 2;

    // endereço da instrução *após* o call
    uintptr_t end_prox_instr = base + pos_call + 5;

    // deslocamento relativo: dest - src
    int32_t desloc = (int32_t)(end_add - end_prox_instr);

    // preencher em little endian
    codigo[pos_call + 1] =  desloc        & 0xFF;
    codigo[pos_call + 2] = (desloc >> 8)  & 0xFF;
    codigo[pos_call + 3] = (desloc >> 16) & 0xFF;
    codigo[pos_call + 4] = (desloc >> 24) & 0xFF;

    // ----- TESTE -----
    int r = f(10);
    printf("Resultado: %d\n", r);

    return 0;
}
*/

#include <stdio.h>
#include <stdint.h>
#include <sys/mman.h>
#include <unistd.h>

// ---------- Função add real ----------
int add(int x) {
    return x + 1;
}

// ---------- Função para liberar execução do buffer ----------
#define PAGE_START(P) ((intptr_t)(P)&~(pagesize-1))
#define PAGE_END(P)   (((intptr_t)(P)+pagesize-1)&~(pagesize-1))

int execpage(void *ptr, size_t len) {
    const long pagesize = sysconf(_SC_PAGE_SIZE);
    if (pagesize == -1) return -1;

    return mprotect(
        (void *)PAGE_START(ptr),
        PAGE_END((intptr_t)ptr + len) - PAGE_START(ptr),
        PROT_READ | PROT_WRITE | PROT_EXEC
    );
}

#undef PAGE_START
#undef PAGE_END

// ---------- Ponteiro para função gerada ----------
typedef int (*funcp)(int);

int main() {

    /*
        foo:
            movl %edi, %edi   → 89 FF
            jmp  add          → E9 xx xx xx xx
            (não precisa de ret, pois add já faz ret)
    */

    unsigned char codigo[] = {
        0x89, 0xFF,                    // movl %edi, %edi
        0xE9, 0x00, 0x00, 0x00, 0x00   // jmp add (deslocamento será corrigido)
    };

    // liberar execução
    if (execpage(codigo, sizeof(codigo)) != 0) {
        perror("mprotect");
        return 1;
    }

    // -------- calcular deslocamento do JMP --------

    uintptr_t end_add = (uintptr_t)&add;
    uintptr_t base    = (uintptr_t)codigo;
    int pos_jmp = 2;

    uintptr_t end_prox_instr = base + pos_jmp + 5;

    int32_t desloc = (int32_t)(end_add - end_prox_instr);

    // little endian
    codigo[pos_jmp + 1] =  desloc        & 0xFF;
    codigo[pos_jmp + 2] = (desloc >> 8)  & 0xFF;
    codigo[pos_jmp + 3] = (desloc >> 16) & 0xFF;
    codigo[pos_jmp + 4] = (desloc >> 24) & 0xFF;

    // transformar array em função
    funcp f = (funcp)codigo;

    // executar
    int r = f(10);
    printf("Resultado: %d\n", r);   // deve imprimir 11

    return 0;
}
