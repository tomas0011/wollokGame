import wollok.game.*
import nivel1.*
import elementos.*

// en la implementación real, conviene tener un personaje por nivel
// los personajes probablemente tengan un comportamiendo más complejo que solamente
// imagen y posición



class Numero {
	
	var property position
	var property image = "mana (0).png"
	method esInamobible() = false
	
	method cambiarNumeroA_(num){
		self.image(num + ".png")
	}
}

class Personaje inherits ElementoMovil {
	
}

class PersonajePrincipal inherits ElementoMovil {
	var vida = 99
	var mana = 99
	override method image() = "player.png"
	
	override method subir() {
		super()
		self.perderMana(1)
	}
	
	override method bajar() {
		super()
		self.perderMana(1)
	}
	
	override method moverDerecha() {
		super()
		self.perderMana(1)
	}
	
	override method moverIzquierda() {
		super()
		self.perderMana(1)
	}
	
	method mostrarEstadisticas(){
		const vidaString = vida.toString().split("")
		const manaString = mana.toString().split("")
		
		if(vidaString.size() == 1){ vidaString.add("-") }
		if(manaString.size() == 1){ manaString.add("-") }
		
		const fsVida = new Numero(position = game.at(0,0), image = "vida ("+vidaString.get(0)+").png")		
		const scVida = new Numero(position = game.at(1,0), image = "vida ("+vidaString.get(1)+").png")
		
		const fsMana = new Numero(position = game.at(3,0), image = "mana ("+manaString.get(0)+").png")		
		const scMana = new Numero(position = game.at(4,0), image = "mana ("+manaString.get(1)+").png")
		game.addVisual(fsVida)
		game.addVisual(scVida)
		game.addVisual(fsMana)
		game.addVisual(scMana)
	}
	
	method perderVida(vidaPerdida){
		const vidaProxima = vida - vidaPerdida
		if(vidaProxima <= 0){
			//nivelBloques.terminar()
			vida = 0
		} else {
			vida = vidaProxima
		}
		self.mostrarEstadisticas()
	}
	
	method ganarVida(vidaGanada){
		vida = vida + vidaGanada
	}
	
	method perderMana(manaPerdido){
		const manaProximo = mana - manaPerdido
		if(manaProximo  <= 0){
			mana = 0
		} else {
			mana = manaProximo 
		}
		self.mostrarEstadisticas()
	}
	
	method ganarMana(manaGanado){
		mana = mana + manaGanado
	}	
}

