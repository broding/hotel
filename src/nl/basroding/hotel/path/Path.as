package nl.basroding.hotel.path
{
	import org.flixel.FlxObject;

	public class Path
	{
		private var _path:Array;
		private var _currentIndex:int;
		private var _completed:Boolean;
		
		public function Path()
		{
			_path = new Array();
			_currentIndex = 0;
			_completed = false;
		}
		
		public function addWaypoint(object:FlxObject):void
		{
			_path.push(object);
		}
		
		public function nextTarget():FlxObject
		{
			_currentIndex++;
			
			_completed = _currentIndex + 1 == _path.length;
			
			return _path[_currentIndex];
		}
		
		public function get target():FlxObject
		{
			return _path[_currentIndex];
		}

		public function get completed():Boolean
		{
			return _completed;
		}

	}
}