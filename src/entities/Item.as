package entities {
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author Wonjohn Choi
	 */
	public class Item extends Entity{
		public var destroyed:Boolean = false;
		
		public function destroy():void {
			FP.world.remove(this);
		}
		
		
		public function checkCollision(): void {
		
		}
		
	}

}