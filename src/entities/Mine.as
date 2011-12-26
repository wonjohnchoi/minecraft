/**
 * @author Wonjohn Choi
 */
package entities {
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.utils.*;
	import util.Math2D;
	
	public class Mine extends MovingItem {
		// Define Width and Height of sprite
		public static const SPRITE_WIDTH:Number = 5;
		public static const SPRITE_HEIGHT:Number = 5;
		
		public var destX:Number, destY:Number;
		public var explosionRange:Number;
		public var explosionLength:Number;
		public var owner:Player;
				
		public function Mine(player:Player, locationX:Number, locationY:Number, speed:Number, explosionRange:Number, explosionLength:Number) {
			graphic = new Spritemap(Assets.square_white, SPRITE_WIDTH, SPRITE_HEIGHT);
			
			x = player.x + Player.SPRITE_WIDTH / 2 - SPRITE_WIDTH/2;
			y = player.y + Player.SPRITE_HEIGHT / 2 - SPRITE_HEIGHT/2;
			destX = locationX;
			destY = locationY;
			
			this.speed = speed;
			this.explosionLength = explosionLength;
			this.explosionRange = explosionRange;
			
			setHitbox(SPRITE_WIDTH, SPRITE_HEIGHT);
			
			estimateSpeed();
			
			type = "bullet";
		}
		
		override public function update():void {
			if(!destroyed){
				if (!paused) {
					checkArrival();
				}
				
				if (!paused) {
					move();
					checkMapEdge();
				}
				
				checkCollision();
				
				super.update();
			}
			
			if (destroyed) {
				destroy();
			}
		}
		
		private function checkArrival(): void {
			if (Math2D.getDist(destX, destY, x+SPRITE_WIDTH/2, y+SPRITE_HEIGHT) < speed * FP.elapsed) {
				paused = true;
				x = destX - SPRITE_WIDTH/2;
				y = destY - SPRITE_HEIGHT/2;
			}
		}
		
		public override function checkCollision(): void {
			var enemies:Array = new Array();
			var enemy:Item;

			//work with direct
				
			collideInto("enemy", x, y, enemies);
				
			if (enemies.length != 0) {
				for each(enemy in enemies){
					enemy.destroyed = true;
				}
				
				FP.world.add(new Explosion(explosionLength, explosionRange, x + SPRITE_WIDTH / 2 - explosionRange/2, y + SPRITE_HEIGHT / 2 - explosionRange/2));
				destroyed = true;
			}
			
			
			/*When not using explosion
			var enemies:Array = new Array();
			var enemy:Enemy;

			//work with direct
			if(range==0){
				
				collideInto("enemy", x, y, enemies);
				
				if (enemies.length!=0) {
					for each(enemy in enemies){
						enemy.destroyed = true;
					}
					destroyed = true;
				}
			}else{//work with explosive
				if (collide("enemy", x, y)) {
					
					//FP.world.collideRectInto("enemy", x + SPRITE_WIDTH / 2 - range, y + SPRITE_HEIGHT / 2 - range, range * 2, range * 2, enemies);
					
					for each(enemy in enemies){
						enemy.destroyed = true;
					}
					destroyed = true;
				}
			}*/
		}
		
		private function checkMapEdge():void {
			if (x < 0 || x+SPRITE_WIDTH > FP.width || y < 0 || y+SPRITE_HEIGHT > FP.height) {
				destroyed = true;
			}
		}
		
		public function estimateSpeed():void {
			var dy:Number = destY-(y+SPRITE_HEIGHT/2) ;
			var dx:Number = destX-(x+SPRITE_WIDTH/2);
			var d:Number = Math2D.getDist(destX, destY, x+SPRITE_WIDTH/2, y+SPRITE_HEIGHT);
			
			speedX = dx / d * speed;
			speedY = dy / d * speed;
		}		
		
		public override function move():void {
			x += speedX*FP.elapsed;
			y += speedY*FP.elapsed;
		}
		
		

	}

}