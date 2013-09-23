package nl.basroding.hotel.path
{
	import nl.basroding.hotel.*;
	
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	
	/**
	 * Contains all the information (waypoints, wait time) for a NPC his route
	 */
	public class Route
	{
		private var _route:Array;
		private var _path:Path;
		private var _subject:FlxObject;
		
		private var _index:uint;
		private var _completed:Boolean;
		private var _callback:Function;
		
		public var loop:Boolean;
		
		public function Route(loop:Boolean = true, callback:Function = null)
		{
			this.loop = loop;
			
			_route = new Array();
			_index = 0;
			_completed = true;
			_callback = callback;
		}
		
		public function start(subject:FlxObject):void
		{
			if(_route.length > 0)
			{
				_subject = subject;
				_completed = false;
				_path = generatePath(_route[0]);
			}
			
			if(_route.length == 1)
				loop = false;
		}
		
		private function generatePath(waypoint:IWaypoint):Path
		{
			return Game.generatePath(_subject, waypoint);
		}
		
		public function addWaypoint(waypoint:IWaypoint):void
		{
			_route.push(waypoint);
		}
		
		public function removeWaypoint(waypoint:IWaypoint):void
		{
			_route = _route.splice(_route.indexOf(waypoint), 1);
		}
		
		public function nextWaypoint():void
		{
			_path.nextTarget();
			
			if(_path.completed && !this._completed)
			{
				_index++;
				
				if(_index >= _route.length && !loop)
				{	
					_completed = true;
					
					if(_callback != null)
						_callback.call();
					
					return;
				}
					
				if(_index >= _route.length && loop)
					_index = 0;
					
				_path = generatePath(_route[_index]);
			}
		}
		
		public function print():void
		{
			var print:String = new String();
			
			for(var i:int = 0; i < _route.length; i++)
			{
				print = print + _route[i] + " | ";
			}
		}
		
		public function get target():IWaypoint
		{
			return _path.target;
		}

		public function get completed():Boolean
		{
			return _completed;
		}

		public function get callback():Function
		{
			return _callback;
		}

	}
}