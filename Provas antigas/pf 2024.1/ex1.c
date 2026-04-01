/* exemplo.c — contém todos os tipos de símbolos pedidos */

#include <stdio.h>

/* ========================================================= */
/* D — símbolo na área de dados exportado                    */
/* Variáveis globais inicializadas ficam na seção .data      */
/* ========================================================= */
int global_exported = 42;   /* D */

/* ========================================================= */
/* d — símbolo na área de dados local                        */
/* Variáveis estáticas internas ao arquivo                   */
/* ========================================================= */
static int static_local_data = 7;   /* d */

/* ========================================================= */
/* T — símbolo na área de código exportado                   */
/* Funções globais ficam na seção .text e são exportadas     */
/* ========================================================= */
void exported_function() {          /* T */
    printf("Exported function\n");
}

/* ========================================================= */
/* t — símbolo na área de código local                       */
/* Funções static ficam na seção .text mas não exportadas    */
/* ========================================================= */
static void local_function() {      /* t */
    printf("Local static function\n");
}

/* ========================================================= */
/* U — símbolo indefinido                                    */
/* Simplesmente use uma função que não é definida aqui       */
/* ========================================================= */
extern void undefined_function();   /* U */

int main() {
    exported_function();
    local_function();
    
    /* chamada gera símbolo U, pois não há definição */
    undefined_function();

    /* chamada gera símbolo U */
    printf("%d %d\n", global_exported, static_local_data);
    return 0;
}
