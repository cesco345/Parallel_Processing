   #include <stdio.h>
 2 #include <stdlib.h>
 3
 4 #define N 2
 5
 6 __global__ void MatAdd(int A[][N], int B[][N], int C[][N]){
 7            int i = threadIdx.x;
 8            int j = threadIdx.y;
 9
10            C[i][j] = A[i][j] + B[i][j];
11 }
12
13
14 int main(){
15
16 int A[N][N] = {{1,2},{3,4}};
17 int B[N][N] = {{5,6},{7,8}};
18 int C[N][N] = {{0,0},{0,0}};
19
20 int (*pA)[N], (*pB)[N], (*pC)[N];
21
22 cudaMalloc((void**)&pA, (N*N)*sizeof(int));
23 cudaMalloc((void**)&pB, (N*N)*sizeof(int));
24 cudaMalloc((void**)&pC, (N*N)*sizeof(int));
25
26 cudaMemcpy(pA, A, (N*N)*sizeof(int), cudaMemcpyHostToDevice);
27 cudaMemcpy(pB, B, (N*N)*sizeof(int), cudaMemcpyHostToDevice);
28 cudaMemcpy(pC, C, (N*N)*sizeof(int), cudaMemcpyHostToDevice);
29
30 int numBlocks = 1;
31 dim3 threadsPerBlock(N,N);
32 MatAdd<<<numBlocks,threadsPerBlock>>>(pA,pB,pC);
33
34 cudaMemcpy(C, pC, (N*N)*sizeof(int), cudaMemcpyDeviceToHost);
35
36 int i, j; printf("C = \n");
37 for(i=0;i<N;i++){
38     for(j=0;j<N;j++){
39         printf("%d ", C[i][j]);
40     }
41     printf("\n");
42 }
43
44 cudaFree(pA);
45 cudaFree(pB);
46 cudaFree(pC);
47
48 printf("\n");
49
50 return 0;
51 }
