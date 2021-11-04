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
		const objetosEncontrados = game.getObjectsIn(position.up(1))
		if (objetosEncontrados.size() == 0 || objetosEncontrados.all({ elemento => not elemento.esInamobible() })) {
			position = position.up(1)
		}
	}
	
	method bajar() {
		const objetosEncontrados = game.getObjectsIn(position.down(1))
		if (objetosEncontrados.size() == 0 || objetosEncontrados.all({ elemento => not elemento.esInamobible() })) {
			position = position.down(1)
		}
	}
	
	method moverDerecha() {
		const objetosEncontrados = game.getObjectsIn(position.right(1))
		if (objetosEncontrados.size() == 0 || objetosEncontrados.all({ elemento => not elemento.esInamobible() })) {
			position = position.right(1)
		}
	}
	
	method moverIzquierda() {
		const objetosEncontrados = game.getObjectsIn(position.left(1))
		if (objetosEncontrados.size() == 0 || objetosEncontrados.all({ elemento => not elemento.esInamobible() })) {
			position = position.left(1)
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





