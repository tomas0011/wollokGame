import wollok.game.*
import configuracion.*
import personajes.*
import elementos.*

class Nivel {
	var property xPersonaje
	var property yPersonaje
	var property puerta
	var property mapa
	const personajePrincipal = new PersonajePrincipal(position = game.at(xPersonaje,yPersonaje), vida = 100)
	const posicionesParaCeldasTrampa = []
		
	const celdasTrampa = [
		{x,y => new CeldaTrampa_Mana(position = game.at(x,y))},
		{x,y => new CeldaTrampa_Vida(position = game.at(x,y))},
		{x,y => new CeldaTrampa_Teletransporte(position = game.at(x,y))}
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
		{x,y => new Deposito(position=game.at(x,y))},
		{x,y => 
			const randNum = 0.randomUpTo(3).truncate(0)
			return celdasTrampa.get(randNum).apply(x,y)
		},
		{x,y => new Puerta(position=game.at(x,y))}
	]
	
	const enemigosDelMapa = [
		new Arana(position = game.at(7,4), vida = 1),
		new Arana(position = game.at(9,2), vida = 1)
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
	
	method personaje() = return personajePrincipal
	
	method posicionesParaAgregar() = posicionesParaCeldasTrampa 	
	
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
		
		// keyboard.t().onPressDo({ self.terminar() })
		
		keyboard.up().onPressDo({ 
			personajePrincipal.subir()
			if (game.colliders(personajePrincipal).size() > 0) {
				const collider = game.uniqueCollider(personajePrincipal)
				if (not collider.esInamobible()) {
					if (collider.esAcumulador()) {
						const faltantes = collider.faltantes()
						if (faltantes > 0) {
							collider.agregarDe(personajePrincipal)
							game.say(collider, "faltan " + collider.faltantes() + " " + collider.unidad())
							console.println("faltan " + collider.faltantes() + " " + collider.unidad())
						}
						if (faltantes < 1) {
							self.pasarDeNivel()
						}
					} else if (not collider.tieneEfecto()) {
						collider.subir()
					} else {
						collider.activarEfectoEn(personajePrincipal)
						game.removeVisual(collider)
					}
				}
			}
		})
		
		keyboard.down().onPressDo({ 			
			personajePrincipal.bajar()
			if (game.colliders(personajePrincipal).size() > 0) {
				const collider = game.uniqueCollider(personajePrincipal)
				if (not collider.esInamobible()) {
					if (collider.esAcumulador()) {
						const faltantes = collider.faltantes()
						if (faltantes > 0) {
							collider.agregarDe(personajePrincipal)
							game.say(collider, "faltan " + collider.faltantes() + " " + collider.unidad())
							console.println("faltan " + collider.faltantes() + " " + collider.unidad())
						}
						if (faltantes < 1) {
							self.pasarDeNivel()
						}
					} else if (not collider.tieneEfecto()) {
						collider.bajar()
					} else {
						collider.activarEfectoEn(personajePrincipal)
						game.removeVisual(collider)		
					}
				}
			}
		})
		
		keyboard.right().onPressDo({ 

			personajePrincipal.moverDerecha()
			if (game.colliders(personajePrincipal).size() > 0) {
				const collider = game.uniqueCollider(personajePrincipal)
				if (not collider.esInamobible()) {
					if (collider.esAcumulador()) {
						const faltantes = collider.faltantes()
						if (faltantes > 0) {
							collider.agregarDe(personajePrincipal)
							game.say(collider, "faltan " + collider.faltantes() + " " + collider.unidad())
							console.println("faltan " + collider.faltantes() + " " + collider.unidad())
						}
						if (faltantes < 1) {
							self.pasarDeNivel()
						}
					} else if (not collider.tieneEfecto()) {
						collider.moverDerecha()
					} else {
						collider.activarEfectoEn(personajePrincipal)
						game.removeVisual(collider)		
					}
				}
			}
		})
		
		keyboard.left().onPressDo({ 

			personajePrincipal.moverIzquierda()
			if (game.colliders(personajePrincipal).size() > 0) {
				const collider = game.uniqueCollider(personajePrincipal)
				if (not collider.esInamobible()) {
					if (collider.esAcumulador()) {
						const faltantes = collider.faltantes()
						if (faltantes > 0) {
							collider.agregarDe(personajePrincipal)
							game.say(collider, "faltan " + collider.faltantes() + " " + collider.unidad())
						}
						if (collider.faltantes() < 1) {
							self.pasarDeNivel()
						}
					} else if (not collider.tieneEfecto()) {
						collider.moverIzquierda()
					} else {
						collider.activarEfectoEn(personajePrincipal)
						game.removeVisual(collider)		
					}
				}
			}
		})
	}
	
	
	method generarMapa(){
		var x = 0
		var y = 0
		mapa.forEach( { fila => 
			x = 0
			y = y + 1
			fila.forEach( { columna => 
				const valorEnMapa = mapa.get((y-9).abs()).get(x)
				if (valorEnMapa != 0){
					game.addVisual( elementos.get(valorEnMapa).apply(x,y) )
				} else {
					posicionesParaCeldasTrampa.add( [ x,y ] )									
				}
				
				x = x+1
			} )
		} )
	}
	
	method pasarDeNivel(){
		game.clear()
		game.addVisual(new Fondo(image="youwin.png"))
		niveles.pasarDeNivel()
		
		game.schedule(2500, {
			game.clear()
			niveles.nivel().configurate()
		})
	}		
}





















