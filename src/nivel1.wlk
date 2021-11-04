import wollok.game.*
import configuracion.*
import personajes.*
import elementos.*
import nivel2.*

object nivel1 {
	const personajePrincipal = new PersonajePrincipal(position = game.at(3,7))
	
	const elementosDelMapa = [
		new ConsumibleDeMana(cantidad=15, position= game.at(5,5)),
		new ConsumibleDeVida(cantidad=15, position= game.at(5,6)),
		new Dinero(position=game.at(5,7), valor=10),
		new Llave(position=game.at(5,8)),
		new Llave(position=game.at(5,9)),
		new Bloque(position=game.at(3,5)),
		new Bloque(position=game.at(3,7)),
		new Muro(position=game.at(6,6))
	]
	
	method configurate() {
		game.addVisual(new Fondo(image="emptyMap.png"))
		
		elementosDelMapa.forEach({ elemento => game.addVisual(elemento) })
		
		game.addVisual(personajePrincipal)
		personajePrincipal.mostrarEstadisticas()
		
		keyboard.t().onPressDo({ self.terminar() })
		
		keyboard.up().onPressDo({ 
			personajePrincipal.subir()
			if (game.colliders(personajePrincipal).size() > 0) {
				const collider = game.uniqueCollider(personajePrincipal)
				if (not collider.esInamobible()) {
					if (not collider.tieneEfecto()) {
						collider.subir()
					} else {
						collider.activarEfectoEn(personajePrincipal)
						game.removeVisual(collider)
					}
				}
			}
//			game.onCollideDo(personajePrincipal, {a => a.subir()})
		})
		
		keyboard.down().onPressDo({ 			
			personajePrincipal.bajar()
			console.println("bajando")
			if (game.colliders(personajePrincipal).size() > 0) {
				const collider = game.uniqueCollider(personajePrincipal)
				if (not collider.esInamobible()) {
					if (not collider.tieneEfecto()) {
						collider.bajar()
					} else {
						collider.activarEfectoEn(personajePrincipal)
						game.removeVisual(collider)		
					}
				}
			}
//			game.onCollideDo(personajePrincipal, {a => a.bajar()})
		})
		
		keyboard.right().onPressDo({ 

			personajePrincipal.moverDerecha()
			console.println("a la derecha")
			if (game.colliders(personajePrincipal).size() > 0) {
				const collider = game.uniqueCollider(personajePrincipal)
				if (not collider.esInamobible()) {
					if (not collider.tieneEfecto()) {
						collider.moverDerecha()
					} else {
						collider.activarEfectoEn(personajePrincipal)
						game.removeVisual(collider)		
					}
				}
			}
//			game.onCollideDo(personajePrincipal, {a => a.moverDerecha()})
		})
		
		keyboard.left().onPressDo({ 

			personajePrincipal.moverIzquierda()
			console.println("a la izquierda")
			if (game.colliders(personajePrincipal).size() > 0) {
				const collider = game.uniqueCollider(personajePrincipal)
				if (not collider.esInamobible()) {
					if (not collider.tieneEfecto()) {
						collider.moverIzquierda()
					} else {
						collider.activarEfectoEn(personajePrincipal)
						game.removeVisual(collider)		
					}
				}
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



