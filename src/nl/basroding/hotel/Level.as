package nl.basroding.hotel
{
	import nl.basroding.hotel.path.AdjacencyMatrix;
	import nl.basroding.hotel.path.ConcreteWaypoint;
	import nl.basroding.hotel.path.IWaypoint;
	import nl.basroding.hotel.path.Pathfinder;
	import nl.basroding.hotel.path.Route;
	
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;

	public class Level
	{
		private var _doors:FlxGroup
		private var _rooms:FlxGroup;
		private var _waypoints:FlxGroup;
		private var _switches:FlxGroup;
		private var _shadows:FlxGroup;
		private var _matrix:AdjacencyMatrix;
	
		public function Level()
		{
			_doors = new FlxGroup();
			_rooms = new FlxGroup();
			_waypoints = new FlxGroup();
			_shadows = new FlxGroup();
			_switches = new FlxGroup();
		}
		
		/**
		 * Connects all doors with eachother
		 */
		public function connectDoors():void
		{
			for each(var door:Door in _doors.members)
			{
				for each(var subDoor:Door in _doors.members)
				{
					if(door.connectingDoorId == subDoor.id)
					{
						door.connectingDoor = subDoor;
						door.targetRoom = subDoor.ownRoom;
						subDoor.connectingDoor = door;
						subDoor.targetRoom = door.ownRoom;
					}
				}
			}
		}
		
		/**
		 * Fills all the rooms with the correct doors
		 */
		public function connectDoorsWithRooms():void
		{
			for each(var door:Door in _doors.members)
			{
				for each(var room:Room in _rooms.members)
				{
					if(door.overlaps(room))
					{
						room.addDoor(door);
						door.ownRoom = room;
					}
				}
			}
		}
		
		public function createAdjacencyMatrix():void
		{
			_matrix = new AdjacencyMatrix(_rooms.length);
			
			for each(var door:Door in _doors.members)
			{
				var room1:Room = getRoomOfDoor(door);
				var room2:Room = getRoomOfDoor(door.connectingDoor);
				
				if(room1 == null || room2 == null)
					throw new Error("A door has no room!");
				
				_matrix.setConnection(room1, room2, true);
			}
		}
		
		public function getRoom(id:int):Room
		{
			for each(var room:Room in _rooms.members)
			{
				if(room.id == id)
					return room;
			}
			
			throw new Error("Room with id not found");
		}
		
		public function getRoomOfDoor(door:Door):Room
		{
			for each(var room:Room in _rooms.members)
			{
				if(room.hasDoor(door))
					return room;
			}
			
			throw new Error("Door has no room");
		}
		
		/**
		 * Create a route of a string containing waypoints id's, seperated by ,
		 */
		public function createRoute(waypoints:String):Route
		{
			var route:Route = new Route();
			
			var split:Array = waypoints.split(",");
			
			for each(var id:String in split)
			{
				for each(var waypoint:ConcreteWaypoint in _waypoints.members)
					if(waypoint.id == id)
					{
						route.addWaypoint(waypoint);
						break;
					}
			}
			
			return route;
		}
		
		public function getRoomOfObject(object:FlxObject):Room
		{
			for each(var room:Room in _rooms.members)
			{
				if(room.overlaps(object))
					return room;
			}
			
			throw new Error("Object is not in a room");
		}
		
		public function getRoomOfPosition(x:int, y:int):Room
		{
			var point:FlxPoint = new FlxPoint(x, y);
			
			for each(var room:Room in _rooms.members)
			{
				if(room.overlapsPoint(point))
					return room;
			}
			
			throw new Error("Position is not in a room");
		}

		public function get rooms():FlxGroup
		{
			return _rooms;
		}

		public function get doors():FlxGroup
		{
			return _doors;
		}
		
		public function get waypoints():FlxGroup
		{
			return _waypoints;
		}

		public function get matrix():AdjacencyMatrix
		{
			return _matrix;
		}

		public function get shadows():FlxGroup
		{
			return _shadows;
		}

		public function get switches():FlxGroup
		{
			return _switches;
		}


	}
}