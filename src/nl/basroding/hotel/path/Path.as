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
		
		public function addWaypoint(object:IWaypoint):void
		{
			_path.push(object);
		}
		
		public function nextTarget():void
		{
			_currentIndex++;
			
			if(_currentIndex >= _path.length)
				_completed = true;
		}
		
		public function get target():IWaypoint
		{
			return _path[_currentIndex];
		}

		public function get completed():Boolean
		{
			return _completed;
		}

	}
}