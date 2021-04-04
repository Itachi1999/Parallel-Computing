// 1D version of the code

#include<stdio.h>
#include<stdlib.h>
#include<cuda.h>
#define N 5
#define M 6

__global__ void dkernel(unsigned *mat)
{
    unsigned xId = blockIdx.x, yId = threadIdx.x, col = blockDim.x;

    mat[xId * col + yId] = xId * col + yId;
}

int main()
{
    //dim3 block(N, M, 1);
    unsigned *matrix, *hmatrix, i = 0, j = 0;

    cudaMalloc(&matrix, N * M * sizeof(unsigned));
    hmatrix = (unsigned *)malloc(N * M * sizeof(unsigned));

    dkernel<<<N, M>>>(matrix);
    cudaMemcpy(hmatrix, matrix, N * M * sizeof(unsigned), cudaMemcpyDeviceToHost);

    for(i = 0; i < N; i++)
    {
        for(j = 0; j < M; j++)
        {
            printf("%d\t", hmatrix[i * M + j]);
        }
        printf("\n");
    }
    
    return 0;
}