# Parallel_Programming
Parallel programming technologies such as MPI and PVM are used in a distributed computing environment while threads are limited to a single computer system. All threads within a process share the same address space. A thread is spawned by defining a function and it's arguments which will be processed in the thread. The purpose of using the POSIX thread library in your software is to execute software faster.

Thread Synchronization:
The threads library provides three synchronization mechanisms:

mutexes - Mutual exclusion lock: Block access to variables by other threads. This enforces exclusive access by a thread to a variable or set of variables.
joins - Make a thread wait till others are complete (terminated).
condition variables - data type pthread_cond_t

Mutexes:
Mutexes are used to prevent data inconsistencies due to race conditions. A race condition often occurs when two or more threads need to perform operations on the same memory area, but the results of computations depends on the order in which these operations are performed. Mutexes are used for serializing shared resources. Anytime a global resource is accessed by more than one thread the resource should have a Mutex associated with it. One can apply a mutex to protect a segment of memory ("critical region") from other threads. Mutexes can be applied only to threads in a single process and do not work between processes as do semaphores.
Example threaded function:

Without Mutex	With Mutex
int counter=0;

/* Function C */
void functionC()
{
   counter++
}
                
/* Note scope of variable and mutex are the same */
pthread_mutex_t mutex1 = PTHREAD_MUTEX_INITIALIZER;
int counter=0;

/* Function C */
void functionC()
{
   pthread_mutex_lock( &mutex1 );
   counter++
   pthread_mutex_unlock( &mutex1 );
}

Possible execution sequence

Thread 1	Thread 2	Thread 1	Thread 2
counter = 0	counter = 0	counter = 0	counter = 0
counter = 1	counter = 1	counter = 1	Thread 2 locked out.
Thread 1 has exclusive use of variable counter



counter = 2
If register load and store operations for the incrementing of variable counter occurs with unfortunate timing, it is theoretically possible to have each thread increment and overwrite the same variable with the same value. Another possibility is that thread two would first increment counter locking out thread one until complete and then thread one would increment it to 2.

Sequence	Thread 1	Thread 2
1	counter = 0	counter=0
2	Thread 1 locked out.
Thread 2 has exclusive use of variable counter	counter = 1
3	counter = 2	

