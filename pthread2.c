  GNU nano 4.8                                                                                                                                                                                        pthread2.c
 1 //Compile:  
 2 //g++ -pthread -o pthread2 pthread2.c -fpermissive
 3
 4 #include <stdio.h>
 5 #include <stdlib.h>
 6 #include <pthread.h>
 7
 8 #define NUM_THREADS 4
 9 #define BUMPS_PER_THREAD 5000
10 #define USE_MUTEX 1
11
12 int shared_counter = 0;
13 pthread_mutex_t shared_counter_mutex;
14
15 void *
16 bump_counter()
17 {
18     for(int i =0; i < BUMPS_PER_THREAD; i++) {
19 #if USE_MUTEX
20     pthread_mutex_lock(&shared_counter_mutex);
21     shared_counter++;
22     pthread_mutex_unlock(&shared_counter_mutex);
23 #else
24     shared_counter++;
25 #endif
26   }
27   return (void *)NULL;
28 }
29
30 void
31 check_thread_rtn(char *msge, int rtn) {
32     if (rtn) {
33         fprintf(stderr, "ERROR: %s (%d)\n", msge, rtn);
34         exit(1);
35     }
36 }
37
38 int
39 main(int argc, char **argv)
40 {
41     pthread_t threads[NUM_THREADS];
42
43     int rtn = pthread_mutex_init(&shared_counter_mutex, NULL);
44     check_thread_rtn("mutex init", rtn);
45
46     for (int i = 0; i < NUM_THREADS; i++) {
47         rtn = pthread_create(&threads[i], NULL, bump_counter, NULL);
48         check_thread_rtn("create", rtn);
49     }
50
51     for (int i = 0; i < NUM_THREADS; i++) {
52         rtn = pthread_join(threads[i], NULL);
53         check_thread_rtn("join", rtn);
54     }
55
56     int expected_value = NUM_THREADS * BUMPS_PER_THREAD;
57     int exit_value = 0;
58     if (shared_counter == expected_value) {
59         printf("Ended with %d as expected.\n\n", expected_value);
60     }  else {
61             printf("Expected %d, got %d - does not work.\n\n", expected_value, shared_counter);
62             exit_value = 1;
63     }
64
65     exit(exit_value);
66 }
67
