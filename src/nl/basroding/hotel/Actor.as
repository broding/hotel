package nl.basroding.hotel
{
	import nl.basroding.hotel.events.IRoomListener;
	import nl.basroding.hotel.events.RoomEvent;
	
	import org.flixel.FlxSprite;

	public class Actor extends FlxSprite implements IRoomListener
	{
		protected const CRAWL_SPEED:int = 30;
		protected const WALK_SPEED:int = 50;
		protected const RUN_SPEED:int = 150;
		
		protected var _room:Room;
		
		public function Actor(x:int, y:int, room:Room)
		{
			this.makeGraphic(16, 32, 0xffffffff);
			
			_room = room;
			this.x = x;
			this.y = y;
		}
		
		public function actorKilledInRoom(event:RoomEvent):void
		{
			// TODO Auto Generated method stub
		}
		
		public function set room(value:Room):void
		{
			_room = value;
			_room.addListener(this);
		}

		override public function update():void
		{
			super.update();
		
			this.velocity.y += 4;
		}
		
		public function useDoor(door:Door):void
		{
			_room.removeListener(this);
			_room = door.ownRoom;
			_room.addListener(this);
			
			this.x = door.connectingDoor.x;
			this.y = door.connectingDoor.y + (door.connectingDoor.height - this.height);
		}
	}
}