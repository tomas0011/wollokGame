
import wollok.game.*
//import nivel1.*
import elementos.*
import configuracion.*
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
	
	override method puedeMover(direccion, direccionSiguiente) {
		const objetosEncontradosEnSiguiente = game.getObjectsIn(direccion)
		return (
			self.noHay(objetosEncontradosEnSiguiente)
		)
	}
	
}

class Arana inherits Enemigo {
	override method image() = "arana.png"
	
	method danarPersonajeSiExiste() {
		const objetosEncontradosEnSiguiente = game.getObjectsIn(self.position())
		const jugadoresEncontrados = objetosEncontradosEnSiguiente.filter({ elemento => elemento.esJugable() })
		jugadoresEncontrados.forEach({ jugador => self.quitarVidaA(jugador) })
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
	
	method moverHacia(personaje) {
		const distancia = self.position().distance(personaje.position()) 
		if (self.position().up(1).distance(personaje.position()) < distancia) {
			self.subir()
		} else if (self.position().down(1).distance(personaje.position()) < distancia) {
			self.bajar()
		} else if (self.position().left(1).distance(personaje.position()) < distancia) {
			self.moverIzquierda()
		} else {
			self.moverDerecha()
		}
	}
}

class PersonajePrincipal inherits Personaje {
	var property mana = 30
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
		const vidaString = vida.toString().split("")
		const manaString = mana.toString().split("")
		const llaveString = llaves.size().toString().split("")
		const dineroString = dinero.toString().split("")
		
		if (vidaString.size() == 1) {
			vidaString.add("fondo-vida")
		}
		if (manaString.size() == 1) { 
			manaString.add("fondo-mana")
		}
		if (llaveString.size() == 1) { 
			llaveString.add("fondo-llave")
		}
		if (dineroString.size() == 1){ 
			dineroString.add("fondo-moneda")
		} 
		if (dineroString.size() == 2) { 
			dineroString.add("fondo-moneda")
		}


		const fsFondoVida = new Numero(position = game.at(1,0), image = "fondo-vida.png")
		const scFondoVida = new Numero(position = game.at(2,0), image = "fondo-vida.png")	
		
		const fsVida = new Numero(position = game.at(1,0), image = vidaString.get(0) + ".png")		
		const scVida = new Numero(position = game.at(2,0), image = vidaString.get(1) + ".png")
		
		const fsFondoMana = new Numero(position = game.at(4,0), image = "fondo-mana.png")
		const scFondoMana = new Numero(position = game.at(5,0), image = "fondo-mana.png")	
		
		const fsMana = new Numero(position = game.at(4,0), image = manaString.get(0) + ".png")		
		const scMana = new Numero(position = game.at(5,0), image = manaString.get(1) + ".png")
		
		
		const w = gameSize.width()
		
		const scFondoLlave= new Numero(position = game.at(w-7,0), image = "fondo-llave.png")
		const fsLlave = new Numero(position= game.at(w-7,0), image = llaveString.get(0) + ".png")
		
		const fsFondoDinero= new Numero(position = game.at(w-5,0), image = "fondo-moneda.png")
		const scFondoDinero= new Numero(position = game.at(w-4,0), image = "fondo-moneda.png")
		const trFondoDinero= new Numero(position = game.at(w-3,0), image = "fondo-moneda.png")	
		
		const fsDinero= new Numero(position= game.at(w-5,0), image = dineroString.get(0)+".png")
		const scDinero= new Numero(position= game.at(w-4,0), image = dineroString.get(1)+".png")
		const trDinero= new Numero(position= game.at(w-3,0), image = dineroString.get(2)+".png")
		
		game.addVisual(fsFondoVida)
		game.addVisual(scFondoVida)
		game.addVisual(fsVida)
		game.addVisual(scVida)
		
		game.addVisual(fsFondoMana)
		game.addVisual(scFondoMana)
		game.addVisual(fsMana)
		game.addVisual(scMana)
		
		game.addVisual(scFondoLlave)
		game.addVisual(fsLlave)
		
		game.addVisual(fsFondoDinero)
		game.addVisual(scFondoDinero)
		game.addVisual(trFondoDinero)
		game.addVisual(fsDinero)
		game.addVisual(scDinero)
		game.addVisual(trDinero)	
	}
	
	override method perderVida(vidaPerdida){
		if (vida >= 2){
			super(vidaPerdida)
			self.mostrarEstadisticas()
		} else {
			niveles.nivel().terminar()
		}
	}
	
	override method ganarVida(vidaGanada){
		super(vidaGanada)
		self.mostrarEstadisticas()
	}
	
	method perderMana(manaPerdido){
		const manaProximo = mana - manaPerdido
		if (manaProximo >= 1){		
			if(manaProximo  <= 0){
				self.mana(0)
			} else {
				self.mana(manaProximo) 
			}
			self.mostrarEstadisticas()

		} else {
			niveles.nivel().terminar()
		}
	}
	
	method ganarMana(manaGanado){
		self.mana(mana + manaGanado)
		self.mostrarEstadisticas()
	}	
	
	method guardarDinero(valorAAgregar) {
		self.dinero(dinero + valorAAgregar)
		self.mostrarEstadisticas()
	}
	
	method guardarLlave(nuevaLlave) {
		llaves.add(nuevaLlave)
		self.mostrarEstadisticas()
	}
}

