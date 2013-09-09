package nl.basroding.hotel.path
{
	import nl.basroding.hotel.Level;
	import nl.basroding.hotel.Room;
	
	import org.flixel.FlxObject;

	public class Pathfinder
	{
		private const INFINITY:int = int.MAX_VALUE;
		
		private var _level:Level;
		private var _subject:FlxObject;
		private var _target:FlxObject;
		
		private var _distance:Array;
		private var _previous:Array;
		private var _completed:Array;
		private var _queue:Array;
		
		private var _start:int;
		
		private var _path:Path;
		
		public function Pathfinder(level:Level, subject:FlxObject, target:FlxObject)
		{
			_level = level;
			_subject = subject;
			_target = target;
			
			_path = new Path();
			
			var subjectRoom:Room = _level.getRoomOfObject(subject);
			var targetRoom:Room = _level.getRoomOfObject(target);
			
			if(subjectRoom == targetRoom)
			{
				_path.addWaypoint(target);
			}
			else
			{
				var roomPath:Array = getRoomPath(subjectRoom.id, targetRoom.id);
				var index:int = 0;
				
				while(roomPath.length-1 != index)
				{
					_path.addWaypoint((roomPath[index] as Room).getDoorToRoom(roomPath[index+1]));
					index++;
				}
				
				_path.addWaypoint(target);
			}
		}
		
		private function getRoomPath(start:int, target:int):Array
		{
			_start = start;
			
			_distance = new Array();
			_previous = new Array();
			_completed = new Array();
			_queue = new Array();
			
			// fill arrays
			for(var i:int = 0; i < _level.matrix.size; i++)
			{
				_distance[i] = INFINITY;
				_previous[i] = INFINITY;
				_completed[i] = false;
			}
			
			_distance[_start] = 0;
			
			_queue.push(_start);
			
			while(_queue.length != 0)
			{
				var u:int = getSmallestDistanceInQueue();
				
				if(u == target)
				{
					break;
				}
				
				if(_distance[u] == INFINITY)
					throw new Error("Pathfinding broke!");
				
				// check all neighbours
				for each (var neighbour:int in getNeighbours(u))
				{
					var newDistance:int = _distance[u] + 1;
					
					if(newDistance < _distance[neighbour])
					{
						_distance[neighbour] = newDistance;
						_previous[neighbour] = u;
					}
					
					if(!isInQueue(neighbour))
						_queue.push(neighbour);
				}
				
				// this node is done
				_completed[u] = true;
				_queue.splice(_queue.indexOf(u),1); 
			}
			
			// broken out of the loop, the target has been found!
			var path:Array = new Array();
			 
			while(u != _start)
			{
				path.push(_level.getRoom(u));
				u = _previous[u];
			}
			
			path.push(_level.getRoom(_start));
			path.reverse();
			
			return path;
		}

		private function getSmallestDistanceInQueue():int
		{
			var smallest:int = INFINITY;
			
			// loop through all nodes in queue
			for each (var node:int in _queue)
			{
				// if the smallest has not been set, get this node
				if (smallest == INFINITY)
					smallest = node;
				else
				{
					if (_distance[smallest] > _distance[node])
						smallest = node;
				}
			}
			
			return smallest;
		}
		
		private function getNeighbours(node:int):Array
		{
			return _level.matrix.getAdjectedNodes(node, _completed);
		}
		
		private function isInQueue(node:int):Boolean
		{
			for each(var i:int in _queue)
			{
				if(i == node)
					return true;
			}
			
			return false;
		}

		public function get path():Path
		{
			return _path;
		}

	}
}