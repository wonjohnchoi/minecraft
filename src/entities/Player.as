/**
 * @author Wonjohn Choi
 */
package entities {
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class Player extends MovingItem {
		public static const SPRITE_WIDTH:Number = 15;
		public static const SPRITE_HEIGHT:Number = 15;
		
		public var bulletDelay:Number;
		public var bulletDelayLeft:Number;
		public var bulletsLeft:Number;
		public var bulletSpeed:Number;
		public var explosionRange:Number;
		public var explosionLength:Number;
		
		public function Player(posX:Number, posY:Number, speed:Number, bulletDelay:Number, bulletsLeft:Number, bulletSpeed:Number, bulletExplosionRange:Number, bulletExplosionlength:Number) {
			graphic = new Spritemap(Assets.square_white, SPRITE_WIDTH, SPRITE_HEIGHT);
			
			x = posX;
			y = posY;
			
			this.speed = speed;
			
			this.bulletDelay = bulletDelay;
			this.bulletsLeft = bulletsLeft;
			this.bulletSpeed = bulletSpeed;
			explosionRange = bulletExplosionRange;
			this.bulletDelayLeft = bulletDelay;
			explosionLength = bulletExplosionlength;
			
			Input.define("moveUp", Key.W, Key.UP)
			Input.define("moveLeft", Key.A, Key.LEFT)
			Input.define("moveDown", Key.S, Key.DOWN)
			Input.define("moveRight", Key.D, Key.RIGHT)
			
			setHitbox(SPRITE_WIDTH, SPRITE_HEIGHT);
			
			type = "player";
		}
		
		override public function update():void{
			move();
			checkCollision();
			
			if (Input.mouseDown && bulletDelayLeft == 0 &&bulletsLeft>0) {
				placeMine(FP.world.mouseX, FP.world.mouseY, bulletSpeed);
			}else if (bulletDelayLeft != 0) {
				bulletDelayLeft-=1;
			}
			
			
			
			if (destroyed) {
				destroy();
			}
			super.update();
		}

		
		public override function checkCollision(): void {
			var enemies:Array = new Array();
			collideInto("enemy", x, y, enemies);
			
			if (enemies.length!=0) {
				for each(var enemy:Enemy in enemies) {
					enemy.destroyed = true;
				}
				destroyed = true;
			}
		}
		
		
		public override function move():void {
			if (Input.check("moveLeft")){
				x = Math.max(0, x-speed * FP.elapsed);
			}
			if (Input.check("moveRight")){
				x = Math.min(FP.width-SPRITE_WIDTH, x+speed * FP.elapsed);
			}
			if (Input.check("moveUp")) {
				y = Math.max(0, y-speed * FP.elapsed);	
			}
			if (Input.check("moveDown")){
				y = Math.min(FP.height-SPRITE_HEIGHT, y+speed * FP.elapsed);
			}
		
			
			
		}
		
				
		public function placeMine(locationX:Number, locationY:Number, speed:Number):void {
				FP.world.add(new Mine(this, locationX, locationY, speed, explosionRange, explosionLength));
				bulletDelayLeft = bulletDelay ;
				bulletsLeft -= 1;	
		}

	}

}