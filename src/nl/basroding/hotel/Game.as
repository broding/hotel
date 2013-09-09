package nl.basroding.hotel
{
	import nl.basroding.hotel.path.Path;
	import nl.basroding.hotel.path.Pathfinder;
	
	import org.flixel.FlxObject;

	public class Game
	{
		private static var _level:Level;
		
		public static function set level(value:Level):void
		{
			if(_level == null)
				_level = value;
			else
				throw new Error("Level already set");
		}
		
		public static function generatePath(subject:FlxObject, target:FlxObject):Path
		{
			var finder:Pathfinder = new Pathfinder(_level, subject, target);
			
			return finder.path;
		}
	}
}