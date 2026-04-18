// Procedimiento para poner la RAM en estado inicial (vacía) \\
SubProceso InicializarRAM(MapaBits, RAM)
    Definir i Como Entero
    Para i <- 1 Hasta 4 Hacer
        MapaBits[i] <- 0  // 0 significa LIBRE \\
        RAM[i] <- -1      // -1 indica que no hay datos/páginas \\
    FinPara
FinSubProceso

// Imprime el estado de ocupación \\
SubProceso MostrarMapaBits(MapaBits)
    Definir i Como Entero
    Escribir "ESTADO DEL MAPA DE BITS (Ocupación):"
    Escribir "Marcos:  M0  M1  M2  M3"
    Escribir "Bits:    " Sin Saltar
    Para i <- 1 Hasta 4 Hacer
        Escribir MapaBits[i], "   " Sin Saltar
    FinPara
    Escribir "" // Salto de línea \\
FinSubProceso

Algoritmo AdministradorMemoria
    // Definimos los arreglos de 4 espacios \\
    // Para que sepan PSeint usa índices del 1 al 4 para representar M0 a M3 \\ 
    Dimension MapaBits[4]
    Dimension RAM[4]
    
    // 1. Inicio \\ 
    InicializarRAM(MapaBits, RAM)
    
    // 2. Mostramos el estado inicial (deberían ser todos 0) \\ 
    MostrarMapaBits(MapaBits)
    
    // Ejemplo extra: Simular que ocupamos el marco M1 (índice 2) \\ 
    Escribir ""
    Escribir "Simulando carga de página en M1..."
    MapaBits[2] <- 1
    RAM[2] <- 101 // Supongamos que cargamos la página 101 \\
    
    // Volvemos a mostrar para ver el cambio \\
    MostrarMapaBits(MapaBits)
    
FinAlgoritmo




