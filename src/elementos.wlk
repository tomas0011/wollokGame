import wollok.game.*
import nivel1.*
import configuracion.*

class Elemento {	
	var property position

	method image()	
	method esInamobible()
	method tieneEfecto()
	method esJugable() = false
	method esDeBarra() = false
}

class ElementoMovil inherits Elemento {
	
	override method esInamobible() = false
	
	override method tieneEfecto() = false
	
	override method esDeBarra() = false
	
	method puedeMover(direccion, direccionSiguiente) {
		const objetosEncontradosEnSiguiente = game.getObjectsIn(direccion)
		const objetosEncontradosEnConsiguiente = game.getObjectsIn(direccionSiguiente)
		
		if (
			objetosEncontradosEnConsiguiente.all({ elemento => elemento.esDeBarra() })
		) {
			return true
		} else {
			return (objetosEncontradosEnSiguiente.size() == 0) 
				|| (objetosEncontradosEnSiguiente.all({ elemento => not elemento.esInamobible() and not elemento.esDeBarra() })) 
				and (objetosEncontradosEnConsiguiente.size() == 0) 
				|| (objetosEncontradosEnConsiguiente.all({ elemento => elemento.tieneEfecto() and not elemento.esDeBarra() }))	
		}
	}
	
	/*method movimiento(siguientePosicion,consiguientePosicion, condicion, coordenadaEnCasoDeBorde ){
		const objetosEncontradosEnSiguiente = game.getObjectsIn(siguientePosicion)
		const objetosEncontradosEnConsiguiente = game.getObjectsIn(consiguientePosicion)
		if (
			(objetosEncontradosEnSiguiente.size() == 0) 
			|| (objetosEncontradosEnSiguiente.all({ elemento => not elemento.esInamobible() })) 
			and (objetosEncontradosEnConsiguiente.size() == 0) 
			|| (objetosEncontradosEnConsiguiente.all({ elemento => elemento.tieneEfecto() }))
			
			
		) {
			if (condicion) {
				position = coordenadaEnCasoDeBorde
			} else {
				position = siguientePosicion
			}
		}
	}*/

	method subir() {
		const siguientePosicion = position.up(1)
		const consiguientePosicion = position.up(2)
		const x =  siguientePosicion.x()
		const y =  siguientePosicion.y()
		if (self.puedeMover(siguientePosicion, consiguientePosicion)) {
			if (y == gameSize.height()) {
				position = game.at(x, 1)
			} else {
				position = siguientePosicion	
			}
		}
	}
	/*method subir() {
		const siguientePosicion = position.up(1)
		const y = siguientePosicion.y()
		const x = siguientePosicion.x()
		const consiguientePosicion = position.up(2)
		const condicion = y == gameSize.height()
		const posicionEnCasoDeBorde = game.at(x,1)
		self.movimiento(siguientePosicion,consiguientePosicion, condicion , posicionEnCasoDeBorde  )
	}*/
	
	method bajar() {
		const siguientePosicion = position.down(1)
		const consiguientePosicion = position.down(2)
		const x =  siguientePosicion.x()
		const y =  siguientePosicion.y()
		if (self.puedeMover(siguientePosicion, consiguientePosicion)) {
			if (y == 0) {
				position = game.at(x, gameSize.height()-1)
			} else {
				position = siguientePosicion	
			}
		}
	}
	
	method moverDerecha() {
		
		const siguientePosicion = position.right(1)
		const consiguientePosicion = position.right(2)
		const x =  siguientePosicion.x()
		const y =  siguientePosicion.y()
		if (self.puedeMover(siguientePosicion, consiguientePosicion)) {
			if (x == gameSize.width()) {
				position = game.at(0, y)
			} else {
				position = siguientePosicion	
			}
		}
	}
	
	method moverIzquierda() {
		
		const siguientePosicion = position.left(1)
		const consiguientePosicion = position.left(2)
		const x =  siguientePosicion.x()
		const y =  siguientePosicion.y()
		if (self.puedeMover(siguientePosicion, consiguientePosicion)) {
			if (x == -1) {
				position = game.at(gameSize.width()-1, y)
			} else {
				position = siguientePosicion	
			}
		}
	}
}








class ElementoInmovil inherits Elemento {
	override method esInamobible() = true
	override method tieneEfecto() = false
	override method esDeBarra() = false
}

class Objeto inherits Elemento {
	override method esInamobible() = false
	override method tieneEfecto() = true
	override method esDeBarra() = false
	method activarEfectoEn(personaje)
}

class Consumible inherits Objeto {
	var property cantidad
}

class ConsumibleDeMana inherits Consumible {	
	override method image() = "orbe-mana.png"
	
	method serConsumidoPor(personaje) {
		personaje.ganarMana(self.cantidad())
	}
	
	override method activarEfectoEn(personaje) {
		self.serConsumidoPor(personaje)
	}
}

class ConsumibleDeVida inherits Consumible {	
	override method image() = "orbe-vida.png"
	
	method serConsumidoPor(personaje) {
		personaje.ganarVida(self.cantidad())
	}
	
	override method activarEfectoEn(personaje) {
		self.serConsumidoPor(personaje)
	}
}

class Llave inherits Objeto {
	override method image() = "key.png"
	
	method serAgarradaPor(personaje) {
		personaje.guardarLlave(self)
	}
	
	override method activarEfectoEn(personaje) {
		self.serAgarradaPor(personaje)
	}
}

class Dinero inherits Objeto {
	const property valor
	
	override method image() = "coin.png"
	
	method serAgarradaPor(personaje) {
		personaje.guardarDinero(valor)
	}
	
	override method activarEfectoEn(personaje) {
		self.serAgarradaPor(personaje)
	}
}

class Muro inherits ElementoInmovil {
	override method image() = "natureWall.png"
}

class Bloque inherits ElementoMovil {
	override method image() = "market.png" 	
}



class Barra inherits ElementoInmovil {
	override method image() = "barra.png"
	
	override method esDeBarra() = true	
}





