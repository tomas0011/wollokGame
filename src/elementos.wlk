import wollok.game.*

class Bloque {
	var property position
	const property image = "market.png" 	
	method tipo() = return "obstaculo"
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





class Consumible{
	var property tipo
	var property cantidad
	var property position
	var property image
	
}