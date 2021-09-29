 1 #include <stdio.h>
 2
 3 __global__ void hello_cuda()
 4 {
 5     printf("Hello CUDA world \n");
 6 }
 7
 8 int main()
 9 {
10     int nx, ny;
11     nx = 2;
12     ny = 2;
13
14     dim3 block(2, 1);
15     dim3 grid(nx / block.x,ny / block.y);
16
17     hello_cuda << < 2,2 >> > ();
18     cudaDeviceSynchronize();
19
20     cudaDeviceReset();
21     return 0;
22 }
23
