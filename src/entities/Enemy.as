/**
 * @author Wonjohn Choi
 */
package entities {
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.utils.*;
	import util.Math2D;
	
	public class Enemy extends MovingItem {
		public var SPRITE_WIDTH:Number;
		public var SPRITE_HEIGHT:Number;
		
		public function Enemy(posX:Number, posY:Number, speed:Number, width:Number, height:Number) {
			SPRITE_WIDTH = width;
			SPRITE_HEIGHT = height;
			this.speed = speed;
			
			graphic = new Spritemap(Assets.square_red, SPRITE_WIDTH, SPRITE_HEIGHT);
			
			x = posX;
			y = posY;			
	
			setHitbox(SPRITE_WIDTH, SPRITE_HEIGHT);
			type = "enemy";
		}
		
		
		override public function update():void {
			if(!destroyed){
				var closePlayer:Player = world.nearestToEntity("player", this, true) as Player;
			
				if(closePlayer!=null){		
					if (!paused) {
						estimateSpeed(closePlayer);
						move();
					}
					
					checkCollision();

					super.update();
				}
			}
			if (destroyed) {
				destroy();
			}
		}

		public override function checkCollision(): void {

		}
		
		public function estimateSpeed(player:Player):void {
			var dy:Number = (player.y+Player.SPRITE_HEIGHT)-(y+SPRITE_HEIGHT/2) ;
			var dx:Number = (player.x+Player.SPRITE_WIDTH)-(x+SPRITE_WIDTH/2);
			var d:Number = Math2D.getDist(player.x+Player.SPRITE_WIDTH,player.y+Player.SPRITE_HEIGHT, x+SPRITE_WIDTH, y+SPRITE_HEIGHT) ;
			
			speedX = dx / d * speed;
			speedY = dy / d * speed;
		}
		
		public override function move():void {
			x += speedX*FP.elapsed;
			y += speedY*FP.elapsed;
		}
		
		

	}

}