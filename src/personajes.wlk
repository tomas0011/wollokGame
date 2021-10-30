import wollok.game.*
import nivel1.*
// en la implementación real, conviene tener un personaje por nivel
// los personajes probablemente tengan un comportamiendo más complejo que solamente
// imagen y posición

object personajeSimple {
	var property position = game.at(10,8)
	const property image = "player.png"	
	
	method subir() {
		if( self.esMuro(position.up(1))){	
			position = position.up(1)
		}
	}
	
	method bajar() {
		if( self.esMuro(position.down(1)) ){	
			position = position.down(1)
		}
	}
	
	method moverDerecha() {
		if( self.esMuro(position.right(1)) ){	
			position = position.right(1)
		}
	}
	
	method moverIzquierda() {
		if( self.esMuro(position.left(1)) ){	
			position = position.left(1)
		}
	}
	
	
	
	
	method esMuro(coord){
		
		const x = coord.x()
		const y = (coord.y() - 9 ).abs()
		// Le resto 9 porque el sistema de coordenadas funciona al revez que en JS
		
		return not (nivelBloques.getMapa().get(y).get(x) == 1)
	}
	
}

