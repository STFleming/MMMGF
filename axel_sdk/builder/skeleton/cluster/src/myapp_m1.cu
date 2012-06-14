/* myapp_m1.cu ---- Brittle */
/* GPU version */

__global__ void kernel(int *a, int *b) {
  a[threadIdx.x] += b[threadIdx.x];
}

extern "C" {

void cukernel(int *a, int *b, int size) {
  kernel <<<1, size>>>(a, b);
}

}
