#include <stdio.h>
#include <cuda_runtime.h>

#define NUM_GALAXIAS 4
#define ESTRELLAS_POR_GALAXIA 8

__global__ void fase3_inteligencia() {
    int idGalaxia = blockIdx.x;
    int idEstrella = threadIdx.x;
    int brillo = (idGalaxia * idEstrella + idEstrella * 7 + idGalaxia * 3) % 10;

    __shared__ float brillosCompartidos[ESTRELLAS_POR_GALAXIA];
    // escritura en memoria compartida
    brillosCompartidos[idEstrella] = (float)brillo;
    // esperar para asegurar que todos hayan escrito
    __syncthreads(); 
    printf("   Galaxia %d - Estrella %d -> Brillo: %d\n", idGalaxia, idEstrella, brillo);
    __syncthreads();

    if (idEstrella == 0) {
        float suma = 0.0;
        for (int i = 0; i < ESTRELLAS_POR_GALAXIA; i++) {
            suma += brillosCompartidos[i];
        }
        float promedio = suma / ESTRELLAS_POR_GALAXIA;
        
        printf(" Galaxia %d: Suma %.0f / %d = Promedio: %.2f\n\n", 
               idGalaxia, suma, ESTRELLAS_POR_GALAXIA, promedio);
    }
}

int main() {
    printf("--- FASE 3: Galaxias Inteligentes (Memoria compartida)---\n\n");
    fase3_inteligencia<<<NUM_GALAXIAS, ESTRELLAS_POR_GALAXIA>>>();
    cudaDeviceSynchronize();
    return 0;
}