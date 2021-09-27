   #include <mpi.h>
 2 #include <stdio.h>
 3
 4 int main(int argc, char** argv) {
 5     // Initialize the MPI environment
 6     MPI_Init(NULL, NULL);
 7
 8     // Get the number of processes
 9     int world_size;
10     MPI_Comm_size(MPI_COMM_WORLD, &world_size);
11
12     // Get the rank of the process
13     int world_rank;
14     MPI_Comm_rank(MPI_COMM_WORLD, &world_rank);
15
16     // Get the name of the processor
17     char processor_name[MPI_MAX_PROCESSOR_NAME];
18     int name_len;
19     MPI_Get_processor_name(processor_name, &name_len);
20
21     // Print off a hello world message
22     printf("Hello world from processor %s, rank %d out of %d processors\n",
23            processor_name, world_rank, world_size);
24
25     // Finalize the MPI environment.
26     MPI_Finalize();
27 }
28
 
