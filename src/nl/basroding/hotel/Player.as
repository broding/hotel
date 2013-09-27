package nl.basroding.hotel
{
	import nl.basroding.hotel.actor.Actor;
	import nl.basroding.hotel.actor.body.Skin;
	import nl.basroding.hotel.util.ControlScheme;
	
	import org.flixel.FlxG;

	public class Player extends Actor
	{	
		private var _excecuting:Boolean;
		private var _excecutingNpc:Npc;
		
		public function Player(x:int, y:int, room:Room)
		{
			super(x, y, Game.skinManager.getSkinByName("player"), room);
			
			FlxG.camera.follow(_body.cameraTarget);
			
			_excecuting = false;
		}
		
		override public function update():void
		{
			if(FlxG.keys.pressed(ControlScheme.LEFT))
				move(-1);
			else if(FlxG.keys.pressed(ControlScheme.RIGHT))
				move(1);
			else
				this.velocity.x = 0;
			
			playAnimation();
			
			super.update();
		}
		
		private function playAnimation():void
		{
			if(velocity.x != 0)
				play("walk");
			else
				play("still");
		}
		
		private function move(direction:int):void
		{
			if(!alive || Game.freeze)
				return;
			
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
			{
				if(FlxG.keys.justPressed(ControlScheme.EXECUTE) && !npc.isNaked())
					this.swapSkin(npc);	
				
				return;
			}
			
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
		
		private function swapSkin(actor:Actor):void
		{
			var playerSkin:Skin = skin;
			
			_body.swapCloths(actor.skin);
			
			actor.getNaked();
		}
		
		public function collideSwitchHandler(player:Player, mySwitch:Switch):void
		{
			if(FlxG.keys.justPressed(ControlScheme.ACTION))
			{
				mySwitch.toggle(this);
			}
		}
		
		override public function kill():void
		{
			this.alive = false;
		}
	}
}