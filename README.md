# Proyecto-Integrador-U1-MED135
Simulador Avanzado de Gestión de Memoria(MMU) en Pseudocódigo

# Grupo 2

- Brenda Ivania Lainez Vides | lv19015. 
- Kevin Daniel Hernández Belloso | hh25003.
- Alfredo Enrique Ortiz Hernández | oh23001.

# Descripción del Proyecto

Este simulador modela el comportamiento de una **Unidad de Administración de Memoria (MMU)** en un sistema con paginación y memoria virtual.  
El programa implementa:

- Gestión de memoria RAM física (16 KB dividida en 4 marcos de 4 KB).
- Memoria virtual (swap) de 32 KB.
- Traducción de direcciones lógicas a físicas.
- Mapa de bits de ocupación de marcos.
- Dos algoritmos de reemplazo de páginas: **FIFO** y **Óptimo (OPT)**.

La simulación procesa una secuencia predefinida de páginas lógicas [1, 2, 3, 4, 1, 2, 5, 1, 2, 3, 4, 5], con **solo 3 marcos físicos disponibles** para páginas de usuario, forzando así fallos de página y reemplazos.


## Cómo Ejecutar el Script

### Requisitos
- **PSeInt** (versión estable reciente) o cualquier entorno que soporte pseudocódigo estructurado con subrutinas, arreglos y paso de parámetros.
- No requiere librerías externas.

### Pasos para ejecutar

1. Abre el archivo `SimuladorMMU.psc` en PSeInt.
2. Asegúrate de que el perfil de ejecución permita el uso de **subprocesos** (funciones y procedimientos).
3. Ejecuta la simulación presionando **F9** o el botón **Ejecutar**.
4. El programa mostrará en consola:
   - Mapa de bits de memoria física antes y después de la simulación.
   - Por cada algoritmo (FIFO y OPT):
     - La tabla de páginas final.
     - El estado de los marcos físicos.
     - **Número total de fallos de página**.
5. Al final, se presentará una comparación de resultados.

> **Importante**: La simulación es autocontenida. La lista de páginas futuras para el algoritmo OPT se pasa explícitamente desde el código (no se ingresa por teclado).


## Análisis de Rendimiento Matemático

### Resultados esperados (con 3 marcos físicos)

| Algoritmo | Fallos de página |
|-----------|------------------|
| FIFO      | 9                |
| Óptimo    | 7                |

### ¿Por qué el algoritmo Óptimo (OPT) tiene mejor rendimiento?

El algoritmo óptimo elige para reemplazo aquella página cuya **próxima referencia esté más lejana en el futuro** (o que nunca vuelva a usarse). Matemáticamente, minimiza la cantidad de fallos de página porque:

1. **Principio de optimización**: En cada decisión, OPT evita expulsar una página que será necesaria pronto, reduciendo la probabilidad de fallos inmediatos.
2. **Para la secuencia dada**:
   - En el momento crítico (página 5 entra), FIFO expulsa la página 1 (la más antigua), pero página 1 se necesita de nuevo en la posición 6 de la secuencia (muy pronto), generando un fallo evitable.
   - OPT, en cambio, examina el futuro y ve que página 4 no se usará hasta el final, por lo que la reemplaza. Así preserva página 1, evitando un fallo posterior.

### Limitación en la vida real 

Aunque OPT es matemáticamente óptimo, **no se puede implementar en sistemas reales** porque requiere conocer **todas las referencias futuras a páginas** con antelación. En un sistema operativo real:

- Las solicitudes de páginas dependen de la ejecución del usuario, entrada/salida, interrupciones, etc., que son impredecibles.
- No existe un "oráculo" que pueda anticipar la secuencia completa.
- Por eso se usan algoritmos prácticos como **FIFO, LRU, o Clock**, que aproximan el comportamiento óptimo basándose en el pasado reciente.


## Estructuras de Datos Implementadas

| Estructura               | Descripción                                                                 |
|--------------------------|-----------------------------------------------------------------------------|
| `marcos[4]`              | Arreglo que representa los marcos físicos (cada uno almacena una página).   |
| `mapaBits[4]`            | Mapa de bits: 1 = ocupado, 0 = libre.                                      |
| `tablaPagina_pagina[]`   | Páginas lógicas del proceso.                                               |
| `tablaPagina_marco[]`    | Marco físico asignado a cada página.                                       |
| `tablaPagina_presente[]` | Bit de presencia (1 = en RAM, 0 = en swap).                                |
| `colaFIFO`               | Cola (arreglo circular) para FIFO.                                         |
| `listaFuturo`            | Arreglo auxiliar para que OPT consulte las referencias futuras.            |


## Funciones Principales

- `MostrarMapaBits()`: Imprime el estado de los marcos libres/ocupados.
- `TraducirDireccion(paginaLogica, offset)`: Calcula dirección física si la página está presente; si no, dispara fallo.
- `manejarFalloDePaginaFIFO(pagina)`: Reemplaza según FIFO.
- `manejarFalloDePaginaOPT(pagina, indiceActual)`: Reemplaza según el criterio óptimo.
- `simular(algoritmo)`: Ejecuta toda la secuencia con el algoritmo indicado y cuenta fallos.


## Conclusión

Este simulador demuestra:
- Cómo interactúan la MMU, la tabla de páginas y la memoria física.
- La diferencia teórica y práctica entre FIFO y el algoritmo óptimo.
- La razón fundamental por la que los sistemas operativos no pueden usar OPT en entornos reales, a pesar de su superioridad matemática.

