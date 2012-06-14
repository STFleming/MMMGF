#include <stdio.h>

#define SIZE 256

int main(int argc, char *argv[]) {

  int a[SIZE];
  int b[SIZE];
  int i;

  for (i=0; i<SIZE; i++) {
    a[i] = i;
    b[i] = SIZE+i;
  }

  for (i=0; i<SIZE; i=i+4)
    printf("%08X%08X%08X%08X\n", a[i+3], a[i+2], a[i+1], a[i]);
  for (i=0; i<SIZE; i=i+4)
    printf("%08X%08X%08X%08X\n", b[i+3], b[i+2], b[i+1], b[i]);

  return 0;
}
