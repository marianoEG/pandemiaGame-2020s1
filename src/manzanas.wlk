import personas.*
import simulacion.*
import wollok.game.*

class Manzana {
	const property personas = []
	var property position
	
	method image() {
		return if (self.estanTodosInfectados()){ "rojo.png" }
		else if (self.numeroDeInfectados() > 7 and self.numeroDeInfectados() < self.personas().size()){ "naranjaOscuro.png" }
		else if (self.numeroDeInfectados().between(4,7)){ "naranja.png"}
		else if (self.numeroDeInfectados().between(1,3)){ "amarillo.png"}
		else { "blanco.png"}
	}
	
	// este les va a servir para el movimiento
	method esManzanaVecina(manzana) {
		return manzana.position().distance(position) == 1
	}

	method pasarUnDia() {
		self.transladoDeUnHabitante()
		self.simulacionContagiosDiarios()
		self.personas().forEach({ p => p.curarse() })
		
	}
	
	method personaSeMudaA(persona, manzanaDestino) {
		self.personas().remove(persona)
		manzanaDestino.agregarHabitante(persona)
	}
	
	method cantidadContagiadores() {
		return self.infectadosNoAislados().size()
	}
	
	method noInfectades() {
		return personas.filter({ pers => not pers.estaInfectada() })
	} 	
	
	method simulacionContagiosDiarios() { 
		const cantidadContagiadores = self.cantidadContagiadores()
		if (cantidadContagiadores > 0) {
			self.noInfectades().forEach({ persona => 
				if (simulacion.debeInfectarsePersona(persona, cantidadContagiadores)) {
					persona.infectarse()
				}
			})
		}
	}
	
	method transladoDeUnHabitante() {
		const quienesSePuedenMudar = personas.filter({ pers => not pers.estaAislada() })
		if (quienesSePuedenMudar.size() > 2) {
			const viajero = quienesSePuedenMudar.anyOne()
			const destino = simulacion.manzanas().filter({ manz => self.esManzanaVecina(manz) }).anyOne()
			self.personaSeMudaA(viajero, destino)			
		}
	}
	
	method estanTodosInfectados(){ return personas.all({p=>p.estaInfectada()})}
	method infectadosNoAislados(){ return personas.filter({p=>p.estaInfectada() and not p.estaAislada()})}
	
	method agregarHabitante(persona){ self.personas().add(persona)}
	
	method totalHabitantes(){ return self.personas().size()}
	method numeroDeInfectados(){ return personas.count({p=>p.estaInfectada()})}
	method numeroinfectadosConSintomas(){ return personas.count({p=>p.tieneSintomas()})}
	method numeroDeAislados(){ return personas.count({p=>p.estaAislada()})}
	method numeroDeContagiadores(){ return self.infectadosNoAislados().size()}
	method cantidadCuarentena(){return personas.count({p=>p.respetaCuarentena()})}
	
	
	method infectadosConSintomas(){ return personas.filter({p=>p.tieneSintomas()})}
	
	method aislarInfectadosSintomaticos(){ self.infectadosConSintomas().forEach({p=>p.aislar()})}
	
	method agregarInfectado(){
		const person = new Persona()
		person.infectarse()
		person.tenerSintoma(simulacion.chanceDePresentarSintomas()) 
		self.agregarHabitante(person)
	}
	
	
	
	
		
		
}
	
	

