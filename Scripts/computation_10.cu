// Launch config for huge data
#include <stdio.h>
#include <cuda.h>
#include <stdlib.h>
#define BLOCKSIZE 1024

__global__ void dkernel(unsigned *vector, unsigned vectorSize)
{
    unsigned id = blockIdx.x * blockDim.x + threadIdx.x;
    if(id < vectorSize) vector[id] = id;
}

int main(int nn, char *str[])
{
    unsigned N = atoi(str[1]);
    unsigned *vector, *hvector;
    unsigned i = 0;

    cudaMalloc(&vector, N * sizeof(unsigned));
    hvector = (unsigned *)malloc(N * sizeof(unsigned));

    unsigned nBlocks = ceil((float)N / BLOCKSIZE);
    printf("nBlocks = %d\n", nBlocks);

    dkernel<<<nBlocks, BLOCKSIZE>>>(vector, N);
    cudaMemcpy(hvector, vector, N * sizeof(unsigned), cudaMemcpyDeviceToHost);

    for(i = 0; i < N; i++)
    {
        printf("%d ", hvector[i]);
    }

    return 0;
}