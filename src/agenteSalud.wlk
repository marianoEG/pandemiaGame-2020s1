import manzanas.*
import personas.*
import simulacion.*
import wollok.game.*
object agenteSalud {
	var property image = "gines.png"
	var property position = game.at(0,2)
	method aislarInfectadosConSintomas(){
		simulacion.aislarInfectadosConSintomas()
	}
	method convencerQueRespetenCuarentena(manzana){
		manzana.personas().forEach({ p => p.respetarCuarentena() })
	}
	
	method moverDerecha(){self.position(self.position().right(1))}
	method moverIzquierda(){self.position(self.position().left(1))}
	method moverArriba(){self.position(self.position().up(1))}
	method moverAbajo(){self.position(self.position().down(1))}
	
}



