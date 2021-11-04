import wollok.game.*
import fondo.*
import personajes.*
import elementos.*
import nivel2.*

object nivel1 {
	const personajePrincipal = new PersonajePrincipal(position = game.at(3,7))
	const consumibleDeMana1 = new ConsumibleDeMana(cantidad=15, position= game.at(5,5))
	const consumibleDeVida1 = new ConsumibleDeVida(cantidad=15, position= game.at(5,6))
	
	method configurate() {
		game.addVisual(new Fondo(image="emptyMap.png"))
		game.addVisual(new Bloque(position=game.at(3,5)))
		game.addVisual(new Bloque(position=game.at(3,7)))
		game.addVisual(personajePrincipal)
		game.addVisual(consumibleDeMana1)
		game.addVisual(consumibleDeVida1)
		personajePrincipal.mostrarEstadisticas()
		
		keyboard.t().onPressDo({ self.terminar() })
		
		keyboard.up().onPressDo({ 
			personajePrincipal.subir()
			console.println("subiendo")
			if (game.colliders(personajePrincipal).size() > 0) {
				game.uniqueCollider(personajePrincipal).subir()
			}
//			game.onCollideDo(personajePrincipal, {a => a.subir()})
		})
		
		keyboard.down().onPressDo({ 
			personajePrincipal.bajar()
			console.println("bajando")
			if (game.colliders(personajePrincipal).size() > 0) {
				game.uniqueCollider(personajePrincipal).bajar()	
			}
//			game.onCollideDo(personajePrincipal, {a => a.bajar()})
		})
		
		keyboard.right().onPressDo({ 
			personajePrincipal.moverDerecha()
			console.println("a la derecha")
			if (game.colliders(personajePrincipal).size() > 0) {
				game.uniqueCollider(personajePrincipal).moverDerecha()	
			}
//			game.onCollideDo(personajePrincipal, {a => a.moverDerecha()})
		})
		
		keyboard.left().onPressDo({ 
			personajePrincipal.moverIzquierda()
			console.println("a la izquierda")
			if (game.colliders(personajePrincipal).size() > 0) {
				game.uniqueCollider(personajePrincipal).moverIzquierda()
			}
//			game.onCollideDo(personajePrincipal, {a => a.moverIzquierda()})
		})
	}
	
	method terminar() {
		game.clear()
		game.addVisual(new Fondo(image="fondoCompleto.png"))
		game.addVisual(personajePrincipal)
		game.schedule(2500, {
			game.clear()
			game.addVisual(new Fondo(image="finNivel1.png"))
			game.schedule(3000, {
				game.clear()
//				nivel2.configurate()
			})
		})
	}
		
}



