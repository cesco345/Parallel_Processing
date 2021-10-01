 1 #include <pthread.h>
 2 #include <stdio.h>
 3
 4 #define THREADS 4
 5
 6 /* the function called for each thread */
 7 void* f(void* data) {
 8     printf("Hello from a thread!\n");
 9     pthread_exit(NULL);
10 }
11
12 int main() {
13     /* an array of threads */
14     pthread_t threads[THREADS];
15
16     for (int t = 0; t < THREADS; t++) {
17         pthread_create(&threads[t], NULL, f, NULL);
18     }
19
20     pthread_exit(NULL);
21 }
22
