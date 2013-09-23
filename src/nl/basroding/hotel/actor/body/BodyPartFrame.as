package nl.basroding.hotel.actor.body
{
	import org.flixel.FlxPoint;

	public class BodyPartFrame
	{
		private var _position:FlxPoint;
		private var _tile:uint;
		
		public function BodyPartFrame(position:FlxPoint, tile:uint)
		{
			_position = position;
			_tile = tile;
		}

		public function get position():FlxPoint
		{
			return _position;
		}

		public function get tile():uint
		{
			return _tile;
		}


	}
}