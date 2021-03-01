#include<stdio.h>
#include<cuda.h>

__global__ void dkernel()
{
    printf("Hello World! \n");
}

int main()
{
    dkernel<<<1, 32>>>(); //32 threads within 1 thread block
    cudaDeviceSynchronize();

    return 0;
}