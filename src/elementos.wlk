import wollok.game.*

class Bloque {
	var property position
	const property image = "market.png" 	
	
	method subir() {
		self.position(position.up(1))
	}
	
	method bajar() {
		self.position(position.down(1))
	}
	
	method moverDerecha() {
		self.position(position.right(1))
	}
	
	method moverIzquierda() {
		self.position(position.left(1))
	}
	
	method queHayALaDerecha() {
		return 'asdasdasda'
	}
	
	method queHayALaIzquierda() {
		return 'asdasdasda'
	}
}

