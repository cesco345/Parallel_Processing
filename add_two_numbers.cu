   #include <stdio.h>
 2
 3 #define N 1000
 4
 5 //
 6 // A function marked __global__
 7 // runs on the GPU but can be called from
 8 // the CPU.
 9 //
10 // This function multiplies the elements of an array
11 // of ints by 2.
12 //
13 // The entire computation can be thought of as running
14 // with one thread per array element with blockIdx.x
15 // identifying the thread.
16 //
17 // The comparison i<N is because often it isn't convenient
18 // to have an exact 1-1 correspondence between threads
19 // and array elements. Not strictly necessary here.
20 //
21 // Note how we're mixing GPU and CPU code in the same source
22 // file. An alternative way to use CUDA is to keep
23 // C/C++ code separate from CUDA code and dynamically
24 // compile and load the CUDA code at runtime, a little
25 // like how you compile and load OpenGL shaders from
26 // C/C++ code.
27 //
28 __global__
29 void add(int *a, int *b) {
30     int i = blockIdx.x;
31     if (i<N) {
32         b[i] = 2*a[i];
33     }
34 }
35
36 int main() {
37     //
38     // Create int arrays on the CPU.
39     // ('h' stands for "host".)
40     //
41     int ha[N], hb[N];
42
43     //
44     // Create corresponding int arrays on the GPU.
45     // ('d' stands for "device".)
46     //
47     int *da, *db;
48     cudaMalloc((void **)&da, N*sizeof(int));
49     cudaMalloc((void **)&db, N*sizeof(int));
50
51     //
52     // Initialise the input data on the CPU.
53     //
54     for (int i = 0; i<N; ++i) {
55         ha[i] = i;
56     }
57
58     //
59     // Copy input data to array on GPU.
60     //
61     cudaMemcpy(da, ha, N*sizeof(int), cudaMemcpyHostToDevice);
62
63     //
64     // Launch GPU code with N threads, one per
65     // array element.
66     //
67     add<<<N, 1>>>(da, db);
68
69     //
70     // Copy output array from GPU back to CPU.
71     //
72     cudaMemcpy(hb, db, N*sizeof(int), cudaMemcpyDeviceToHost);
73
74     for (int i = 0; i<N; ++i) {
75         printf("%d\n", hb[i]);
76     }
77
78     //
79     // Free up the arrays on the GPU.
80     //
81     cudaFree(da);
82     cudaFree(db);
83
84     return 0;
85 }
