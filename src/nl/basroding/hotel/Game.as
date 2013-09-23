package nl.basroding.hotel
{
	import nl.basroding.hotel.path.Dijkstra;
	import nl.basroding.hotel.path.IWaypoint;
	import nl.basroding.hotel.path.Path;
	
	import org.flixel.*;
	import nl.basroding.hotel.actor.Actor;
	import nl.basroding.hotel.actor.body.SkinManager;

	public class Game
	{
		public static var pause:Boolean = false;
		public static var freeze:Boolean = false;
		
		private static var _level:Level;
		private static var _lineSprite:FlxSprite;
		private static var _debugGroup:FlxGroup;
		private static var _player:Player;
		private static var _skinManager:SkinManager;
		private static var _guiOverlay:GUIOverlay;
		
		private static var _drawDebug:Boolean = false;
		private static var _selectedRoom:Room;
		private static var _selectedActor:Actor;
		private static var _roomText:FlxText;
		private static var _actorText:FlxText;
		
		public static function set drawDebug(value:Boolean):void
		{
			_drawDebug = value;
			
			if(_drawDebug)
			{
				_roomText = new FlxText(5, 5, 500, "");
				_roomText.scrollFactor = new FlxPoint(0, 0);
				_actorText = new FlxText(5, 35, 500, "");
				_actorText.scrollFactor = new FlxPoint(0, 0);
				
				_debugGroup.add(_roomText);
				_debugGroup.add(_actorText);
				
				FlxG.mouse.show();
			}
			else
			{
				_debugGroup.clear();
			}
		}

		public static function set level(value:Level):void
		{
			if(_level == null)
				_level = value;
			else
				throw new Error("Level already set");
		}
		
		public static function set debugGroup(value:FlxGroup):void
		{
			if(_debugGroup == null)
				_debugGroup = value;
			else
				throw new Error("Debug group already set");
		}
		
		public static function generatePath(subject:FlxObject, target:IWaypoint):Path
		{
			var finder:Dijkstra = new Dijkstra(_level, subject, target);
			
			return finder.path;
		}
		
		public static function drawLine(start:FlxPoint, end:FlxPoint, color:uint, thickness:uint = 1):void
		{
			_lineSprite.drawLine(start.x, start.y, end.x, end.y, color, thickness);
		}

		public static function set lineSprite(value:FlxSprite):void
		{
			if(_lineSprite == null)
				_lineSprite = value;
			else
				throw new Error("lineSprite already set");
		}
		
		public static function update():void
		{
			if(_drawDebug)
			{
				if(FlxG.mouse.justPressed())
					onMouseClick();
				
				if(_selectedRoom != null)
					_roomText.text = "Room id: " + _selectedRoom.id + "\n" +
						"Actors in room: " + _selectedRoom.actors.length;
				
				if(_selectedActor != null)
					_actorText.text = "Actor type: " + _selectedActor + "\n" +
						"Behavior: " + (_selectedActor is Npc ? (_selectedActor as Npc).behavior : "none");
					
			}
		}
		
		private static function onMouseClick():void
		{
			for each(var room:Room in _level.rooms.members)
			{
				var mouseInWorld:FlxPoint = FlxG.mouse.getWorldPosition();
				
				if(room.overlapsPoint(mouseInWorld))
				{
					_selectedRoom = room;
					
					for each(var actor:Actor in room.actors)
					{
						if(actor.overlapsPoint(mouseInWorld))
							_selectedActor = actor;
					}
				}
			}
		}

		public static function set player(value:Player):void
		{
			if(_player == null)
				_player = value;
			else 
				throw new Error("Player already set");
		}

		public static function get player():Player
		{
			return _player;
		}

		public static function get skinManager():SkinManager
		{
			return _skinManager;
		}

		public static function set skinManager(value:SkinManager):void
		{
			if(_skinManager != null)
				throw new Error("Skin Manager already set");
			
			_skinManager = value;
		}

		public static function get guiOverlay():GUIOverlay
		{
			return _guiOverlay;
		}

		public static function set guiOverlay(value:GUIOverlay):void
		{
			_guiOverlay = value;
		}


	}
}