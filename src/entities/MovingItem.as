package entities {
	import net.flashpunk.FP
	
	/**
	 * ...
	 * @author Wonjohn Choi
	 */
	public class MovingItem extends Item {
		public var paused:Boolean = false;

		public var speed:Number;
		public var speedX:Number, speedY:Number;
		
		
		public function move():void {
			
		}
		
		public override function destroy():void {
			FP.world.remove(this);
		}
		
		
		public override function checkCollision(): void {
		
		}
		
		

		
	}

}