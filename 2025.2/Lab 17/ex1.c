#include <stdio.h>
void dump(void *p, int n) {
  unsigned char *p1 = (unsigned char *)p;
  while (n--) {
    printf("%p - %02x\n",p1,*p1);
    p1++;
  }
}

struct X {
  double d;
  float  f;
  short  s;
} x = {-4.5, 9.75, -11};

int main(void) {
  dump(&x, sizeof(x));
  return 0;
}

/*QUESTAO 1

struct X {
	double d;   8 bytes
	float  f;   4 bytes
	short  s;   2 bytes
};              + 2 bytes padding final (para múltiplo de 8)

Total: 16 bytes.

Valores :

	double d = -4.5
	- 4.5 em IEEE 754 (64 bits)
	-> hexadecimal : C012000000000000
	Little endian, fica byte a byte : 00 00 00 00 00 20 12 C0

	
	float f = 9.75
	9.75 em IEEE 754 (32 bits) :
	-> hexadecimal : 411C0000
	Little endian : 00 00 1C 41

	short s = -11
	-> hexadecimal : 0xFFF5
	Little endian: F5 FF

	Padding final(2 bytes)

		Endereços:
		Endereço	Conteúdo
		0x601040	00
		0x601041	00
		0x601042	00
		0x601043	00
		0x601044	00
		0x601045	20
		0x601046	12
		0x601047	C0
		0x601048	00
		0x601049	00
		0x60104A	1C
		0x60104B	41
		0x60104C	F5
		0x60104D	FF
		0x60104E	PP
		0x60104F	PP
*/
