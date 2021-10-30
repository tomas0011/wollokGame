import wollok.game.*

// en la implementación real, conviene tener un personaje por nivel
// los personajes probablemente tengan un comportamiendo más complejo que solamente
// imagen y posición

object personajeSimple {
	var property position = game.at(10,8)
	const property image = "player.png"	
	
	method subir() {
		if (position.up(1).toString().split("@").get(1) != "10") {	
			position = position.up(1)
		}
	}
	
	method bajar() {
		if (position.down(1).toString().split("@").get(1) != "-1" ) {	
			position = position.down(1)
		}
	}
	
	method moverDerecha() {
		if (position.right(1).toString().split("@").get(0) != "20") {	
			position = position.right(1)
		}
	}
	
	method moverIzquierda() {
		if (position.left(1).toString().split("@").get(0) != "-1") {	
			position = position.left(1)
		}
	}
}

