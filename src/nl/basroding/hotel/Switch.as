package nl.basroding.hotel
{
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;

	public class Switch extends FlxSprite
	{
		private var _target:ISwitchTarget;
		
		public function Switch(x:int, y:int, target:ISwitchTarget)
		{
			_target = target;
			this.x = x;
			this.y = y;
			
			makeGraphic(8, 8, 0xffffffff);
		}
		
		public function toggle(activator:Actor):void
		{
			_target.toggleSwitch(this);
		}
	}
}