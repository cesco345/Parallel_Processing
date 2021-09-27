   #include <mpi.h>
 2 #include <stdio.h>
 3
 4
 5 int main (int argc, char **argv)
 6 {
 7     int num_procs;
 8     int rank;
 9
10     MPI_Init(&argc, &argv);
11     MPI_Comm_size(MPI_COMM_WORLD, &num_procs);
12     MPI_Comm_rank(MPI_COMM_WORLD, &rank);
13     printf("%d: hello (p=%d)\n", rank, num_procs);
14
15     MPI_Finalize();
16
17 }
