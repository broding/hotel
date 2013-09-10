package nl.basroding.hotel
{
	import net.pixelpracht.tmx.TmxPropertySet;
	
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
		
		public function Npc(x:int, y:int, room:Room)
		{
			super(x, y, room);
			
			_behavior = new DeadBehavior();
			
			this.makeGraphic(16, 32, 0xff5500ff);
		}
		
		override public function kill():void
		{
			this.makeGraphic(16, 16, 0xff5500ff);
		}
		
		public function startExcecution():void
		{
			this.behavior = new DeadBehavior();
			this.alive = false;
			this.velocity.x = 0;
			this.makeGraphic(16, 32, 0xff5500ff);
			
			this._room.actorKilled(this);
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