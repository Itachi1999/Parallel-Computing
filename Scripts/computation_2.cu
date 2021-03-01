#include <stdio.h>
#include <cuda.h>
#define N 100

//Sequential

// __global__ void dkernel()
// {
//     int i = 0;
//     for(i = 0; i < N; i++)
//     {
//         printf("%d\n", i * i);    
//     }
// }

// int main()
// {
//     dkernel<<<1, 1>>>();
//     cudaDeviceSynchronize();
//     return 0;
// }


//Parallel


//Thread Ids always start from zero and get increased sequentially
__global__ void func()
{
    printf("%d\n", threadIdx.x * threadIdx.x);
}

int main()
{
    func<<<1, N>>>();
    cudaDeviceSynchronize();

    return 0;
}

