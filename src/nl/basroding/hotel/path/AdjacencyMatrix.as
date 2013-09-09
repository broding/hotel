package nl.basroding.hotel.path
{
	import nl.basroding.hotel.Room;

	public class AdjacencyMatrix
	{
		private var _matrix:Array;
		private var _size:int;
		
		public function AdjacencyMatrix(size:int)
		{
			_size = size;
			
			_matrix = new Array();
			
			for(var i:int = 0; i < size; i++)
			{
				_matrix.push(new Array());
				
				for(var j:int = 0; j < size; j++)
				{
					_matrix[i].push(false);
				}
				
			}
		}

		public function setConnection(room1:Room, room2:Room, connect:Boolean = true):void
		{
			_matrix[room1.id][room2.id] = connect;
			_matrix[room2.id][room1.id] = connect;
		}
		
		public function print():void
		{
			for(var i:int = 0; i < _matrix.length; i++)
			{
				var row:String = new String();
				
				for(var j:int = 0; j < _matrix[i].length; j++)
				{
					row = row += (_matrix[i][j] ? "0" : "X") + ", ";
				}
				
				trace(row);
			}
		}
		
		public function getAdjectedNodes(node:int, completed:Array):Array
		{
			var adjected:Array = new Array();
			
			for(var i:int = 0; i < _matrix[node].length; i++)
			{
				if(_matrix[node][i] && !completed[i])
					adjected.push(i);
			}
			
			return adjected;
		}
		
		public function get size():int
		{
			return _size;
		}
	}
}