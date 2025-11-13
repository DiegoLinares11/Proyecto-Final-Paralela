#include <stdio.h>
#include <cuda_runtime.h>

#define NUM_GALAXIAS 4
#define ESTRELLAS_POR_GALAXIA 8

__global__ void fase2_sincronizacion() {
    int idGalaxia = blockIdx.x;
    int idEstrella = threadIdx.x;

    int brillo = (idGalaxia * idEstrella + idEstrella * 7 + idGalaxia * 3) % 10;

    if (idEstrella == 0) {
        printf("\n>>> Galaxia %d iniciando reporte de brillos:\n", idGalaxia);
    }


    // Ahorita si a imprimir en orden
    printf("   Estrella %d -> Brillo %d\n", idEstrella, brillo);
}

int main() {
    printf("--- FASE 2: Sincronizando Estrellas ---\n");
    fase2_sincronizacion<<<NUM_GALAXIAS, ESTRELLAS_POR_GALAXIA>>>();
    cudaDeviceSynchronize();
    return 0;
}