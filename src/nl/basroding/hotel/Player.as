package nl.basroding.hotel
{
	import org.flixel.*;
	import nl.basroding.hotel.util.ControlScheme;

	public class Player extends Actor
	{
		private var _excecuting:Boolean;
		private var _excecutingNpc:Npc;
		
		public function Player(x:int, y:int, room:Room)
		{
			super(x, y, room);
			
			_excecuting = false;
		}
		
		override public function update():void
		{
			super.update();
			
			if(FlxG.keys.pressed(ControlScheme.LEFT))
				move(-1);
			else if(FlxG.keys.pressed(ControlScheme.RIGHT))
				move(1);
			else
				this.velocity.x = 0;
		}
		
		private function move(direction:int):void
		{
			this.velocity.x = RUN_SPEED * direction;
			
			if(_excecuting)
			{
				_excecutingNpc.kill();
				_excecuting = false;
			}
		}
		
		public function collideDoorHandler(player:Player, door:Door):void
		{
			if(FlxG.keys.justPressed(ControlScheme.ENTER_DOOR) && door.overlaps(player) && !_excecuting)
			{
				this.useDoor(door);
			}
		}
		
		public function collideNpcHandler(player:Player, npc:Npc):void
		{
			if(!npc.alive)
				return;
			
			if(FlxG.keys.justPressed(ControlScheme.EXECUTE))
			{
				if(player.x > npc.x) // right of npc
				{
					player.x = npc.x + npc.width;
				}
				else // left of npc
				{
					player.x = npc.x - player.width;
				}
				
				npc.startExcecution();
				_excecutingNpc = npc;
				_excecuting = true;
			}
		}
		
		public function collideSwitchHandler(player:Player, mySwitch:Switch):void
		{
			if(FlxG.keys.justPressed(ControlScheme.ACTION))
			{
				mySwitch.toggle(this);
			}
		}
	}
}