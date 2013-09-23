package nl.basroding.hotel
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import nl.basroding.hotel.actor.Actor;

	public class GUIOverlay extends FlxGroup
	{
		private var _textCloud:TextCloud;
		
		public function GUIOverlay()
		{
			_textCloud = new TextCloud();
			_textCloud.visible = false;
			add(_textCloud);
		}
		
		public function showTextCloud(dialog:Dialog, actor:Actor):void
		{
			Game.pause = true;
			_textCloud.visible = true;
			_textCloud.x = actor.x;
			_textCloud.y = actor.y - 50;
		}
	}
}