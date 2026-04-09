#include <stdio.h>

int b(long x, int y, short z){
    return x + y +z;
}

int a(long x, int y, short z){
    int c = b(z,y,x);
    return c;
}

int main(){
    printf("%d", a(1,2,3));
    return 0;
}