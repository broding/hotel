package nl.basroding.hotel.actor
{
	import nl.basroding.hotel.Game;
	import nl.basroding.hotel.Npc;
	import nl.basroding.hotel.Room;
	import nl.basroding.hotel.npc.DeadBehavior;
	
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	import nl.basroding.hotel.actor.body.Body;

	public class Guard extends Npc
	{
		private var _originalPosition:FlxPoint;
		
		public function Guard(x:int, y:int, room:Room)
		{
			super(x, y, Game.skinManager.getSkinByName("guard"), room);
			
			_originalPosition = new FlxPoint(x, y);
			
			behavior = new DeadBehavior();
		}
		
		public function shootAt(actor:Actor):void
		{
			if(actor.x > this.x)
				facing = FlxObject.RIGHT;
			else 
				facing = FlxObject.LEFT;
			
			actor.kill();
			
			Game.guiOverlay.showTextCloud(null, this);
			
		}

		public function get originalPosition():FlxPoint
		{
			return _originalPosition;
		}

	}
}