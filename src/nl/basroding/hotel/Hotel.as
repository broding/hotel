package nl.basroding.hotel
{
	import org.flixel.*;
	[SWF(width="840", height="525", backgroundColor="#ffffff")]
	
	public class Hotel extends FlxGame
	{
		public function Hotel()
		{
			super(840/2, 525/2, PlayState, 1, 30, 30);
		}
	}
}