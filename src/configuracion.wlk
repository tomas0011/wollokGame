import wollok.game.*
import nivel1.*
object gameSize {
	method height() = 10
	method width() = 20
}


object niveles{
	var nivelActual = 0
	
	const nivel1 = new Nivel( mapa = mapaNivel1.matrizMapa(), xPersonaje = 3, yPersonaje = 7)
	const nivel2= new Nivel( mapa = mapaNivel2.matrizMapa(), xPersonaje = 3, yPersonaje = 7)
	
	const niveles = [nivel1,nivel2]
	
	method nivel() = niveles.get(nivelActual)
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


object mapaNivel2{
	const mapa = [
		[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,1],
		[1,0,0,0,0,0,0,0,0,1,0,6,0,0,0,0,0,0,0,1],
		[1,0,0,0,0,0,0,6,0,1,0,0,0,0,0,0,0,0,0,1],
		[1,0,0,0,0,1,0,0,0,1,1,1,0,1,0,0,0,0,0,1],
		[1,0,0,0,0,1,1,1,0,1,6,0,0,1,0,0,0,0,0,1],
		[1,0,0,0,0,1,0,0,0,1,0,1,1,1,0,0,0,6,0,1],
		[1,0,0,6,0,1,0,0,0,6,0,0,0,1,0,0,0,0,0,1],
		[0,0,0,0,0,1,0,0,0,1,0,0,2,1,0,0,0,0,0,0],
		[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0],
		[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
	]
	method matrizMapa() = mapa
}

class Fondo {
	const property position = game.at(0, 0)
	var property image 
}
