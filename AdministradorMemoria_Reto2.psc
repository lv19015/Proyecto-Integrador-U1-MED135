Algoritmo AdministradorMemoria_Reto2
	
    // Constantes
    Definir TAM_MARCO, MAXP Como Entero
    TAM_MARCO <- 4096
    MAXP <- 8
	
    // Arreglos
    Dimension Presente[MAXP]
    Dimension MarcoDePagina[MAXP]
	
    // Variables
    Definir i, paginaLogica, offset, dirFisica Como Entero
	
    // Inicialización
    Para i <- 1 Hasta MAXP Hacer
        Presente[i] <- 0
        MarcoDePagina[i] <- -1
    FinPara
	
    // Simulación de páginas cargadas
    Presente[1] <- 1
    MarcoDePagina[1] <- 2
    Presente[3] <- 1
    MarcoDePagina[3] <- 1
    Presente[4] <- 1
    MarcoDePagina[4] <- 0
	
    // Entrada
    Escribir "Ingrese numero de pagina logica (1 a ", MAXP, "):"
    Leer paginaLogica
	
    Escribir "Ingrese offset:"
    Leer offset
	
    // Llamada
    dirFisica <- TraducirDireccion(paginaLogica, offset, Presente, MarcoDePagina, MAXP, TAM_MARCO)
	
    // Resultado
    Si dirFisica = -1 Entonces
        Escribir "No se pudo traducir la direccion (fallo de pagina)"
    Sino
        Escribir "Direccion fisica: ", dirFisica
    FinSi
	
FinAlgoritmo

// Fase 2: La MMU y Traducción de Direcciones (Segmentación + Paginación)
Funcion dirFisica <- TraducirDireccion(paginaLogica, offset, Presente, MarcoDePagina, MAXP, TAM_MARCO)
	
    Definir dirFisica, marco Como Entero
	
    // Validación
    Si paginaLogica < 1 O paginaLogica > MAXP Entonces
        Escribir "Error: pagina fuera de rango"
        dirFisica <- -1
    Sino
        
        Si Presente[paginaLogica] = 0 Entonces
            Escribir "FALLO DE PAGINA en pagina ", paginaLogica
            dirFisica <- -1
        Sino
            marco <- MarcoDePagina[paginaLogica]
            dirFisica <- (marco * TAM_MARCO) + offset
        FinSi
        
    FinSi
	
FinFuncion