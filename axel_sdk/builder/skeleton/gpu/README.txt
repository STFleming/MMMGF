CUDA example for nVidia GPU architecture
----------------------------------------

This is a template for programming a nVidia GPU in the AXEL cluster
(target is Tsela C1060). The example compute the sum of two linear
vector each with N components.
 
A thread is created for the summation of each component in the vector.
256 threads are created per block (tpb) and 4 blocks are assigned.
