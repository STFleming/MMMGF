/* userapp.cu
 * by Brittle 2009
 *
 * Template for CUDA programming on AXEL cluster
 */

#include <stdio.h>

#define N 1000
#define tpb 256
#define SIZE N*sizeof(float)

__global__ void kernel(float *A, float *B, float *C) {
  int i = blockIdx.x * 256 + threadIdx.x;
  if (i < N) // check since some threads may be created uselessly
    C[i] = A[i] + B[i];
}

int main(void) {
  float a[N], b[N], c[N];
  float *A, *B, *C;
  int i;

  for (i=0; i<N; i++) {
    a[i] = i;
    b[i] = 2 * i;
    c[i] = 0;
  }

  cudaMalloc((void **)&A, SIZE);
  cudaMalloc((void **)&B, SIZE);
  cudaMalloc((void **)&C, SIZE);

  cudaMemcpy(A, a, SIZE, cudaMemcpyHostToDevice);
  cudaMemcpy(B, b, SIZE, cudaMemcpyHostToDevice);

  kernel<<<(N+tpb-1)/tpb, tpb>>>(A, B, C);

  cudaMemcpy(c, C, SIZE, cudaMemcpyDeviceToHost);

  cudaFree(A);
  cudaFree(B);
  cudaFree(C);

  for (i=0; i<N; i++) {
    if (i%10 == 0) printf("\n");
    printf("%6.0f ", c[i]);
  }
  printf("\n");

  return 0;
}
