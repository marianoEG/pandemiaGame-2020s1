import personas.*
import manzanas.*

object simulacion {
	var property diaActual = 0
	const property manzanas = []
	
	// parametros del juego
	const property chanceDePresentarSintomas = 30
	const property chanceDeContagioSinCuarentena = 25
	const property chanceDeContagioConCuarentena = 2
	const property personasPorManzana = 10
	const property duracionInfeccion = 20
	
	method pasarDiaBarrio(){ 
		manzanas.forEach({m=>m.pasarUnDia()})
		diaActual += 1
	}
	/*
	 * este sirve para generar un azar
	 * p.ej. si quiero que algo pase con 30% de probabilidad pongo
	 * if (simulacion.tomarChance(30)) { ... } 
	 */ 	
	method tomarChance(porcentaje) = 0.randomUpTo(100) < porcentaje

	method agregarManzana(manzana) { manzanas.add(manzana) }
	
	method debeInfectarsePersona(persona, cantidadContagiadores) {
		const chanceDeContagio = if (persona.respetaCuarentena()) 
			self.chanceDeContagioConCuarentena() 
			else 
			self.chanceDeContagioSinCuarentena()
		return (1..cantidadContagiadores).any({n => self.tomarChance(chanceDeContagio) })	
	}

	method crearManzana() {
		const nuevaManzana = new Manzana()
		const persona = new Persona()
		self.personasPorManzana().times({n => nuevaManzana.agregarHabitante(persona)})
		return nuevaManzana
	}
	
	method aislarInfectadosConSintomas(){ 
		manzanas.forEach({m=>m.aislarInfectadosSintomaticos()})
	}
	
	method cantidadDePersonasEnBarrio(){return manzanas.sum({m=>m.totalHabitantes()})}
	method infectadosEnBarrio(){return manzanas.sum({m=>m.numeroDeInfectados()})}
	method cantidadSintomaticos(){return manzanas.sum({m=>m.numeroinfectadosConSintomas()})}
	method cantidadAislados(){return manzanas.sum({m=>m.numeroDeAislados()})}
	method cantidadContagiadores(){return manzanas.sum({m=>m.numeroDeContagiadores()})}
	
	
	
	method elegirManzanaAlAzar(){ return manzanas.get(0.randomUpTo( manzanas.size() -1 ))}
	method importarCaso(){self.elegirManzanaAlAzar().agregarInfectado()}
	
	
	
	
}
