Proceso Principal
	
    Definir CANT_MARCOS_USUARIO Como Entero
    CANT_MARCOS_USUARIO = 3
	
    Dimension Referencias[12]
	
    Referencias[1] = 1
    Referencias[2] = 2
    Referencias[3] = 3
    Referencias[4] = 4
    Referencias[5] = 1
    Referencias[6] = 2
    Referencias[7] = 5
    Referencias[8] = 1
    Referencias[9] = 2
    Referencias[10] = 3
    Referencias[11] = 4
    Referencias[12] = 5
	
    Dimension Marcos[3]
    Dimension Ocupado[3]
	
    Definir fallosFIFO, fallosOPT Como Entero
	
    fallosFIFO = SimularFIFO(Marcos, Ocupado, Referencias, CANT_MARCOS_USUARIO)
    fallosOPT = SimularOPT(Marcos, Ocupado, Referencias, CANT_MARCOS_USUARIO)
	
    Escribir "Fallos de página FIFO: ", fallosFIFO
    Escribir "Fallos de página OPT: ", fallosOPT
	
FinProceso


// -------------------------------------------
// Buscar página en marcos
// -------------------------------------------
Funcion idx <- BuscarPaginaEnMarcos(pag, Marcos, Ocupado, CANT)
	
    Definir i Como Entero
    idx = -1
	
    Para i = 1 Hasta CANT
        Si Ocupado[i] = 1 Y Marcos[i] = pag Entonces
            idx = i
        FinSi
    FinPara
	
FinFuncion


// -------------------------------------------
// FIFO
// -------------------------------------------
Funcion f <- SimularFIFO(Marcos, Ocupado, Referencias, CANT)
	
    Definir fallos, punteroFIFO, libre, i, t, pag Como Entero
	
    fallos = 0
    punteroFIFO = 1
	
    // Inicializar
    Para i = 1 Hasta CANT
        Ocupado[i] = 0
        Marcos[i] = -1
    FinPara
	
    Para t = 1 Hasta 12
        pag = Referencias[t]
		
        Si BuscarPaginaEnMarcos(pag, Marcos, Ocupado, CANT) = -1 Entonces
			Escribir "Fallo de página con: ", pag
            fallos = fallos + 1
			
            libre = -1
            Para i = 1 Hasta CANT
                Si Ocupado[i] = 0 Entonces
                    libre = i
                FinSi
            FinPara
			
            Si libre <> -1 Entonces
                Ocupado[libre] = 1
                Marcos[libre] = pag
            Sino
                Marcos[punteroFIFO] = pag
                punteroFIFO = punteroFIFO + 1
				
                Si punteroFIFO > CANT Entonces
                    punteroFIFO = 1
                FinSi
            FinSi
        FinSi
		Escribir "Referencia: ", pag
		Escribir "Marcos: ", Marcos[1], " ", Marcos[2], " ", Marcos[3]
		Escribir "----------------------"
    FinPara
	
    f = fallos
	
FinFuncion


// -------------------------------------------
// Elegir víctima OPT
// -------------------------------------------
Funcion victima <- ElegirVictimaOPT(tActual, Marcos, Referencias, CANT)
	
	Definir mejorMarco, mayorDist, i, k, pag, dist Como Entero
	Definir encontrado Como Entero
	
    mejorMarco = 1
    mayorDist = -1
	
    Para i = 1 Hasta CANT
        pag = Marcos[i]
        dist = 9999
		
		encontrado = 0
		
	
		
		Para k = tActual + 1 Hasta 12
			Si Referencias[k] = pag Y encontrado = 0 Entonces
				dist = k - tActual
				encontrado = 1
			FinSi
		FinPara
        Si dist > mayorDist Entonces
            mayorDist = dist
            mejorMarco = i
        FinSi
    FinPara
	
    victima = mejorMarco
	
FinFuncion


// -------------------------------------------
// OPT
// -------------------------------------------
Funcion f <- SimularOPT(Marcos, Ocupado, Referencias, CANT)
	
    Definir fallos, libre, i, t, pag, v Como Entero
	
    fallos = 0
	
    // Inicializar
    Para i = 1 Hasta CANT
        Ocupado[i] = 0
        Marcos[i] = -1
    FinPara
	
    Para t = 1 Hasta 12
        pag = Referencias[t]
		
        Si BuscarPaginaEnMarcos(pag, Marcos, Ocupado, CANT) = -1 Entonces
            fallos = fallos + 1
			
            libre = -1
            Para i = 1 Hasta CANT
                Si Ocupado[i] = 0 Entonces
                    libre = i
                FinSi
            FinPara
			
            Si libre <> -1 Entonces
                Ocupado[libre] = 1
                Marcos[libre] = pag
            Sino
                v = ElegirVictimaOPT(t, Marcos, Referencias, CANT)
                Marcos[v] = pag
            FinSi
        FinSi
    FinPara
	
    f = fallos
	
FinFuncion