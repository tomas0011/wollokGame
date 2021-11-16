import wollok.game.*
import configuracion.*
import personajes.*
import elementos.*
import nivel2.*

object nivel1 {
	const personajePrincipal = new PersonajePrincipal(position = game.at(3,7), vida = 50)
	
	const elementosDelMapa = [
		new ConsumibleDeMana(cantidad=15, position= game.at(5,5)),
		new ConsumibleDeVida(cantidad=15, position= game.at(5,6)),
		new Dinero(position=game.at(5,7), valor=10),
		new Llave(position=game.at(5,8)),
		new Llave(position=game.at(5,9)),
		new Bloque(position=game.at(3,5)),
		new Bloque(position=game.at(3,7)),
		new Muro(position=game.at(6,6)),
		new Muro(position=game.at(2,1))
	]
	
	const enemigosDelMapa = [
		new Arana(position=game.at(6,8), vida = 1),
		new Arana(position=game.at(6,6), vida = 1),
		new Arana(position=game.at(6,4), vida = 1),
		new Arana(position=game.at(6,2), vida = 1)
	]
	
	method configurate() {
		game.addVisual(new Fondo(image="emptyMap.png"))
		
		
		(gameSize.width() + 1).times( { i =>  game.addVisual( new Barra(position=game.at(i - 1, 0)) ) } )
		
		
		elementosDelMapa.forEach({ elemento => game.addVisual(elemento) })
		enemigosDelMapa.forEach({ enemigo => game.addVisual(enemigo) })
		
		game.addVisual(personajePrincipal)
		personajePrincipal.mostrarEstadisticas()
		
		// game.onTick(1000, 'movimientoDeEnemigos', { enemigosDelMapa.forEach({ enemigo => enemigo.hacerMovimientoRandom() }) })
		
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



