   #include <stdio.h>
 2
 3 __global__ void cuda_hello()
 4 {
 5 }
 6
 7 int main() {
 8     cuda_hello<<<1,1>>>();
 9     printf("Hello World from GPU!\n");
10     return 0;
11 }
12
