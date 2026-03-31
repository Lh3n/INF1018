#include <stdio.h>
#include <math.h>

#define getsig(x)        ((x)>>31 & 1)
#define getexp(x)        ((x)>>23 & 0xff)
#define getfrac(x)       ((x) & 0x7fffff)
#define makefloat(s,e,f) ((s & 1)<<31 | (((e) & 0xff) << 23) | ((f) & 0x7fffff))

typedef union {
  float f;
  unsigned int i;
} U;

float float2(float f){
    U u;
    u.f = f;

    unsigned int s = u.i >> 31;
    unsigned int e = (u.i >> 23) & 0xFF;
    unsigned int frac = u.i & 0x7FFFFF;

    //caso zero
    if (e == 0 && frac == 0) return f;
    //infinito ou NaN
    if (e == 0xFF) return f;

    //caso denormalizado: shift na mantissa
    if (e == 0){
        frac <<= 1;
        u.i = (s << 31) | frac;
        return u.f;
    
    }
    //caso normalizado: apenas aumente o expoente
    e++;
    if (e == 0xFF){
        //vira infinito
        u.i = (s << 31) | (0xFF << 23);
        return u.f;
    }
    u.i = (s << 31) | (e << 23) | frac;
    return u.f;
}

float int2float(int i){
    U u;

    //caso zero
    if (i == 0){
        u.i = 0;
        return u.f;
    }

    unsigned int s = 0;
    unsigned int M;
    if (i < 0) {
        s = 1;
        M = -i;
    } else {
        M = i;
    }

    // Encontra o bit mais significativo (msb)
    int msb = 31;
    while (((M >> msb) & 1) == 0) msb--;

    // Expoente com bias: msb + 127
    unsigned int e = msb + 127;

    // Constrói a mantissa removendo o MSB
    unsigned int frac;

    if (msb <= 23) {
        // Cabe sem perder bits
        frac = (M & ((1 << msb) - 1)) << (23 - msb);
    } else {
        // Precisa descartar bits (shift right)
        unsigned int extra = msb - 23;
        unsigned int removed = M & ((1 << extra) - 1);
        frac = (M >> extra) & 0x7FFFFF;

        // Rounding (round-to-even)
        if (removed > (1 << (extra - 1)) ||
            (removed == (1 << (extra - 1)) && (frac & 1))) {
            frac++;
            if (frac == 0x800000) {
                // overflow da mantissa -> aumenta expoente
                frac = 0;
                e++;
            }
        }
    }
    u.i = (s << 31) | (e << 23) | (frac & 0x7FFFFF);
    return u.f;
}

int main() {
   int i;
   float f;

   printf("\n******** Testes de float2 (multiplica por 2) **************\n");

   f = 0.0f;
   printf(" float2(%+10.4f) = %+10.4f\n", f, float2(f));

   f = 1.0f;
   printf(" float2(%+10.4f) = %+10.4f\n", f, float2(f));

   f = -2.5f;
   printf(" float2(%+10.4f) = %+10.4f\n", f, float2(f));

   f = 12345.0f;
   printf(" float2(%+10.4f) = %+10.4f\n", f, float2(f));

   f = -9876.75f;
   printf(" float2(%+10.4f) = %+10.4f\n", f, float2(f));

   printf("\n******** int2float ****************\n");
   i = 0;
   printf(" %d -> %+10.4f\n", i, int2float(i));
   i = 1;  
   printf(" %d -> %+10.4f\n", i, int2float(i));
   i = -1;  
   printf(" %d -> %10.4f\n", i, int2float(i));
   i = 0x7fffffff;  
   printf(" %d -> %+10.4f\n", i, int2float(i));
   i = -i;
   printf(" %d -> %+10.4f\n", i, int2float(i));
   i = 12345;
   printf(" %d -> %+10.4f\n", i, int2float(i));
   i = -12345;
   printf(" %d -> %+10.4f\n", i, int2float(i));
   return 0;
}