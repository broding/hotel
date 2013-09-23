package nl.basroding.hotel
{
	import nl.basroding.hotel.events.IRoomListener;
	import nl.basroding.hotel.events.RoomEvent;
	
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import nl.basroding.hotel.actor.Actor;
	import nl.basroding.hotel.actor.body.Skin;

	public class Room extends FlxObject implements ISwitchTarget
	{
		private static var _uniqueId:int = 0;
		
		private var _id:int;
		private var _doors:Array;
		private var _actors:Array;
		private var _listeners:Array;
		private var _shadow:FlxSprite;
		private var _allowedSkins:Array;
		
		public function Room(x:int, y:int, width:int, height:int, allowedSkins:String)
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
			
			if(allowedSkins == "") // if no allowedSkins is passed, allow all skins
			{
				_allowedSkins = Game.skinManager.skins;
			}
			else
			{
				_allowedSkins = new Array();
				var skins:Array = allowedSkins.split(",");
				
				for each(var skinName:String in skins)
					addAllowedSkin(Game.skinManager.getSkinByName(skinName));
			}
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
		
		public function hasDoorToRoom(room:Room):Boolean
		{
			for each(var localDoor:Door in _doors)
			{
				if(localDoor.targetRoom == room)
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
			
			var event:RoomEvent = new RoomEvent();
			event.changedSwitch = mySwitch;
			event.switchOn = !_shadow.visible;
			
			for each(var listener:IRoomListener in _listeners)
				(listener as IRoomListener).onLightSwitch(event);
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
		
		public function addAllowedSkin(skin:Skin):void
		{
			_allowedSkins.push(skin);
		}
		
		public function isSkinAllowed(skin:Skin):Boolean
		{
			for each(var allowedSkin:Skin in _allowedSkins)
			{
				if(skin == allowedSkin)
					return true;
			}
			
			return false;
		}

		public function get shadow():FlxSprite
		{
			return _shadow;
		}

		public function get actors():Array
		{
			return _actors;
		}

		
	}
}