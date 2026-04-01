#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int i;
char *buff = NULL;
static int k = 0;
int f(char *p);

int g(char *s1, char *s2) {
  int a = strlen(s1);
  int b = strlen(s2);
  buff = (char *) malloc(a + b + 1);
  strcat(strcpy(buff,s1), s2);

  k += a + b + i;
  return f(buff); 
}

/*

Exportados (definidos):
buff -> D
g -> T
k estático -> d
f -> d

Importados (referências externas):
i -> U
f -> U
strlen -> U
malloc -> U
strcpy -> U
strcat -> U

*/
