import wollok.game.*

object gameSize {
	method height() = 10
	method width() = 20
}

class Fondo {
	const property position = game.at(0, 0)
	var property image 
}
