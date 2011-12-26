/**
 * @author Wonjohn Choi
 */
package  {
	import entities.Enemy;
	import entities.Player;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import levels.Level1;
	
	[SWF(width = "640", height = "480")]
	
	public class Main extends Engine {
		public function Main():void {

			super(640, 480, 60, false);
			var enemies:Array = new Array();
			var player:Player = new Player(FP.width / 2 - Player.SPRITE_WIDTH / 2, FP.height / 2 - Player.SPRITE_HEIGHT / 2, 100, 30, 10, 200, 30, 2);
      
			
			for (var y:int = 0; y < 5; y += 1) {
				for (var z:int = 0; z < FP.width;z+=50){
				//enemies.push(new Enemy(0, 0, 200*Math.random(), 50*Math.random(), 50*Math.random()));
					enemies.push(new Enemy(z, FP.height, 100+100 * Math.random(), 25*Math.random()+1,25*Math.random()+1));
				}
				
				for (var k:int = 0; k < FP.height; k += 50) {
				//enemies.push(new Enemy(0, 0, 200*Math.random(), 50*Math.random(), 50*Math.random()));
					enemies.push(new Enemy(0, k, 100+100 * Math.random(), 25*Math.random()+1,25*Math.random()+1));
				}
				
			
				
				//enemies.push(new Enemy( FP.width,0, 200 * Math.random(), 2, 2));
				//enemies.push(new Enemy( FP.width, FP.height, 200 * Math.random(), 2, 2));
			}

			FP.world = new Level1(player, enemies);	
			//FP.console.enable();
	
			/*
			var rectangle:Shape = new Shape; // initializing the variable named rectangle
rectangle.graphics.beginFill(0xFF0000); // choosing the colour for the fill, here it is red
rectangle.graphics.drawRect(0, 0, 100,100); // (x spacing, y spacing, width, height)
rectangle.graphics.endFill(); // not always needed but I like to put it in to end the fill
addChild(rectangle);*/
		


		}
	}

}