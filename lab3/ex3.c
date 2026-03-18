#include <stdio.h>

unsigned char switch_byte(unsigned char x) {
    unsigned char high = (x & 0xF0) >> 4; // parte alta (4 bits mais significativos)
    unsigned char low  = (x & 0x0F) << 4; // parte baixa (4 bits menos significativos)
    return high | low; // junta as duas partes trocadas
}

unsigned char rotate_left(unsigned char x, int n) {
    return ((x << n) | (x >> (8 - n))) & 0xFF;
}

// Função auxiliar para imprimir em binário (8 bits)
void print_binary(unsigned char x) {
    for (int i = 7; i >= 0; i--) {   // começa do bit mais significativo (7)
        printf("%d", (x >> i) & 1);  // desloca e mascara o bit
    }
}


int main(void) {
    // Teste switch_byte
    unsigned char val1 = 0xAB;
    printf("switch_byte(0x%X) = 0x%X\n", val1, switch_byte(val1));

    // Teste rotate_left com 0x61 (0110 0001)
    unsigned char val2 = 0x61;

    printf("rotate_left(0x%X, 1) = 0x%X (", val2, rotate_left(val2, 1));
    print_binary(rotate_left(val2, 1));
    printf(")\n");

    printf("rotate_left(0x%X, 2) = 0x%X (", val2, rotate_left(val2, 2));
    print_binary(rotate_left(val2, 2));
    printf(")\n");

    printf("rotate_left(0x%X, 7) = 0x%X (", val2, rotate_left(val2, 7));
    print_binary(rotate_left(val2, 7));
    printf(")\n");

    return 0;
}
