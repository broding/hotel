package nl.basroding.hotel.path
{
	import nl.basroding.hotel.actor.Actor;
	import nl.basroding.hotel.util.Vector2;
	
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;

	public class ConcreteWaypoint extends FlxObject implements IWaypoint
	{
		private var _id:String;
		
		public function ConcreteWaypoint(x:int, y:int, id:String = "")
		{
			this.x = x;
			this.y = y;
			this.width = 32;
			this.height = 64;
			this._id = id;
		}
		
		public function getPosition():FlxObject
		{
			return this;
		}
		
		public function useWaypoint(actor:Actor):Boolean
		{
			return true;
		}
		
		public function get id():String
		{
			return _id;
		}
	}
}