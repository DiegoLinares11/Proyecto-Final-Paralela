#include <stdio.h>
#include <cuda_runtime.h>

#define NUM_GALAXIAS 4
#define ESTRELLAS_POR_GALAXIA 8

__global__ void fase1_construccion() {
    int idGalaxia = blockIdx.x;
    int idEstrella = threadIdx.x;

    int brillo = (idGalaxia * idEstrella + idEstrella * 7 + idGalaxia * 3) % 10;

    // No esperar a nadie
    printf("Galaxia %d - Estrella %d -> Brillo: %d\n", idGalaxia, idEstrella, brillo);
}

int main() {
    printf("--- FASE 1: Construccion de la Galaxia ---\n");
    fase1_construccion<<<NUM_GALAXIAS, ESTRELLAS_POR_GALAXIA>>>();
    cudaDeviceSynchronize(); // Esperar a la GPU
    return 0;
}