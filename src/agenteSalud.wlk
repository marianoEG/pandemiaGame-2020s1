import manzanas.*
import personas.*
import simulacion.*
object agenteSalud {
	method aislarInfectadosConSintomas(){
		simulacion.aislarInfectadosConSintomas()
	}
	method convencerQueRespetenCuarentena(manzana){
		manzana.personas().forEach({ p => p.respetarCuarentena() })
	}
	
}
