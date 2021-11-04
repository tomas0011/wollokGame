import wollok.game.*
import fondo.*
import personajes.*
import elementos.*
import nivel2.*


object colisiones{
	method esMuro(coord){
		
		const x = coord.x()
		const y = (coord.y() - 9 ).abs()
		// Le resto 9 porque el sistema de coordenadas funciona al revez que en JS
		
		return not (nivelBloques.getMapa().get(y).get(x) == 1)
	}
	
	
}




object nivelBloques {
	
	const mapa = [
	     [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
		 [1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1],
		 [1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1],
		 [1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1],
		 [1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1],
		 [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
		 [1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1],
		 [1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1],
		 [1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1],
	 	 [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]		
	]
  
		
	method getMapa() = return mapa
	method configurate() {
		// fondo - es importante que sea el primer visual que se agregue
		game.addVisual(new Fondo(image="mapa.png"))
				 
		// otros visuals, p.ej. bloques o llaves
		game.addVisual(new Bloque(position=game.at(3,5)))
		game.addVisual(new Bloque(position=game.at(3,7)))
			
		// personaje, es importante que sea el último visual que se agregue
		game.addVisual(personajeSimple)
		
		// teclado
		// este es para probar, no es necesario dejarlo
		keyboard.t().onPressDo({ self.terminar() })
		
		keyboard.up().onPressDo({ 
			personajeSimple.subir()
			const collider = game.colliders(personajeSimple)
			
			if (collider.size()>0 and collider.tipo() == "obstaculo"){
				//collider.subir()
				console.println(collider)
				console.println(collider.tipo())
				
			} else if (collider.size()>0){
				console.println("Tu vieja")
			}
			
		})
		
		
		
		keyboard.right().onPressDo({ 
			personajeSimple.moverDerecha()
			const collider = game.colliders(personajeSimple)
			
			if (collider.tipo() == "obstaculo"){
				collider.moverDerecha()
			} else {
				console.println("Tu vieja")
			}
		})
		
		keyboard.left().onPressDo({ 
			personajeSimple.moverIzquierda()
			/*game.whenCollideDo(personajeSimple, {
				e =>
				if (e.tipo() == "obstaculo"){
					console.println("izquierda")
					e.moverIzquierda()
				} else {
					return "Tu vieja"
				}
			})*/
			const collider = game.colliders(personajeSimple)
			
			if (collider.tipo() == "obstaculo"){
				collider.moverIzquierda()
			} else {
				console.println("Tu vieja")
			}
		})
		
		keyboard.down().onPressDo({ 
			personajeSimple.bajar()
			const collider = game.colliders(personajeSimple)
			
			if (collider.tipo() == "obstaculo"){
				collider.bajar()
			} else {
				console.println("Tu vieja")
			}
			
		})
	}
	method terminar() {
		// game.clear() limpia visuals, teclado, colisiones y acciones
		game.clear()
		// después puedo volver a agregar el fondo, y algún visual para que no quede tan pelado
		game.addVisual(new Fondo(image="fondoCompleto.png"))
		game.addVisual(personajeSimple)
		// después de un ratito ...
		game.schedule(2500, {
			game.clear()
			// cambio de fondo
			game.addVisual(new Fondo(image="finNivel1.png"))
			// después de un ratito ...
			game.schedule(3000, {
				// ... limpio todo de nuevo
				game.clear()
				// y arranco el siguiente nivel
				nivelLlaves.configurate()
			})
		})
	}
		
}

