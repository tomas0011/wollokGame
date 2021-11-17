import wollok.game.*
import configuracion.*
import personajes.*
import elementos.*
import nivel2.*



class Nivel{
	var property xPersonaje
	var property yPersonaje
	
	var property mapa
	const personajePrincipal = new PersonajePrincipal(position = game.at(xPersonaje,yPersonaje), vida = 50)




	const elementos = [
		{x,y => "Elemento de descarte"},
		{x,y => new Muro(position = game.at(x,y))},
		{x,y => new Bloque(position = game.at(x,y))},
		{x,y => new Dinero(position = game.at(x,y), valor = 10)},
		{x,y => new ConsumibleDeVida(position = game.at(x,y), cantidad= 10)},
		{x,y => new ConsumibleDeMana(position = game.at(x,y), cantidad = 10)},
		{x,y => new Llave(position = game.at(x,y))},
		{x,y => new Arana(position = game.at(x,y), vida = 1)}
	]
	
	method configurate() {
		
		game.addVisual(new Fondo(image="emptyMap.png"))
		(gameSize.width() + 1).times( { i =>  game.addVisual( new Barra(position=game.at(i - 1, 0)) ) } )
		self.generarMapa()
		
		game.addVisual(personajePrincipal)
		personajePrincipal.mostrarEstadisticas()
		
		game.onTick(1000, 'movimientoDeEnemigos', { enemigosDelMapa.forEach({ enemigo =>
			const distancia = enemigo.position().distance(personajePrincipal.position())
			if (distancia < 3) {
				enemigo.moverHacia(personajePrincipal)				
			} else {
				enemigo.hacerMovimientoRandom()	
			}
		})})
		
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
	
	
	method generarMapa(){
		var x = 0
		var y = 0
		mapa.forEach( { fila => 
			x = 0
			y = y+1
			fila.forEach( { columna => 
				const valorEnMapa = mapa.get((y-9).abs()).get(x)
				elementos.get(valorEnMapa).apply(x,y)
				if (valorEnMapa > 0){
					game.addVisual( elementos.get(valorEnMapa).apply(x,y) )
				}
				
				x = x+1
			} )
		} )
	}
	
	
	
	method terminar() {
		
		//game.clear()
		game.addVisual(new Fondo(image="gameover.png"))
		/*game.addVisual(personajePrincipal)
		game.schedule(2500, {
			game.clear()
			game.addVisual(new Fondo(image="finNivel1.png"))
			game.schedule(3000, {
				game.clear()
//				nivel2.configurate()
			})
		})¨*/
	}
		
}
























/*


object nivel1 {
	const personajePrincipal = new PersonajePrincipal(position = game.at(3,7), vida = 50)

	const elementos = [
		{x,y => "Elemento de descarte"},
		{x,y => new Muro(position = game.at(x,y))},
		{x,y => new Bloque(position = game.at(x,y))},
		{x,y => new Dinero(position = game.at(x,y), valor = 10)},
		{x,y => new ConsumibleDeVida(position = game.at(x,y), cantidad= 10)},
		{x,y => new ConsumibleDeMana(position = game.at(x,y), cantidad = 10)},
		{x,y => new Llave(position = game.at(x,y))},
		{x,y => new Arana(position = game.at(x,y), vida = 1)}
	]
		/*
	 *  0: nada
	 *  1: muro
	 *  2: caja
	 *  3: moneda
	 * 	4: vida
	 *  5: mana
	 *  6: llave
	 *  7: araña
	 *  8: personaje
	 * 
	 */
	
	
	
	
	const elementosDelMapa = [
		new Muro(position=game.at(0,1)),
		new Muro(position=game.at(1,1)),
		new Muro(position=game.at(2,1)),
		new Muro(position=game.at(3,1)),
		new Muro(position=game.at(4,1)),
		
		new Muro(position=game.at(0,9)),
		new Muro(position=game.at(1,9)),
		new Muro(position=game.at(2,9)),
		new Muro(position=game.at(3,9)),
		new Muro(position=game.at(4,9)),
		
		new Muro(position=game.at(0,9)),
		new Muro(position=game.at(0,8)),
		new Muro(position=game.at(0,7)),
		new Muro(position=game.at(0,6)),
		new Muro(position=game.at(0,5)),
		
		new Muro(position=game.at(19,9)),
		new Muro(position=game.at(19,8)),
		new Muro(position=game.at(19,7)),
		new Muro(position=game.at(19,6)),
		new Muro(position=game.at(19,5)),
		
		
		new Muro(position=game.at(6,7)),
		new Muro(position=game.at(6,6)),
		new Muro(position=game.at(6,5)),
		new Muro(position=game.at(6,4)),
		new Muro(position=game.at(6,3)),
		
		new Muro(position=game.at(16,7)),
		new Muro(position=game.at(16,6)),
		new Muro(position=game.at(16,5)),
		new Muro(position=game.at(16,4)),
		new Muro(position=game.at(16,3)),
		
		new Muro(position=game.at(8,5)),
		new Muro(position=game.at(9,5)),
		new Muro(position=game.at(10,5)),
		new Muro(position=game.at(11,5)),
		new Muro(position=game.at(12,5)),
		new Muro(position=game.at(13,5)),
		new Muro(position=game.at(14,5)),
		
		
		new Muro(position = game.at(7,1)),
		new Muro(position = game.at(7,9)),
		
		new Muro(position=game.at(10,4)),
		new Muro(position=game.at(10,3)),
		new Muro(position=game.at(10,2)),
		
		new Dinero(position =game.at(8,6) , valor= 10),
		new Dinero(position =game.at(9,6) , valor= 10),
		new Dinero(position =game.at(10,6) , valor= 10),
		new Dinero(position =game.at(11,6) , valor= 10),
		new Dinero(position =game.at(12,6) , valor= 10),
		new Dinero(position =game.at(13,6) , valor= 10),
		new Dinero(position =game.at(14,6) , valor= 10),
		
		
		new Llave(position = game.at(5,7)),
		
		
		new Bloque(position = game.at(18,3)),
		
		new ConsumibleDeVida(position=  game.at(9,7), cantidad=30),
		
		new ConsumibleDeMana(position=  game.at(16,1), cantidad=30),
		new ConsumibleDeMana(position=  game.at(12,1), cantidad=30)
	]
	
