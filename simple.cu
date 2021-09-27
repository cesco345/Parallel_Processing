   // Simple CUDA example by Ingemar Ragnemalm 2009. Simplest possible?
 2 // Assigns every element in an array with its index.
 3
 4 // nvcc simple.cu -L /usr/local/cuda/lib -lcudart -o simple
 5
 6 #include <stdio.h>
 7
 8 const int N = 16;
 9 const int blocksize = 16;
10
11 __global__
12 void simple(float *c)
13 {
14     c[threadIdx.x] = threadIdx.x;
15 }
16
17 int main()
18 {
19     float *c = new float[N];
20     float *cd;
21     const int size = N*sizeof(float);
22
23     cudaMalloc( (void**)&cd, size );
24     dim3 dimBlock( blocksize, 1 );
25     dim3 dimGrid( 1, 1 );
26     simple<<<dimGrid, dimBlock>>>(cd);
27     cudaThreadSynchronize();
28     cudaMemcpy( c, cd, size, cudaMemcpyDeviceToHost );
29     cudaFree( cd );
30
31     for (int i = 0; i < N; i++)
32         printf("%f ", c[i]);
33     printf("\n");
34     delete[] c;
35     printf("done\n");
36     return EXIT_SUCCESS;
37 }
