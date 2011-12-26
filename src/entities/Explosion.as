package entities 
{
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	/**
	 * ...
	 * @author Wonjohn Choi
	 */
	public class Explosion extends Item {
		public var lifeTime:Number;
		public var size:Number;
		
		public function Explosion(lifeTime:Number, size:Number, locationX:Number, locationY:Number) {
			
			this.lifeTime = lifeTime;
			this.size = size;
			x = locationX;
			y = locationY;
			graphic = new Spritemap(Assets.square_white, size, size);
			type = "explosion";
			setHitbox(this.size, this.size);

		}
		
		public override function update():void {
			if (!destroyed) {
				if (lifeTime <=0) {
					destroyed = true;
					destroy();
				}else {				
					checkCollision();
					lifeTime-= FP.elapsed;
					if(graphic!=null){
						graphic = null;
					}else {
						graphic = new Spritemap(Assets.square_lightgray, size, size);
					}
				}
			}
			

		}
		
		public override function checkCollision(): void {
			var victims:Array = new Array();
			collideInto("enemy", x, y, victims);
			//collideInto("player", x, y, victims);
			//collideInto("bullet", x, y, victims);
			
			if (victims.length!=0) {
				for each(var victim:Item in victims) {
					victim.destroyed = true;
				}
			}
		}
		
	}

}