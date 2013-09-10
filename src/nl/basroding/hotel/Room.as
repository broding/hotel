package nl.basroding.hotel
{
	import nl.basroding.hotel.events.IRoomListener;
	import nl.basroding.hotel.events.RoomEvent;
	
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;

	public class Room extends FlxObject implements ISwitchTarget
	{
		private static var _uniqueId:int = 0;
		
		private var _id:int;
		private var _doors:Array;
		private var _actors:Array;
		private var _listeners:Array;
		private var _shadow:FlxSprite;
		
		public function Room(x:int, y:int, width:int, height:int)
		{
			this.x = x;
			this.y = y;
			this.width = width;
			this.height = height;
			
			_listeners = new Array();
			_id = _uniqueId++;
			_doors = new Array();
			_actors = new Array();
			
			_shadow = new FlxSprite().makeGraphic(width, height, 0xff000000);
			_shadow.x = x;
			_shadow.y = y;
			_shadow.alpha = 0.6;
			_shadow.visible = false;
		}
		
		public function addListener(listener:IRoomListener):void
		{
			_listeners.push(listener);
		}
		
		public function removeListener(listener:IRoomListener):void
		{
			_listeners.splice(_listeners.indexOf(listener), 1);
		}
		
		public function addActor(actor:Actor):void
		{
			_actors.push(actor);	
		}
		
		public function removeActor(actor:Actor):void
		{
			_actors.splice(_actors.indexOf(actor), 1);
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
		
		public function actorKilled(actor:Actor):void
		{
			var event:RoomEvent = new RoomEvent();
			event.killedActor = actor;
			
			for each(var listener:IRoomListener in _listeners)
			{
				(listener as IRoomListener).onActorKilledInRoom(event);
			}
		}
		
		public function get id():int
		{
			return _id;
		}
		
		public function isLightOn():Boolean
		{
			return !_shadow.visible;
		}
		
		public function toggleSwitch(mySwitch:Switch):void
		{
			_shadow.visible = _shadow.visible ? false : true;
			
			if(!_shadow.visible) // if lights have been turned out
			{
				var event:RoomEvent = new RoomEvent();
				event.changedSwitch = mySwitch;
				event.switchOn = !_shadow.visible;
				
				for each(var listener:IRoomListener in _listeners)
					(listener as IRoomListener).onLightSwitch(event);
			}
		}
		
		public function hasDeadActor():Boolean
		{
			for each(var actor:Actor in _actors)
			{
				if(!actor.alive)
					return true;
			}
			
			return false;
		}

		public function get shadow():FlxSprite
		{
			return _shadow;
		}

		
	}
}