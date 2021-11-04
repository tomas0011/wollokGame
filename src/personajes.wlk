import wollok.game.*
import nivel1.*

// en la implementación real, conviene tener un personaje por nivel
// los personajes probablemente tengan un comportamiendo más complejo que solamente
// imagen y posición

object personajeSimple {
	var property position = game.at(10,8)
	const property image = "player.png"	
	
	method subir() {		
		if( colisiones.esMuro(position.up(1))){	
			position = position.up(1)
		}
	}
	
	method bajar() {
		if( colisiones.esMuro(position.down(1)) ){	
			position = position.down(1)
		}
	}
	
	method moverDerecha() {
		if( colisiones.esMuro(position.right(1)) ){	
			position = position.right(1)
		}
	}
	
	method moverIzquierda() {
		if( colisiones.esMuro(position.left(1)) ){	
			position = position.left(1)
		}
	}
	
	
	
	
	
	
}

