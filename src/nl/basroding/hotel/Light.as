package nl.basroding.hotel
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	import org.flixel.FlxSprite;
	import org.flixel.plugin.photonstorm.FlxDisplay;
	import flash.geom.Point;

	public class Light extends FlxSprite
	{
		[Embed(source="../../../../assets/levels/light.png")] private var lightGraphic:Class;
		
		private var _room:Room;
		
		public function Light(room:Room, x:int, y:int)
		{
			loadGraphic(lightGraphic);
			
			_room = room;
			this.x = x - width/2;
			this.y = y - height/2;
			this.alpha = 0.75;
			
			var bitmapData:BitmapData = new BitmapData(width, height, true, 0x00000000);
			bitmapData.copyPixels(pixels, new Rectangle(0, room.y - this.y, width, height), new Point(0, room.y - this.y), null, null, true);
			this.pixels = bitmapData;
		}
	}
}