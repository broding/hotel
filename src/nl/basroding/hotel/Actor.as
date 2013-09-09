package nl.basroding.hotel
{
	import org.flixel.FlxSprite;

	public class Actor extends FlxSprite
	{
		protected const CRAWL_SPEED:int = 100;
		protected const WALK_SPEED:int = 140;
		protected const RUN_SPEED:int = 200;
		
		public function Actor()
		{
			this.makeGraphic(16, 16, 0xffffffff);
		}
		
		override public function update():void
		{
			super.update();
		
			this.velocity.y += 4;
		}
	}
}