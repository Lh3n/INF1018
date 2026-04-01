#include <stdio.h>

struct X1 {
  char c1;
  int i;
  char c2;
} x1 = {0xc1, 0x01020304, 0xc2};

struct X2 {
  long l;
  char c;
} x2 = {0x0102030405060708, 0xc1};

struct X3 {
  int i;
  char c1;
  char c2;
} x3 = {0x01020304, 0xc1, 0xc2};

struct X4 {
  struct X2 x;
  char c;
} x4 = {{0x0102030405060708, 0xc1}, 0xc2};

struct X5 {
  char c1;
  char c2;
  char c3;
} x5 = {0xc1, 0xc2, 0xc3};

struct X6 {
  short s1;
  int i;
  char c[3];
  short s2;
} x6 = {0x0102, 0x01020304, {0xc1, 0xc2, 0xc3}, 0x0102};

union U1 {
  int i;
  char c[5];
};

union U2 {
  short s;
  char c[5];
};

void dump (void *p, int n) {
  unsigned char *p1 = p;
  while (n--) {
    printf("%p - %02x\n", p1, *p1);
    p1++;
  }
}