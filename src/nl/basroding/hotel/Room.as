package nl.basroding.hotel
{
	import org.flixel.FlxObject;

	public class Room extends FlxObject
	{
		private static var _uniqueId:int = 0;
		
		private var _id:int;
		private var _doors:Array;
		
		public function Room(x:int, y:int, width:int, height:int)
		{
			this.x = x;
			this.y = y;
			this.width = width;
			this.height = height;
			
			_id = _uniqueId++;
			_doors = new Array();
		}

		public function addDoor(door:Door):void
		{
			_doors.push(door);
		}
		
		public function hasDoor(door:Door):Boolean
		{
			for each(var localDoor:Door in _doors)
			{
				if(localDoor == door)
					return true;
			}
			
			return false;
		}
		
		public function getDoorToRoom(room:Room):Door
		{
			for each(var door:Door in _doors)
			{
				if(door.targetRoom == room)
					return door;
			}
			
			throw new Error("No door leading to this room");
		}
		
		public function get id():int
		{
			return _id;
		}
	}
}