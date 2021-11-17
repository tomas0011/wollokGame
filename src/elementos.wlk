import wollok.game.*
import nivel1.*
import configuracion.*

class Elemento {	
	var property position

	method image()	
	method esInamobible() = false
	method tieneEfecto() = false
	method esJugable() = false
	method esDeBarra() = false
}

class ElementoMovil inherits Elemento {		
	method noHay(objetos) = objetos.size() == 0
	
	method esElementoDeBarra(objetos) = objetos.any({ elemento => elemento.esDeBarra() })
	
	method noSonInamobibles(objetos) = objetos.any({ elemento => not elemento.esInamobible()})
	
	method tienenEfecto(objetos) = objetos.any({ elemento => elemento.tieneEfecto()})
	
	method puedeMover(direccion, direccionSiguiente) {
		const objetosEncontradosEnSiguiente = game.getObjectsIn(direccion)
		const objetosEncontradosEnConsiguiente = game.getObjectsIn(direccionSiguiente)
		return (
			self.noHay(objetosEncontradosEnSiguiente)
			or self.tienenEfecto(objetosEncontradosEnSiguiente)
			or (
				self.noSonInamobibles(objetosEncontradosEnSiguiente)
				and self.noHay(objetosEncontradosEnConsiguiente)
			) or self.esElementoDeBarra(objetosEncontradosEnSiguiente)
		)
	}

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
}

class Objeto inherits Elemento {
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

class Barra inherits Elemento {
	override method esDeBarra() = true	
	
	override method image() = "barra.png"
}

class Numero inherits ElementoInmovil {
	var property image = "mana (0).png"
	override method esDeBarra() = true
	
	method cambiarNumeroA_(num){
		self.image(num + ".png")
	}
}




