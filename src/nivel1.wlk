import wollok.game.*
import fondo.*
import personajes.*
import elementos.*
import nivel2.*


object nivelBloques {

	method configurate() {
		// fondo - es importante que sea el primer visual que se agregue
		game.addVisual(new Fondo(image="fondoCompleto.png"))
				 
		// otros visuals, p.ej. bloques o llaves
		game.addVisual(new Bloque(position=game.at(3,12)))
		game.addVisual(new Bloque(position=game.at(3,10)))
			
		// personaje, es importante que sea el último visual que se agregue
		game.addVisual(personajeSimple)
		
		// teclado
		// este es para probar, no es necesario dejarlo
		keyboard.t().onPressDo({ self.terminar() })
		
		keyboard.up().onPressDo({ 
			personajeSimple.subir()
			if (game.colliders(personajeSimple).size() > 0) {
				game.uniqueCollider(personajeSimple).subir()
			}
//			game.onCollideDo(personajeSimple, {a => a.subir()})
		})
		
		keyboard.down().onPressDo({ 
			personajeSimple.bajar()
			if (game.colliders(personajeSimple).size() > 0) {
				game.uniqueCollider(personajeSimple).bajar()	
			}
//			game.onCollideDo(personajeSimple, {a => a.bajar()})
		})
		
		keyboard.right().onPressDo({ 
			personajeSimple.moverDerecha()
			if (game.colliders(personajeSimple).size() > 0) {
				game.uniqueCollider(personajeSimple).moverDerecha()	
			}
//			game.onCollideDo(personajeSimple, {a => a.moverDerecha()})
		})
		
		keyboard.left().onPressDo({ 
			personajeSimple.moverIzquierda()
			if (game.colliders(personajeSimple).size() > 0) {
				game.uniqueCollider(personajeSimple).moverIzquierda()
			}
//			game.onCollideDo(personajeSimple, {a => a.moverIzquierda()})
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

