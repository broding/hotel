package nl.basroding.hotel
{
	import nl.basroding.hotel.path.IWaypoint;
	
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import nl.basroding.hotel.actor.Actor;

	public class Switch extends FlxSprite implements IWaypoint
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
		
		public function getPosition():FlxObject
		{
			return this;
		}
		
		public function useWaypoint(actor:Actor):Boolean
		{
			this.toggle(actor);
			
			return true;
		}
		
	}
}