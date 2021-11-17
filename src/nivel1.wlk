import wollok.game.*
import configuracion.*
import personajes.*
import elementos.*
import nivel2.*

object nivel1 {
	var property losEnemigosDescansan = false
	const personajePrincipal = new PersonajePrincipal(position = game.at(3,7), vida = 50)
		
	const mapa = [
		[1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
		[1,0,0,0,0,6,1,0,0,0,0,0,0,0,0,0,0,0,0,1],
		[1,0,0,0,0,0,1,0,0,4,0,0,0,0,0,0,1,0,2,1],
		[1,0,0,0,0,0,1,0,3,3,3,3,3,3,3,0,1,0,0,1],
		[1,0,0,0,0,0,1,0,1,1,1,1,1,1,1,0,1,0,0,1],
		[0,0,2,0,0,0,1,0,0,0,1,0,0,0,0,0,1,0,0,0],
		[0,0,8,0,0,0,1,0,0,0,1,0,0,0,0,0,1,0,2,0],
		[0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0],
		[1,1,1,1,1,0,0,1,0,0,0,0,5,0,0,0,5,0,0,1],
		[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
	]
	
	
	const elementos = [
		{x,y => "Elemento de descarte"},
		{x,y => new Muro(position = game.at(x,y))},
		{x,y => new Bloque(position = game.at(x,y))},
		{x,y => new Dinero(position = game.at(x,y), valor = 10)},
		{x,y => new ConsumibleDeVida(position = game.at(x,y), cantidad= 10)},
		{x,y => new ConsumibleDeMana(position = game.at(x,y), cantidad = 10)},
		{x,y => new Llave(position = game.at(x,y))},
		{x,y => new Arana(position = game.at(x,y), vida = 1)},
		{x,y => new Deposito(position=game.at(x,y))}
	]
	/*
	*  0: nada
	*  1: muro
	*  2: caja
	*  3: moneda
	*  4: vida
	*  5: mana
	*  6: llave
	*  7: araña
	*/
	
	const enemigosDelMapa = [
		new Arana(position=game.at(6,6), vida = 1),
		new Arana(position=game.at(7,8), vida = 1)
	]
	
	method configurate() {
		
		game.addVisual(new Fondo(image="emptyMap.png"))
		(gameSize.width() + 1).times( { i =>  game.addVisual( new Barra(position=game.at(i - 1, 0)) ) } )
		enemigosDelMapa.forEach({ enemigo => game.addVisual(enemigo) })
		self.generarMapa()
		
		game.addVisual(personajePrincipal)
		personajePrincipal.mostrarEstadisticas()
		
		game.onTick(600, 'movimientoDeEnemigos', {
			self.losEnemigosDescansan(not self.losEnemigosDescansan())
			enemigosDelMapa.forEach({ enemigo =>
				const distancia = enemigo.position().distance(personajePrincipal.position())
				if (distancia < enemigo.vision()) {
					enemigo.moverHacia(personajePrincipal)				
				} else {
					if (not self.losEnemigosDescansan()) {
						enemigo.hacerMovimientoRandom()	
					}
				}
			})
		})
		
		keyboard.t().onPressDo({ self.terminar() })
		
		keyboard.up().onPressDo({ 
			personajePrincipal.subir()
			if (game.colliders(personajePrincipal).size() > 0) {
				const collider = game.uniqueCollider(personajePrincipal)
				if (not collider.esInamobible()) {
					if (collider.esDeposito()) {
						const faltantes = (collider.cargaMaxima() - collider.carga())
						if (faltantes < 1) {
							self.terminar()
						} else {
							game.say(collider, "faltan " + faltantes + if (faltantes > 1) { " cajas" } else { " caja" })	
						}
					} else if (not collider.tieneEfecto()) {
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
					if (collider.esDeposito()) {
						const faltantes = (collider.cargaMaxima() - collider.carga())
						if (faltantes < 1) {
							self.terminar()
						} else {
							game.say(collider, "faltan " + faltantes + if (faltantes > 1) { " cajas" } else { " caja" })	
						}
					} else if (not collider.tieneEfecto()) {
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
					if (collider.esDeposito()) {
						const faltantes = (collider.cargaMaxima() - collider.carga())
						if (faltantes < 1) {
							self.terminar()
						} else {
							game.say(collider, "faltan " + faltantes + if (faltantes > 1) { " cajas" } else { " caja" })	
						}
					} else if (not collider.tieneEfecto()) {
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
					if (collider.esDeposito()) {
						const faltantes = (collider.cargaMaxima() - collider.carga())
						if (faltantes < 1) {
							self.terminar()
						} else {
							game.say(collider, "faltan " + faltantes + if (faltantes > 1) { " cajas" } else { " caja" })	
						}
					} else if (not collider.tieneEfecto()) {
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



