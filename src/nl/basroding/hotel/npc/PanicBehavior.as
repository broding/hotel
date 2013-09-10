package nl.basroding.hotel.npc
{
	import nl.basroding.hotel.Actor;
	import nl.basroding.hotel.Door;
	import nl.basroding.hotel.Npc;
	import nl.basroding.hotel.Room;
	import nl.basroding.hotel.events.RoomEvent;
	
	import org.flixel.*;

	public class PanicBehavior implements IBehavior
	{
		private var _npc:Npc;
		
		private var _waitTime:Number;
		private var _waiting:Boolean;
		private var _randomTime:Number;
		
		public function PanicBehavior(npc:Npc)
		{
			_npc = npc;
			_waitTime = 0;
			_waiting = false;
			_randomTime = 0.5;
		}
		
		public function update():void
		{
			_waitTime += FlxG.elapsed;
			
			if(_waitTime > _randomTime)
			{
				_waitTime = 0;
				
				if(_waiting)
				{
					_randomTime = FlxG.random() * 0.5; 
					_waiting = false;
					
					// run the other direction then the npc is facing
					if(_npc.facing == FlxObject.LEFT)
						_npc.velocity.x = Actor.RUN_SPEED;
					else if(_npc.facing == FlxObject.RIGHT)
						_npc.velocity.x = -Actor.RUN_SPEED;
				}
				else
				{
					_randomTime = FlxG.random() * 2 + 1; 
					_npc.velocity.x = 0;
					_waiting = true;
				}
			}
		}
		
		public function onActorKilledInRoom(event:RoomEvent):void
		{
			// TODO Auto Generated method stub
			
		}
		
		public function onLightSwitch(event:RoomEvent):void
		{
			// TODO Auto Generated method stub
			
		}
		
		public function onEnterRoom(room:Room):void
		{
			// TODO Auto Generated method stub
			
		}
		
		
	}
}