package nl.basroding.hotel
{
	import nl.basroding.hotel.path.IWaypoint;
	
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import nl.basroding.hotel.actor.Actor;

	public class Door extends FlxSprite implements IWaypoint
	{
		[Embed(source="../../../../assets/levels/door.png")] private var doorClass:Class;
		
		private var _connectingDoorId:int;
		private var _connectingDoor:Door;
		private var _id:int;
		private var _ownRoom:Room;
		private var _targetRoom:Room;
		
		public function Door(x:int, y:int, id:int, connecting:int)
		{
			this.loadGraphic(doorClass);
			this.x = x;
			this.y = y;
			this._id = id;
			this._connectingDoorId = connecting;
		}

		public function set connectingDoor(value:Door):void
		{
			if(_connectingDoor == null)
				_connectingDoor = value;
			else if(_connectingDoor != value)
				throw new Error("This door is already connected to another door");
		}

		public function get connectingDoor():Door
		{
			return _connectingDoor;
		}

		public function get connectingDoorId():int
		{
			return _connectingDoorId;
		}
		
		public function get id():int
		{
			return _id;
		}

		public function get ownRoom():Room
		{
			return _ownRoom;
		}

		public function set ownRoom(value:Room):void
		{
			if(_ownRoom == null)
				_ownRoom = value;
			else
				throw new Error("Own room already set");
		}

		public function get targetRoom():Room
		{
			return _targetRoom;
		}

		public function set targetRoom(value:Room):void
		{
			if(_targetRoom == null || _targetRoom == value)
				_targetRoom = value;
			else
				throw new Error("Target room already set");
		}


		public function getPosition():FlxObject
		{
			return this;
		}
		
		public function useWaypoint(actor:Actor):Boolean
		{
			actor.useDoor(this);
			
			return true;
		}
		
	}
}