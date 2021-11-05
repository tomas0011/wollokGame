
import wollok.game.*
import nivel1.*
import elementos.*

// en la implementación real, conviene tener un personaje por nivel
// los personajes probablemente tengan un comportamiendo más complejo que solamente
// imagen y posición



class Numero {
	var property position
	var property image = "mana (0).png"
	method esInamobible() = true
	method tieneEfecto() = false
	method esDeBarra() = true
	
	method cambiarNumeroA_(num){
		self.image(num + ".png")
	}
}

//class Texto {
//	var property position
//	var property text
//}

class Personaje inherits ElementoMovil {
	var property vida
	
	method perderVida(vidaPerdida){
		const vidaProxima = vida - vidaPerdida
		if(vidaProxima <= 0){
			//nivelBloques.terminar()
			self.vida(0)
		} else {
			self.vida(vidaProxima)
		}
	}
	
	method ganarVida(vidaGanada){
		self.vida(vida + vidaGanada)
	}
}

class Enemigo inherits Personaje {
	var property dano = 10
	
	method quitarVidaA(personaje) {
		personaje.perderVida(dano)
	}
	
	method hacerMovimientoRandom()
}

class Arana inherits Enemigo {
	override method image() = "arana.png"
	
	method danarPersonajeSiExiste() {
		const objetosEncontradosEnSiguiente = game.getObjectsIn(self.position())
		const jugadoresEncontrados = objetosEncontradosEnSiguiente.filter({ elemento => elemento.esJugable() })
		jugadoresEncontrados.forEach({ jugador => self.quitarVidaA(jugador) })
	}
	
	override method hacerMovimientoRandom() {
		const direccionAleatorea = 0.randomUpTo(5).truncate(0)
		if (direccionAleatorea == 1) {
			self.subir()
		} else if (direccionAleatorea == 2) {
			self.bajar()
		} else if (direccionAleatorea == 3) {
			self.moverIzquierda()
		} else {
			self.moverDerecha()
		}
	}
	
	override method subir() {
		super()
		self.danarPersonajeSiExiste()
	}
	
	override method bajar() {
		super()
		self.danarPersonajeSiExiste()
	}
	
	override method moverIzquierda() {
		super()
		self.danarPersonajeSiExiste()
	}
	
	override method moverDerecha() {
		super()
		self.danarPersonajeSiExiste()
	}
}

class PersonajePrincipal inherits Personaje {
	var property mana = 99
	var property dinero = 0
	const llaves = []
	
	override method esJugable() = true
	
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
		const vidaString = self.vida().toString().split("")
		const manaString = self.mana().toString().split("")
//		const llaveString = llaves.size().toString().split("")
//		const dineroString = dinero.toString().split("")
		
		if (vidaString.size() == 1) { 
			vidaString.add("-")
		}
		if (manaString.size() == 1) { 
			manaString.add("-")
		}
//		if (llaveString.size() == 1) { 
//			llaveString.add("-")
//		}
//		if (dineroString.size() == 1){ 
//			dineroString.add("--")
//		} else if (dineroString.size() == 2) { 
//			dineroString.add("-")
//		}
		
		const fsVida = new Numero(position = game.at(0,0), image = "vida ("+vidaString.get(0)+").png")		
		const scVida = new Numero(position = game.at(1,0), image = "vida ("+vidaString.get(1)+").png")
		
		const fsMana = new Numero(position = game.at(3,0), image = "mana ("+manaString.get(0)+").png")		
		const scMana = new Numero(position = game.at(4,0), image = "mana ("+manaString.get(1)+").png")
		
//		const textLlave = new Texto(position= game.at(6,0), text= llaveString)
//		
//		const textDinero = new Texto(position= game.at(18,0), text= dineroString)
		
		game.addVisual(fsVida)
		game.addVisual(scVida)
		game.addVisual(fsMana)
		game.addVisual(scMana)
		
//		game.addVisual(textLlave)
//		game.addVisual(textDinero)
	}
	
	override method perderVida(vidaPerdida){
		super(vidaPerdida)
		self.mostrarEstadisticas()
	}
	
	override method ganarVida(vidaGanada){
		super(vidaGanada)
		self.mostrarEstadisticas()
	}
	
	method perderMana(manaPerdido){
		const manaProximo = mana - manaPerdido
		if(manaProximo  <= 0){
			self.mana(0)
		} else {
			self.mana(manaProximo) 
		}
		self.mostrarEstadisticas()
	}
	
	method ganarMana(manaGanado){
		self.mana(mana + manaGanado)
		self.mostrarEstadisticas()
	}	
	
	method guardarDinero(valorAAgregar) {
		self.dinero(dinero + valorAAgregar)
		game.say(self, dinero.toString())
	}
	
	method guardarLlave(nuevaLlave) {
		llaves.add(nuevaLlave)
		game.say(self, llaves.size().toString())
	}
}

