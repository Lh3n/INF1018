// includes padrão
#include <stdio.h>
#include <stdint.h>
#include <sys/mman.h>
#include <unistd.h>

// meus includes

// minhas constantes e macros
#define PAGE_START(P) ((intptr_t)(P)&~(pagesize-1))
#define PAGE_END(P) (((intptr_t)(P)+pagesize-1)&~(pagesize-1))

// meus tipos
typedef int (*funcp) (int x);
typedef unsigned int uint32;

// meus protótipos
int execpage(void *ptr, size_t len);

// minhas variáveis globais
/*
unsigned char codigo[] = {
   0x55,                            // push   %rbp
   0x48, 0x89, 0xe5,                // mov    %rsp,%rbp
   0xff, 0xc7,                      // inc    %edi
   0x89, 0xf8,                      // mov    %edi,%eax
   0xc9,                            // leave
   0xc3                             // ret
};
*/
unsigned char codigo[] = {
   0x55,                            // push   %rbp
   0x48, 0x89, 0xe5,                // mov    %rsp,%rbp
   0xe8, 0x00, 0x00, 0x00, 0x00,    // call   9 <foo+0x9>
   0xc9,                            // leave
   0xc3                             // ret
};

// minhas funções
int add (int x) {
  return x+1;
}

int bar(int x) {
   return x + 1;
}

int main(void) {
    int a;
    int b;
    funcp f;

    execpage(codigo, sizeof(codigo));

    a = 7;
    b = bar(a);
    printf("bar(%d) = %d\n", a, b);

    f = bar;
    b = f(a);
    printf("f(%d) = %d\n", a, b);

    int offset;
    offset = (long)add - ((long)codigo + 9);
    *(int *)(codigo + 5) = offset;

    f = (funcp) codigo;
    b = f(a);
    printf("codigo(%d) = %d\n", a, b);

    return 0;
}

int execpage(void *ptr, size_t len) {
	int ret;

	const long pagesize = sysconf(_SC_PAGE_SIZE);
	if (pagesize == -1)
		return -1;

	ret = mprotect((void *)PAGE_START(ptr),
		 PAGE_END((intptr_t)ptr + len) - PAGE_START(ptr),
		 PROT_READ | PROT_WRITE | PROT_EXEC);
	if (ret == -1)
		return -1;

	return 0;
}