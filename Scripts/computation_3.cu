#include<stdio.h>
#include<cuda.h>
#define N 100

__global__ void func(int *a)
{
    a[threadIdx.x] = threadIdx.x * threadIdx.x;
}


//This won't work since GPU and CPU will have different memory and the array is assigned in CPU
//The GPU can't access the same memory

// int main()
// {
//     int a[N] = {0}, i = 0;
    
//     func<<<1, N>>>(a);

//     cudaDeviceSynchronize();
//     for(i = 0; i < N; i++)
//     {
//         printf("%d ", a[i]);
//     }

//     return 0;
// }


int main()
{
    int a[N] = {0}, *da, i = 0;
    
    cudaMalloc(&da, sizeof(int) * N);
    func<<<1, N>>>(da);
    cudaMemcpy(a, da, N * sizeof(int), cudaMemcpyDeviceToHost);

    //cudaDeviceSyncronize() not needed since cudaMemory halts the CPU and then goes to the queue of GPU

    for(i = 0; i < N; i++)
    {
       printf("%d ", a[i]);
    }

    return 0;
}