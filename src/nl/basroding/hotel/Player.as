package nl.basroding.hotel
{
	import org.flixel.*;

	public class Player extends Actor
	{
		public function Player()
		{
		}
		
		override public function update():void
		{
			super.update();
			
			if(FlxG.keys.A)
				this.velocity.x = -RUN_SPEED;
			else if(FlxG.keys.D)
				this.velocity.x = RUN_SPEED;
			else
				this.velocity.x = 0;
		}
		
		public function collideDoorHandler(player:Player, door:Door):void
		{
			if(FlxG.keys.justPressed("W") && door.overlaps(player))
			{
				player.x = door.connectingDoor.x;
				player.y = door.connectingDoor.y + (door.connectingDoor.height - player.height);
				player.dirty = true;
			}
		}
	}
}