import wollok.game.*
import nivel1.*

// en la implementación real, conviene tener un personaje por nivel
// los personajes probablemente tengan un comportamiendo más complejo que solamente
// imagen y posición



class Numero{
	var property position
	var property image = "mana (0).png"
	
	
	method cambiarNumeroA_(num){
		self.image(num + ".png")
	}
}


object personajeSimple {
	var vida = 99
	var mana = 99
	var property position = game.at(10,8)
	const property image = "player.png"	
	
	method subir() {
		const sigPosicion = position.up(1) 
		const y = sigPosicion.y()
		const x = sigPosicion.x()		
		if(y == 10 ){
			position = game.at(x,0)
		} else if (colisiones.esMuro(sigPosicion)){
			position = position.up(1)
		}
	}
	
	method bajar() {
		const sigPosicion = position.down(1) 
		const y = sigPosicion.y()
		const x = sigPosicion.x()		
		if(y == -1 ){
			position = game.at(x,9)
		} else if (colisiones.esMuro(sigPosicion)){
			position = position.down(1)
		}
		/*if( colisiones.esMuro(position.down(1)) ){	
			position = position.down(1)
		}*/
	}
	
	method moverDerecha() {
		const sigPosicion = position.right(1) 
		const y = sigPosicion.y()
		const x = sigPosicion.x()		
		if(x == 20 ){
			position = game.at(0,y)
		} else if (colisiones.esMuro(sigPosicion)){
			position = position.right(1)
		}
		/*if( colisiones.esMuro(position.down(1)) ){	
			position = position.right(1)
		}*/
		
	}
	
	method moverIzquierda() {
		const sigPosicion = position.left(1) 
		const y = sigPosicion.y()
		const x = sigPosicion.x()		
		if(x == -1 ){
			position = game.at(19,y)
		} else if (colisiones.esMuro(sigPosicion)){
			position = position.left(1)
		}
		
		/*if( colisiones.esMuro(position.left(1)) ){	
			position = position.left(1)
		}*/
	}
	
	
	
	
	method mostrarEstadisticas(){
		var vidaString = vida.toString().split("")
		var manaString = mana.toString().split("")
		
		if(vidaString.size()==1){vidaString.add("-")}
		if(manaString.size()==1){manaString.add("-")}
		
		const fsVida = new Numero(position = game.at(0,0), image = "vida ("+vidaString.get(0)+").png")		
		const scVida = new Numero(position = game.at(1,0), image = "vida ("+vidaString.get(1)+").png")
		
		const fsMana = new Numero(position = game.at(3,0), image = "mana ("+manaString.get(0)+").png")		
		const scMana = new Numero(position = game.at(4,0), image = "mana ("+manaString.get(1)+").png")
		//console.println(vidaString)
		//console.println(manaString)
		game.addVisual(fsVida)
		game.addVisual(scVida)
		game.addVisual(fsMana)
		game.addVisual(scMana)
	}
	
	method perderVida(vidaPerdida){
		const vidaProxima = vida - vidaPerdida
		if(vidaProxima <= 0){
			//nivelBloques.terminar()
			game.removeTickEvent("elpepe")
			vida = 0
			console.println("Elpepe")
		} else {
			vida = vidaProxima
		}
		self.mostrarEstadisticas()
		
	}
	
	method ganarVida(vidaGanada){
		vida = vida + vidaGanada
	}
	
	method perderMana(manaPerdido){
		const manaProximo = mana - manaPerdido
		
		if(manaProximo  <= 0){
			mana = 0
		} else {
			mana = manaProximo 
		}
		
		self.mostrarEstadisticas()
	}
	
	method ganarMana(manaGanado){
		mana = mana + manaGanado
	}
	
	
	

	
	
}

