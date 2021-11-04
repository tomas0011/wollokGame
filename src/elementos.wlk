import wollok.game.*
import nivel1.*
import configuracion.*

class Elemento {	
	var property position

	method image()	
	method esInamobible()
	method tieneEfecto()
}

class ElementoMovil inherits Elemento {
	
	override method esInamobible() = false
	override method tieneEfecto() = false
	
	
	method efectoPacman(siguientePosicion,consiguientePosicion, condicion, coordenadaEnCasoDeBorde ){
		const objetosEncontrados = game.getObjectsIn(siguientePosicion)
		const x = siguientePosicion.x()
		const y = siguientePosicion.y()
		
		if (objetosEncontrados.size() == 0 ||(objetosEncontrados.all({ elemento => not elemento.esInamobible() }) and game.getObjectsIn(consiguientePosicion).size() == 0) ) {
			if (condicion) {
				position = coordenadaEnCasoDeBorde
			} else {
				position = siguientePosicion
			}
		}
	}
	
	method subir() {
		/*const siguientePosicion = position.up(1)
		const y = siguientePosicion.y()
		const x = siguientePosicion.x()
		const consiguientePosicion = position.up(2)
		const condicion = y == 10
		const posicionEnCasoDeBorde = game.at(x,1)
		self.efectoPacman(siguientePosicion,consiguientePosicion, condicion , posicionEnCasoDeBorde  )
		*/
		
		
		const siguientePosicion = position.up(1)
		const consiguientePosicion = position.up(2)
		const objetosEncontradosEnSiguiente = game.getObjectsIn(siguientePosicion)
		const objetosEncontradosEnConsiguiente = game.getObjectsIn(consiguientePosicion)
		const x =  siguientePosicion.x()
		const y =  siguientePosicion.y()
		if (
			(objetosEncontradosEnSiguiente.size() == 0) 
			|| (objetosEncontradosEnSiguiente.all({ elemento => not elemento.esInamobible() })) 
			and (objetosEncontradosEnConsiguiente.size() == 0) 
			|| (objetosEncontradosEnConsiguiente.all({ elemento => elemento.tieneEfecto() }))
		) {
			if (y == gameSize.height()) {
				position = game.at(x, 1)
			} else {
				position = siguientePosicion	
			}
		}
	}
	
	method bajar() {
		const siguientePosicion = position.down(1)
		const consiguientePosicion = position.down(2)
		const objetosEncontradosEnSiguiente = game.getObjectsIn(siguientePosicion)
		const objetosEncontradosEnConsiguiente = game.getObjectsIn(consiguientePosicion)
		const x =  siguientePosicion.x()
		const y =  siguientePosicion.y()
		
		if (
			(objetosEncontradosEnSiguiente.size() == 0) 
			|| (objetosEncontradosEnSiguiente.all({ elemento => not elemento.esInamobible() })) 
			and (objetosEncontradosEnConsiguiente.size() == 0) 
			|| (objetosEncontradosEnConsiguiente.all({ elemento => elemento.tieneEfecto() }))
		) {
			if (y == 0) {
				position = game.at(x, gameSize.height() - 1)
			} else {
				position = siguientePosicion	
			}
		}
	}
	
	method moverDerecha() {
		const siguientePosicion = position.right(1)
		const consiguientePosicion = position.right(2)
		const objetosEncontradosEnSiguiente = game.getObjectsIn(siguientePosicion)
		const objetosEncontradosEnConsiguiente = game.getObjectsIn(consiguientePosicion)
		const x =  siguientePosicion.x()
		const y =  siguientePosicion.y()
		
		if (
			(objetosEncontradosEnSiguiente.size() == 0) 
			|| (objetosEncontradosEnSiguiente.all({ elemento => not elemento.esInamobible() })) 
			and (objetosEncontradosEnConsiguiente.size() == 0) 
			|| (objetosEncontradosEnConsiguiente.all({ elemento => elemento.tieneEfecto() }))
		) {
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
		const objetosEncontradosEnSiguiente = game.getObjectsIn(siguientePosicion)
		const objetosEncontradosEnConsiguiente = game.getObjectsIn(consiguientePosicion)
		const x =  siguientePosicion.x()
		const y =  siguientePosicion.y()
		
		if (
			(objetosEncontradosEnSiguiente.size() == 0) 
			|| (objetosEncontradosEnSiguiente.all({ elemento => not elemento.esInamobible() })) 
			and (objetosEncontradosEnConsiguiente.size() == 0) 
			|| (objetosEncontradosEnConsiguiente.all({ elemento => elemento.tieneEfecto() }))
		) {
			if (x == -1) {
				position = game.at(gameSize.width() - 1, y)
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

class Objeto inherits Elemento {
	override method esInamobible() = false
	override method tieneEfecto() = true
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





