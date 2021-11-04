import wollok.game.*
import nivel1.*

class Elemento {	
	var property position
	
	method image()
	
	method esInamobible()
}

class ElementoMovil inherits Elemento {
	
	override method esInamobible() = false
	
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
}

class Consumible inherits Elemento {
	var property cantidad
	var property estaVacio = false
	override method esInamobible() = false
}

class ConsumibleDeMana inherits Consumible {
	override method image() = "orbe-mana.png"
}

class ConsumibleDeVida inherits Consumible {
	override method image() = "orbe-vida.png"
}

class Muro inherits ElementoInmovil {
	override method image() = "natureWall.png"
}

class Bloque inherits ElementoMovil {
	override method image() = "market.png" 	
}





