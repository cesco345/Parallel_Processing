   // A simple Hello World CUDA program.
 2
 3 // #include the entire body of the cuPrintf code
 4 //#include "util/cuPrintf.cu"
 5
 6 // #include <stdio.h> for host printf
 7 #include <stdio.h>
 8
 9
10 __global__ void device_greetings(void)
11 {
12   printf("Hello, world from the device!\n");
13 }
14
15
16 int main(void)
17 {
18   // greet from the host
19   printf("Hello, world from the host!\n");
20
21   // initialize cuPrintf
22   //cudaPrintfInit();
23
24   // launch a kernel with a single thread to greet from th>
25   device_greetings<<<1,1>>>();
26
27   // display the device's greeting
28   cudaDeviceSynchronize();
29
30   //cudaDeviceReset;
31   return 0;
32 }
