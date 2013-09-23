package nl.basroding.hotel.actor.body
{
	import flash.display.BitmapData;
	
	import org.flixel.FlxSprite;
	import nl.basroding.hotel.Game;

	public class Skin
	{
		private var _headBitmapData:BitmapData;
		private var _torsoBitmapData:BitmapData;
		private var _feetBitmapData:BitmapData;
		
		private var _color:uint;
		private var _name:String;
		
		public function Skin(name:String, head:String, torso:String, feet:String)
		{
			_name = name;
			_color = 0xffffffff;
			
			_headBitmapData = Game.skinManager.getBitmapData(Body.HEAD, head);
			_torsoBitmapData = Game.skinManager.getBitmapData(Body.TORSO, torso);
			_feetBitmapData = Game.skinManager.getBitmapData(Body.FEET, feet);
		}

		public function get color():uint
		{
			return _color;
		}
		
		public function toString():String
		{
			return _name;
		}

		public function get name():String
		{
			return _name;
		}

		public function get headBitmapData():BitmapData
		{
			return _headBitmapData;
		}

		public function get torsoBitmapData():BitmapData
		{
			return _torsoBitmapData;
		}

		public function get feetBitmapData():BitmapData
		{
			return _feetBitmapData;
		}


	}
}