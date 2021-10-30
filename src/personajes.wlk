import wollok.game.*

// en la implementación real, conviene tener un personaje por nivel
// los personajes probablemente tengan un comportamiendo más complejo que solamente
// imagen y posición

object personajeSimple {
	var property position = game.at(10,8)
	const property image = "player.png"	
	
	method subir() {
		if (not self.position().toString().split("@").get(1) == "0") {
			self.position(position.up(1))	
		}
	}
	
	method bajar() {
		if(not self.position() == 0) {
			self.position(position.down(1))	
		}
	}
	
	method moverDerecha() {
		self.position(position.right(1))
	}
	
	method moverIzquierda() {
		self.position(position.left(1))
	}
	
}

