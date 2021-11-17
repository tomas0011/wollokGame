import wollok.game.*
import nivel1.*
object gameSize {
	method height() = 10
	method width() = 20
}


object niveles{
	var nivelActual = 1
	
	method nivel1() = new Nivel( mapa = mapaNivel1.matrizMapa(), xPersonaje = 3, yPersonaje = 7)
	method nivel2() = new Nivel( mapa = mapaNivel1.matrizMapa(), xPersonaje = 3, yPersonaje = 7)
	
	method nivel() = return if (nivelActual == 1){ self.nivel1() } else { self.nivel2() }
}


object mapaNivel1{
	const mapa = [
		[1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
		[1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,1],
		[1,0,0,0,0,0,1,0,0,4,0,0,0,0,0,0,1,0,0,1],
		[1,0,0,0,0,6,1,0,3,3,3,3,3,3,3,0,1,0,0,1],
		[1,0,0,0,0,0,1,0,1,1,1,1,1,1,1,0,1,0,0,1],
		[0,0,2,0,2,0,1,0,0,0,1,0,0,8,0,0,1,0,0,0],
		[0,0,8,0,0,0,1,0,0,0,1,0,0,0,0,0,1,0,2,0],
		[0,0,0,0,0,0,0,0,0,0,1,0,8,0,0,8,0,0,0,0],
		[1,1,1,1,1,0,0,1,0,0,0,0,5,0,0,0,5,0,0,1],
		[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
	]
	
	method matrizMapa() = return mapa
}

class Fondo {
	const property position = game.at(0, 0)
	var property image 
}
