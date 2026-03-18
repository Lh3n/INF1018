#include <stdio.h>
int main(void) {
  unsigned int x = 0x87654321;
  unsigned int y, z;

  /* o byte menos significativo de x e os outros bits em 0 */
  y = (x<<24)>>24;

  /* o byte mais significativo com todos os bits em '1' 
     e os outros bytes com o mesmo valor dos bytes de x */
  z = ~(~(x<<8)>>8);

  printf("x:%08x\ny:%08x\nz:%08x\n", x, y, z);
}
// 1000 0111 0110 0101 0100 0011 0010 0001 = 87654321
// 0000 0000 0110 0101 0100 0011 0010 0001 = 00654321
// 1111 1111 0110 0101 0100 0011 0010 0001 = FF654321