package nl.basroding.hotel
{
	import nl.basroding.hotel.events.IRoomListener;
	import nl.basroding.hotel.events.RoomEvent;
	
	import org.flixel.FlxSprite;

	public class Actor extends FlxSprite
	{
		public static const CRAWL_SPEED:int = 10;
		public static const WALK_SPEED:int = 30;
		public static const RUN_SPEED:int = 110;
		
		protected var _room:Room;
		
		public function Actor(x:int, y:int, room:Room)
		{
			this.makeGraphic(16, 32, 0xffffffff);
			
			this.room = room;
			this.x = x;
			this.y = y;
		}
		
		public function set room(value:Room):void
		{
			_room = value;
			_room.addActor(this);
		}

		override public function update():void
		{
			super.update();
			
			if(velocity.x < 0)
				this.facing = LEFT;
			else if(velocity.x > 0)
				this.facing = RIGHT;
		
			this.velocity.y += 4;
		}
		
		public function useDoor(door:Door):void
		{
			_room.removeActor(this);
			_room = door.targetRoom;
			_room.addActor(this);
			
			this.x = door.connectingDoor.x;
			this.y = door.connectingDoor.y + (door.connectingDoor.height - this.height);
		}

		public function get room():Room
		{
			return _room;
		}

	}
}