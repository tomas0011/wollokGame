import wollok.game.*
import nivel1.*

class Elemento {	
	var property position

	method image()	
	method esInamobible()
	method tieneEfecto()
}

class ElementoMovil inherits Elemento {
	
	override method esInamobible() = false
	override method tieneEfecto() = false
	
	method subir() {
		const siguientePosicion = position.up(1)
		const objetosEncontrados = game.getObjectsIn(siguientePosicion)
		const x =  siguientePosicion.x()
		const y =  siguientePosicion.y()
		
		if (objetosEncontrados.size() == 0 || objetosEncontrados.all({ elemento => not elemento.esInamobible() })) {
			if (y == 10) {
				position = game.at(x, 1)
			} else {
				position = siguientePosicion	
			}
		}
	}
	
	method bajar() {
		const siguientePosicion = position.down(1)
		const objetosEncontrados = game.getObjectsIn(siguientePosicion)
		const x =  siguientePosicion.x()
		const y =  siguientePosicion.y()
		
		if (objetosEncontrados.size() == 0 || objetosEncontrados.all({ elemento => not elemento.esInamobible() })) {
			if (y == 0) {
				position = game.at(x, 9)
			} else {
				position = siguientePosicion	
			}
		}
	}
	
	method moverDerecha() {
		const siguientePosicion = position.right(1)
		const objetosEncontrados = game.getObjectsIn(siguientePosicion)
		const x =  siguientePosicion.x()
		const y =  siguientePosicion.y()
		
		if (objetosEncontrados.size() == 0 || objetosEncontrados.all({ elemento => not elemento.esInamobible() })) {
			if (x == 20) {
				position = game.at(0, y)
			} else {
				position = siguientePosicion	
			}
		}
	}
	
	method moverIzquierda() {
		const siguientePosicion = position.left(1)
		const objetosEncontrados = game.getObjectsIn(siguientePosicion)
		const x =  siguientePosicion.x()
		const y =  siguientePosicion.y()
		
		if (objetosEncontrados.size() == 0 || objetosEncontrados.all({ elemento => not elemento.esInamobible() })) {
			if (x == -1) {
				position = game.at(19, y)
			} else {
				position = siguientePosicion	
			}
		}
	}
}

class ElementoInmovil inherits Elemento {
	override method esInamobible() = true
	override method tieneEfecto() = false
}

class Consumible inherits Elemento {
	var property cantidad
	var property estaVacio = false
	override method esInamobible() = false
	override method tieneEfecto() = true
	method activarEfectoEn(personaje)
}

class ConsumibleDeMana inherits Consumible {	
	var image = "orbe-mana.png"
	
	override method image() = image
	
	method image(newImage) {
		image = newImage
	}
	
	method serConsumidoPor(personaje) {
		personaje.ganarMana(self.cantidad())
		self.estaVacio(true)
		self.image("orbe-vacio.png")
	}
	
	override method activarEfectoEn(personaje) {
		if (not self.estaVacio()) {
			self.serConsumidoPor(personaje)	
		}
	}
}

class ConsumibleDeVida inherits Consumible {
	var image = "orbe-vida.png"
	
	override method image() = image
	
	method image(newImage) {
		image = newImage
	}
	
	method serConsumidoPor(personaje) {
		personaje.ganarVida(self.cantidad())
		self.estaVacio(true)
		self.image("orbe-vacio.png")
	}
	
	override method activarEfectoEn(personaje) {
		if (not self.estaVacio()) {
			self.serConsumidoPor(personaje)	
		}
	}
}

class Muro inherits ElementoInmovil {
	override method image() = "natureWall.png"
}

class Bloque inherits ElementoMovil {
	override method image() = "market.png" 	
}





