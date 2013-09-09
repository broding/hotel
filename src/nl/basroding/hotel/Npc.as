package nl.basroding.hotel
{
	import net.pixelpracht.tmx.TmxPropertySet;
	
	import nl.basroding.hotel.npc.IBehavior;
	import nl.basroding.hotel.path.IWaypoint;
	import nl.basroding.hotel.path.Path;
	import nl.basroding.hotel.path.Route;
	
	import org.flixel.FlxObject;

	public class Npc extends Actor
	{
		private var _route:Route;
		private var _behavior:IBehavior;
		
		private var _currentWaypoint:FlxObject;
		private var _moving:Boolean;
		private var _path:Path;
		
		private var _target:FlxObject;
		
		public function Npc(route:Route, behavior:IBehavior)
		{
			_route = route;
			_behavior = behavior;
			
			this.makeGraphic(16, 16, 0xff5500ff);
		}
		
		override public function update():void
		{
			super.update();
			
			if(_currentWaypoint == null)
			{
				_currentWaypoint = _route.target;
				_path = Game.generatePath(this, _currentWaypoint as FlxObject);
				_target = _path.target;
			}
			
			if(_target != null)
			{
				if(_target.x > this.x)
					this.velocity.x = WALK_SPEED;
				else
					this.velocity.x = -WALK_SPEED;
			}
			
			if(this.overlaps(_currentWaypoint))
			{
				_currentWaypoint = _route.nextTarget();
				_path = Game.generatePath(this, _currentWaypoint as FlxObject);
				_target = _path.target;
			}
		}
		
		public function collideDoor(door:Door):void
		{
			if(door == _path.target)
			{
				this.x = door.connectingDoor.x;
				this.y = door.connectingDoor.y + (door.connectingDoor.height - this.height);
				_target = _path.nextTarget();
			}
		}
	}
}