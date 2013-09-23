package nl.basroding.hotel
{
	import flashx.textLayout.accessibility.TextAccImpl;
	
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;

	public class TextCloud extends FlxGroup
	{
		private var _x:int;
		private var _y:int;
		
		private var _text:String;
		private var _background:FlxSprite;
		private var _textSprite:FlxText;
		
		public function TextCloud()
		{
			_text = "hallo";
			_background = new FlxSprite();
			_background.makeGraphic(100, 30, 0xffff0000);
			_textSprite = new FlxText(10, 10, 300, _text);
			
			add(_background);
			add(_textSprite);
		}

		public function get x():int
		{
			return _x;
		}

		public function set x(value:int):void
		{
			_x = value;
			_background.x = _x;
			_textSprite.x = _x + 5;
		}

		public function get y():int
		{
			return _y;
		}

		public function set y(value:int):void
		{
			_y = value;
			_background.y = _y;
			_textSprite.y = _y + 5;
		}


	}
}