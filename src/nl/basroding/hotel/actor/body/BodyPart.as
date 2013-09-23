package nl.basroding.hotel.actor.body
{
	
	import flash.display.BitmapData;
	
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;

	internal class BodyPart extends FlxSprite
	{
		protected var _skin:Skin;
		protected var _bodyFrame:BodyPartFrame;
		
		protected var _xOffset:int;
		protected var _yOffset:int;
		
		protected var _actorX:int;
		protected var _actorY:int;
		
		public function BodyPart(skin:Skin, bitmap:BitmapData, width:int, height:int, offsetX:int, offsetY:int)
		{
			_skin = skin;
			
			_pixels = FlxG.addBitmapFromBitmapData(bitmap, true);
			this.flipped = _pixels.width>>1;
			
			this.width = _pixels.width;
			this.height = _pixels.height;
			this.frameWidth = width;
			this.frameHeight = height;
			resetHelpers();
			
			_xOffset = offsetX;
			_yOffset = offsetY;
		}
		
		public function setActorPosition(x:int, y:int, facing:uint):void
		{
			_actorX = x;
			_actorY = y;
			this.facing = facing;
			
			updatePosition();
		}

		public function get bodyFrame():BodyPartFrame
		{
			return _bodyFrame;
		}

		public function set bodyFrame(value:BodyPartFrame):void
		{
			_bodyFrame = value;
			this.frame = _bodyFrame.tile;
		}
		
		private function updatePosition():void
		{
			x = _actorX + _xOffset + (_bodyFrame != null ? _bodyFrame.position.x : 0)
			y = _actorY + _yOffset + (_bodyFrame != null ? _bodyFrame.position.y : 0)
		}

	}
}