package nl.basroding.hotel.path
{
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	
	/**
	 * Contains all the information (waypoints, wait time) for a NPC his route
	 */
	public class Route
	{
		private var _route:Array;
		private var _currentIndex;
		private var _completed:Boolean;
		
		public var loop:Boolean;
		
		public function Route(loop:Boolean = true)
		{
			this.loop = loop;
			
			_route = new Array();
			_currentIndex = 0;
			_completed = false;
		}
		
		public function addWaypoint(waypoint:IWaypoint):void
		{
			_route.push(waypoint);
		}
		
		public function nextTarget():FlxObject
		{
			_currentIndex++;
			
			_completed = _currentIndex + 1 == _route.length && !loop;
			
			if(loop && _currentIndex == _route.length)
				_currentIndex = 0;
			
			return _route[_currentIndex];
		}
		
		public function print():void
		{
			var print:String = new String();
			
			for(var i:int = 0; i < _route.length; i++)
			{
				print = print + _route[i] + " | ";
			}
		}
		
		public function get target():FlxObject
		{
			return _route[_currentIndex];
		}

		public function get completed():Boolean
		{
			return _completed;
		}
	}
}