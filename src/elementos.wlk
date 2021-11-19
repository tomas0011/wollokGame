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
	method esAcumulador() = false
}

class ElementoMovil inherits Elemento {		
	method noHay(objetos) = objetos.size() == 0
	
	method esElementoDeBarra(objetos) = objetos.any({ elemento => elemento.esDeBarra() })
	
	method noSonInamobibles(objetos) = objetos.any({ elemento => not elemento.esInamobible()})
	
	method tienenEfecto(objetos) = objetos.any({ elemento => elemento.tieneEfecto()})
	
	method hayAcumuladores(objetos) = objetos.any({ elemento => elemento.esAcumulador() })
	
	method puedeMover(direccion, direccionSiguiente) {
		const objetosEncontradosEnSiguiente = game.getObjectsIn(direccion)
		const objetosEncontradosEnConsiguiente = game.getObjectsIn(direccionSiguiente)
		return (
			self.noHay(objetosEncontradosEnSiguiente)
			or self.hayAcumuladores(objetosEncontradosEnSiguiente)
			or self.tienenEfecto(objetosEncontradosEnSiguiente)
			or (
				self.noSonInamobibles(objetosEncontradosEnSiguiente)
				and (
					self.noHay(objetosEncontradosEnConsiguiente)
					or self.hayAcumuladores(objetosEncontradosEnConsiguiente)
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
		personaje.perderVida(10)
		self.serAgarradaPor(personaje)
	}
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
				if (collider.esAcumulador()) {
					if (collider.faltantes() >= 1) {
						collider.acumular(1)
					}
					if (collider.faltantes() == 0) {
						collider.cerrar()
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
				if (collider.esAcumulador()) {
					if (collider.faltantes() >= 1) {
						collider.acumular(1)
					}
					if (collider.faltantes() == 0) {
						collider.cerrar()
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
				if (collider.esAcumulador()) {
					if (collider.faltantes() >= 1) {
						collider.acumular(1)
					}
					if (collider.faltantes() == 0) {
						collider.cerrar()
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
				if (collider.esAcumulador()) {
					if (collider.faltantes() >= 1) {
						collider.acumular(1)
					}
					if (collider.faltantes() == 0) {
						collider.cerrar()
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

class ElementoAcumulador inherits Elemento {
	override method esAcumulador() = true
	
	method faltantes()
	
	method unidad()
	
	method agregarDe(personaje)
	
	method acumular(cantidad)
}

class Deposito inherits ElementoAcumulador {
	var property carga = 0
	
	var property imagen = "deposito.png"
	
	method cargaMaxima() = 3
	
	override method faltantes() = self.cargaMaxima() - self.carga()
	
	override method unidad() = if (self.faltantes() < 1) { "caja" } else { "cajas" } 
	
	override method agregarDe(personaje) {}
	
	override method acumular(cantidad) {
		self.carga(self.carga() + cantidad)
	}
	
	method cerrar() {
		self.imagen("depositoCerrado.png")
	}
	
	override method image() = imagen
}

class Puerta inherits ElementoAcumulador {
	var property image = "PuertaCerrada.png"
	
	var property cerradurasAbiertas = 0
	
	method cantidadDeCerraduras() = 5
	
	override method faltantes() = self.cantidadDeCerraduras() - self.cerradurasAbiertas()
	
	override method unidad() = if (self.cantidadDeCerraduras() - cerradurasAbiertas < 1) { "llave" } else { "llaves" } 
	
	override method agregarDe(personaje){
		const llavesAUsar = if (personaje.llaves().size() > self.faltantes()) { self.faltantes() } else { personaje.llaves().size() }
		self.agregarLlaves(llavesAUsar)
		personaje.quitarLlaves(llavesAUsar)
	}
	
	override method acumular(cantidad) {}
	
	method agregarLlaves(llaves){
		self.cerradurasAbiertas(cerradurasAbiertas + llaves )
		if ( self.faltantes() == 0 ){
			self.abrirPuerta()
		} 
	}	
	
	method abrirPuerta() {
		self.image("puertaAbierta.png")
	}
}











