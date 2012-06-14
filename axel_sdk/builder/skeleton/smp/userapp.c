// userapp.c
// single thread reference design

#include <stdio.h>

#include <omp.h>

#define N 100
#define NUM_THREADS 4
#define CHUNK N/NUM_THREADS

int main(void) {

  int i, j;
  int val[N];

  int id, pn;

  for (i=0; i<N; i++)
    val[i] = i;

  omp_set_num_threads(NUM_THREADS);
#pragma omp parallel default(shared) private(i, id, pn)
  {

    id = omp_get_thread_num();
    pn = omp_get_num_threads();
    printf("I am thread %d out of %d.\n", id, pn);

#pragma omp for schedule(static,CHUNK) nowait
    for (i=0; i<N; i++) {
//      printf("%d %d\n", id, i);
      val[i] += id * 100;
    }
  }

  for (i=0; i<N/10; i++) {
    for (j=0; j<10; j++)
      printf("%03d ", val[i*10+j]);
    printf("\n");
  }

  return 0;
}