	const enemigosDelMapa = [
		new Arana(position=game.at(6,6), vida = 1),
		new Arana(position=game.at(6,8), vida = 1)

	]
	
	method configurate() {
		
		game.addVisual(new Fondo(image="emptyMap.png"))
		(gameSize.width() + 1).times( { i =>  game.addVisual( new Barra(position=game.at(i - 1, 0)) ) } )
		self.generarMapa(mapaNivel1.matrizMapa())
		
		game.addVisual(personajePrincipal)
		personajePrincipal.mostrarEstadisticas()
		
		game.onTick(1000, 'movimientoDeEnemigos', { enemigosDelMapa.forEach({ enemigo =>
			const distancia = enemigo.position().distance(personajePrincipal.position())
			if (distancia < 3) {
				enemigo.moverHacia(personajePrincipal)				
			} else {
				enemigo.hacerMovimientoRandom()	
			}
		})})
		
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
	
	
	method generarMapa(mapa){
		var x = 0
		var y = 0
		mapa.forEach( { fila => 
			x = 0
			y = y+1
			fila.forEach( { columna => 
				const valorEnMapa = mapa.get((y-9).abs()).get(x)
				elementos.get(valorEnMapa).apply(x,y)
				if (valorEnMapa > 0){
					game.addVisual( elementos.get(valorEnMapa).apply(x,y) )
				}
				
				x = x+1
			} )
		} )
	}
	
	
	
	method terminar() {
		
		//game.clear()
		game.addVisual(new Fondo(image="gameover.png"))
		/*game.addVisual(personajePrincipal)
		game.schedule(2500, {
			game.clear()
			game.addVisual(new Fondo(image="finNivel1.png"))
			game.schedule(3000, {
				game.clear()
//				nivel2.configurate()
			})
		})¨*/
	}
		
}


*/
