/**
 * @author Wonjohn Choi
 */
package levels{
	import entities.Mine;
	import entities.Explosion;
	import entities.Item;
	import entities.Player;
	import net.flashpunk.World;
	import net.flashpunk.utils.Input;
	import net.flashpunk.FP;
	import entities.Enemy;

	
	public class Level1 extends World{					
		
		public var player:Player;
		public var enemies:Array;

		public function Level1(player:Player, enemies:Array){
			this.player = player;
			this.enemies = enemies;
        	add(player);
			addList(enemies);

		}
		
		override public function update():void	{			
			if (player.destroyed) {
				if (Input.mouseDown) {
					
					
					removeList(enemies);
					for each(var e:Enemy in enemies) {
						e.destroyed = true;
					}
					var x:Array = new Array();
					FP.world.getType("bullet", x) as Item;
					FP.world.getType("explosion", x) as Item;
					for each(var b:Item in x) {
						b.destroyed = true;
					}
					removeList(x); 	
					enemies = new Array();
					player = new Player(FP.width / 2 - Player.SPRITE_WIDTH / 2, FP.height / 2 - Player.SPRITE_HEIGHT / 2, 100, 30, 10, 200, 30, 2);
      
			
					for (var y:int = 0; y < 5; y += 1) {
						for (var z:int = 0; z < FP.width;z+=50){
						//enemies.push(new Enemy(0, 0, 200*Math.random(), 50*Math.random(), 50*Math.random()));
							enemies.push(new Enemy(z, FP.height, 100+100 * Math.random(), 25*Math.random()+1,25*Math.random()+1));
						}
						
						for (var k:int = 0; k < FP.height; k += 50) {
						//enemies.push(new Enemy(0, 0, 200*Math.random(), 50*Math.random(), 50*Math.random()));
							enemies.push(new Enemy(0, k, 100+100 * Math.random(), 25*Math.random()+1,25*Math.random()+1));
						}
						
					
				
						add(player);
						addList(enemies);
						//enemies.push(new Enemy( FP.width,0, 200 * Math.random(), 2, 2));
						//enemies.push(new Enemy( FP.width, FP.height, 200 * Math.random(), 2, 2));
					}
				}
			}
			super.update();
		}
		
		

		
	
		
	}
}
		