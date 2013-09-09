package nl.basroding.hotel.path
{
	import nl.basroding.hotel.util.Vector2;
	
	import org.flixel.FlxObject;

	public class ConcreteWaypoint extends FlxObject implements IWaypoint
	{
		private var _id:String;
		
		public function ConcreteWaypoint(x:int, y:int, id:String)
		{
			this.x = x;
			this.y = y;
			this.width = 16;
			this.height = 16;
			this._id = id;
		}
		
		public function getWaypoint():Vector2
		{
			return new Vector2(x, y);
		}
		
		public function get id():String
		{
			return _id;
		}
	}
}