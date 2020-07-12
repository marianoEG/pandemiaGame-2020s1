import simulacion.*
import manzanas.*
class Persona {
	var property estaAislada = false
	var property tieneSintomas = false
	var property diaQueSeInfecto = 0
	var property estaInfectada = false
	var property respetaCuarentena = false
	var property estuvoInfectada = false
	
	method infectarse() { 
		if (not estuvoInfectada){
			
		estaInfectada = true 
		diaQueSeInfecto = simulacion.diaActual()
		estuvoInfectada = true
		tieneSintomas = 0.randomUpTo(100) < simulacion.chanceDePresentarSintomas()
		}
	}
	method respetarCuarentena() { respetaCuarentena = true}
	method aislar(){ estaAislada = true }
	method tenerSintoma(probabilidad){ tieneSintomas = 0.randomUpTo(100) < probabilidad }
	method curarse(){ if (simulacion.diaActual() - diaQueSeInfecto > 20) estaInfectada = false }
}

