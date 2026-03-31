/*
temp1.h
extern int a;

temp2.h
extern int b;
void foo(void);

temp1.c
#include #include "temp1.h"
#include "temp2.h"

int a = 1024;

int main(void) {
foo();
printf("%d\n", a);
return 0;
}

temp2.c
#include "temp1.h"
#include "temp2.h"

int b = 10;

void foo(void) {
a = -3;
}
*/


/* 3. Em temp1.c trocar:
int a = 1024;
por
char a = 1;

Compilar apenas temp1.c e depois linkar com temp2.o
Resultado: erro na linkedição devido a tamanhos conflitantes.
*/


/* 4(a). Em temp2.c trocar #include "temp1.h" por extern char a
temp2.c:

extern char a;
int b = 10;

void foo(void) {
a = -3;
}

Resultado: programa roda, muda só 1 byte de 'a' e imprime -3
*/


/*  4(b). Trocar extern char a por int a = 1
temp2.c:

int a = 1; // gera DUPLICATE SYMBOL no linker
*/


/* 4(c). Trocar por static int a = 1
temp2.c:

static int a = 1; // sem erro: variável com ligação interna
*/


/* 5(a). Remover #include "temp2.h" e trocar foo() por b()
temp1.c:

#include #include "temp1.h"
// #include "temp2.h" // removido

int a = 1024;

int main(void) {
b(); // variável b chamada como função!
printf("%d\n", a);
return 0;
}

temp2.c permanece:
int b = 10;

Resultado: PC tenta executar memória contendo o valor de b.
Com execstack -> erro de instrução ilegal.
*/

/* 5(b). Trocar valor de b para 0xC3
int b = 0xC3;

0xC3 = instrução RET no x86.
Resultado: b() retorna imediatamente, programa funciona.
*/
