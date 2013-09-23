package nl.basroding.hotel
{
	import net.pixelpracht.tmx.TmxPropertySet;
	
	import nl.basroding.hotel.actor.Actor;
	import nl.basroding.hotel.actor.body.Body;
	import nl.basroding.hotel.actor.body.Skin;
	import nl.basroding.hotel.events.RoomEvent;
	import nl.basroding.hotel.npc.DeadBehavior;
	import nl.basroding.hotel.npc.IBehavior;
	import nl.basroding.hotel.path.IWaypoint;
	import nl.basroding.hotel.path.Path;
	import nl.basroding.hotel.path.Route;
	
	import org.flixel.FlxObject;

	public class Npc extends Actor
	{
		private var _behavior:IBehavior;
		
		private var _moving:Boolean;
		
		public function Npc(x:int, y:int, skin:Skin, room:Room)
		{
			super(x, y, skin, room);
			
			behavior = new DeadBehavior();
		}
		
		public function startExcecution():void
		{
			this.behavior = new DeadBehavior();
			this.alive = false;
			this.velocity.x = 0;
		}
		
		override public function update():void
		{
			super.update();
			
			if(alive)
			{
				_behavior.update();
			}
			
		}
		
		override public function set room(value:Room):void
		{
			super.room = value;
			
			_room.addListener(this.behavior);
		}
		
		override public function useDoor(door:Door):void
		{
			_room.removeListener(this.behavior);
			super.useDoor(door);
			_room.addListener(this.behavior);
			this.behavior.onEnterRoom(_room);
		}
		
		
		public function get behavior():IBehavior
		{
			return _behavior;
		}

		public function set behavior(value:IBehavior):void
		{
			if(value == null)
				value = new DeadBehavior();
			
			_room.removeListener(_behavior);
			_behavior = value;
			_room.addListener(_behavior);
		}

	}
}