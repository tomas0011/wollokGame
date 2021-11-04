import wollok.game.*
import personajes.*
import nivel1.*


class Enemigo{
	const property image = "enemigo.png"
	var property position = game.at(2,2)
	
	method moverEnemigo(){
		const player_x = personajeSimple.position().x()
		const player_y = personajeSimple.position().y()
		
		
		if ( (position.x() - player_x) < 0 ){
			self.moverIzquierda()
		} else {
			self.moverDerecha()
		}
		
		if ( (position.y() - player_y) < 0 ){
			self.moverAbajo()
		} else {
			self.moverArriba()
		}
	}
	
	
	
	
	
	method moverIzquierda(){
		const sigPosicion = position.left(1) 
		const y = sigPosicion.y()
		const x = sigPosicion.x()		
		if(x == -1 ){
			position = game.at(19,y)
		} else if (colisiones.esMuro(sigPosicion)){
			position = position.left(1)
		}
	}
	method moverDerecha(){
		const sigPosicion = position.right(1) 
		const y = sigPosicion.y()
		const x = sigPosicion.x()		
		if(x == 20 ){
			position = game.at(0,y)
		} else if (colisiones.esMuro(sigPosicion)){
			position = position.right(1)
		}
	}
	method moverArriba(){
		const sigPosicion = position.up(1) 
		const y = sigPosicion.y()
		const x = sigPosicion.x()		
		if(y == 10 ){
			position = game.at(x,0)
		} else if (colisiones.esMuro(sigPosicion)){
			position = position.up(1)
		}
	}
	method moverAbajo(){
		const sigPosicion = position.down(1) 
		const y = sigPosicion.y()
		const x = sigPosicion.x()		
		if(y == -1 ){
			position = game.at(x,9)
		} else if (colisiones.esMuro(sigPosicion)){
			position = position.down(1)
		}
	}
	
	
	
}