// Kylo Ren c2022
#include<iostream>
#include<cuda.h>

using namespace std;

__global__ void addInteger(int* a, int* b){
    a[0] += b[0];
}

int main(){
    int a=2, b=3;
    int *d_a, *d_b;

    cudaMalloc(&d_a, sizeof(int));
    cudaMalloc(&d_b, sizeof(int));

    cudaMemcpy(d_a, &a, sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, &b, sizeof(int), cudaMemcpyHostToDevice);

    addInteger<<< 1, 1 >>>(d_a, d_b);

    cudaMemcpy(&a, d_a, sizeof(int), cudaMemcpyDeviceToHost);

    cudaFree(d_a);
    cudaFree(d_b);

    cout<<"Sum of "<<a<<" and "<<b<<" is : "<< a<<endl;

    return 0;
}

