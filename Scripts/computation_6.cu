#include<stdio.h>
#include<cuda.h>
#define N 8000

__global__ void fun(int *a, int aLen)
{
    unsigned int id = threadIdx.x;
    if(id < aLen)   a[id] = 0;
}

__global__ void add(int *a, int aLen)
{
    unsigned int id = threadIdx.x;
    if(id < aLen)   a[id] += id;
}

int main()
{
    int *da, i = 0;

    cudaMalloc(&da, sizeof(int) * N);
    fun<<<1, N>>>(da, N);
    add<<<1, N>>>(da, N);

    int a[N];
    cudaMemcpy(a, da, sizeof(int) * N, cudaMemcpyDeviceToHost);

    for(i = 0; i < N; i++)
    {
        printf("%d ", a[i]);
    }

    return 0;
}