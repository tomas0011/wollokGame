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
	method esDeposito() = false
}

class ElementoMovil inherits Elemento {		
	method noHay(objetos) = objetos.size() == 0
	
	method esElementoDeBarra(objetos) = objetos.any({ elemento => elemento.esDeBarra() })
	
	method noSonInamobibles(objetos) = objetos.any({ elemento => not elemento.esInamobible()})
	
	method tienenEfecto(objetos) = objetos.any({ elemento => elemento.tieneEfecto()})
	
	method hayDepositos(objetos) = objetos.any({ elemento => elemento.esDeposito() })
	
	method puedeMover(direccion, direccionSiguiente) {
		const objetosEncontradosEnSiguiente = game.getObjectsIn(direccion)
		const objetosEncontradosEnConsiguiente = game.getObjectsIn(direccionSiguiente)
		return (
			self.noHay(objetosEncontradosEnSiguiente)
			or self.hayDepositos(objetosEncontradosEnSiguiente)
			or self.tienenEfecto(objetosEncontradosEnSiguiente)
			or (
				self.noSonInamobibles(objetosEncontradosEnSiguiente)
				and (
					self.noHay(objetosEncontradosEnConsiguiente)
					or self.hayDepositos(objetosEncontradosEnConsiguiente)
				)
			) or self.esElementoDeBarra(objetosEncontradosEnSiguiente)
			or (
				self.noSonInamobibles(objetosEncontradosEnSiguiente)
				and
				self.esElementoDeBarra(objetosEncontradosEnConsiguiente)
			)
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

class Deposito inherits Elemento {
	var property carga = 0
	
	var property imagen = "deposito.png"
	
	method cargaMaxima() = 3
	
	method cerrar() {
		self.imagen("depositoCerrado.png")
	}
	
	override method image() = imagen
	
	override method esDeposito() = true
}

class Muro inherits ElementoInmovil {
	override method image() = "natureWall.png"
}

class Bloque inherits ElementoMovil {
	override method image() = "market.png" 	
	
	override method subir() {
		super()
		if (game.colliders(self).size() > 0) {
			game.colliders(self).forEach({ collider => 
				if (collider.esDeposito()) {
					if (collider.carga() < collider.cargaMaxima()) {
						collider.carga(collider.carga() + 1)
						if (collider.carga() >= collider.cargaMaxima()) {
							collider.cerrar()
						}
					}
					game.removeVisual(self)	
				}
			})
		}
	}
	
	override method bajar() {
		super()
		if (game.colliders(self).size() > 0) {
			game.colliders(self).forEach({ collider => 
				if (collider.esDeposito()) {
					if (collider.carga() < collider.cargaMaxima()) {
						collider.carga(collider.carga() + 1)
						if (collider.carga() >= collider.cargaMaxima()) {
							collider.cerrar()
						}
					}
					game.removeVisual(self)	
				}
			})
		}
	}
	
	override method moverDerecha() {
		super()
		if (game.colliders(self).size() > 0) {
			game.colliders(self).forEach({ collider => 
				if (collider.esDeposito()) {
					if (collider.carga() < collider.cargaMaxima()) {
						collider.carga(collider.carga() + 1)
						if (collider.carga() >= collider.cargaMaxima()) {
							collider.cerrar()
						}
					}
					game.removeVisual(self)	
				}
			})
		}
	}
	
	override method moverIzquierda() {
		super()
		if (game.colliders(self).size() > 0) {
			game.colliders(self).forEach({ collider => 
				if (collider.esDeposito()) {
					if (collider.carga() < collider.cargaMaxima()) {
						collider.carga(collider.carga() + 1)
						if (collider.carga() >= collider.cargaMaxima()) {
							collider.cerrar()
						}
					}
					game.removeVisual(self)	
				}
			})
		}
	}
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




class CeldaTrampa inherits Objeto {
	override method image() = "celda-sorpresa.png"
}

class CeldaTrampa_Mana inherits CeldaTrampa {
	override method activarEfectoEn(personaje){
		personaje.perderMana(10)
	}
}
class CeldaTrampa_Vida inherits CeldaTrampa {
	override method activarEfectoEn(personaje){
		personaje.perderVida(10)
	}
}

class CeldaTrampa_Teletransporte inherits CeldaTrampa {
	override method activarEfectoEn(personaje){
		const numeroRandom = 0.randomUpTo(niveles.nivel().posicionesParaAgregar().size()).truncate(0)
		const posicionElegida = niveles.nivel().posicionesParaAgregar().get(numeroRandom)
		const x = posicionElegida .get(0)
		const y = posicionElegida .get(1)
		niveles.nivel().posicionesParaAgregar().remove(posicionElegida)
		personaje.position(game.at(x,y))
	}
}



