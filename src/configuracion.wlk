import wollok.game.*
import nivel1.*
import elementos.*
object gameSize {
	method height() = 10
	method width() = 20
}


object niveles {
	var nivelActual = 0
	
	const nivel1 = new Nivel( mapa = mapaNivel1.matrizMapa(), xPersonaje = 3, yPersonaje = 7, puerta = "hola")
	const nivel2= new Nivel( mapa = mapaNivel2.matrizMapa(), xPersonaje = 3, yPersonaje = 7, puerta = new Puerta(position = game.at(2,12)))
	
	const niveles = [nivel1, nivel2]
	
	method nivel() = niveles.get(nivelActual)
	
	method pasarDeNivel() {
		const nuevoNivel = nivelActual + 1
		if (nuevoNivel <= (niveles.size() - 1)) {
			nivelActual = nuevoNivel
		} else {
			self.gameOver()
		}
	}
	
	method gameOver() {
		game.clear()
		game.addVisual(new Fondo(image="gameover.png"))
		game.schedule(2500, {
			game.stop()
		})
	}
}


object mapaNivel1 {
	const mapa = [
		[1,1,1,1,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1],
		[1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,1],
		[1,0,0,0,0,0,1,0,0,4,0,0,0,0,0,0,1,0,0,1],
		[1,0,0,0,0,6,1,0,0,0,0,0,0,0,0,0,1,0,0,1],
		[1,0,0,0,0,0,1,0,1,1,1,1,1,1,1,0,1,0,0,1],
		[0,0,2,0,2,0,1,0,0,0,1,0,0,9,0,0,1,0,0,0],
		[0,0,8,0,0,0,1,0,0,0,1,0,0,0,0,0,1,0,2,0],
		[0,0,0,0,0,0,0,0,0,0,1,0,9,0,0,9,0,0,0,0],
		[1,1,1,1,1,0,0,0,1,0,0,0,5,0,0,0,5,0,0,1],
		[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
	]
	
	method matrizMapa() = return mapa
}


object mapaNivel2 {
	const mapa = [
		[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,1],
		[1,0,0,0,0,0,0,0,0,1,0,6,0,0,0,0,0,0,0,1],
		[1,0,0,0,0,0,0,6,0,1,0,0,0,0,0,0,0,0,0,1],
		[1,0,0,0,0,1,0,0,0,1,1,1,0,1,0,0,0,0,0,1],
		[1,0,0,0,0,1,1,1,0,1,6,0,0,1,0,0,0,0,0,1],
		[1,0,0,0,0,1,0,0,0,1,0,1,1,1,0,0,0,6,0,1],
		[1,0,0,6,0,1,0,0,0,6,0,0,0,1,0,0,0,0,0,1],
		[0,0,0,0,0,1,0,0,0,1,0,0,0,1,10,0,0,0,0,0],
		[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0],
		[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
	]
	method matrizMapa() = mapa
}

class Fondo {
	const property position = game.at(0, 0)
	var property image 
}
