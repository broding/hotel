package nl.basroding.hotel.npc
{
	import nl.basroding.hotel.actor.*;
	import nl.basroding.hotel.path.Route;

	public class GuardWaypointBehavior extends GuardBehavior
	{
		protected var _route:Route;
		
		public function GuardWaypointBehavior(guard:Guard, route:Route)
		{
			super(guard);
			
			_route = route;
			_route.start(_guard);
		}
		
		override public function update():void
		{
			if(!_route.completed)
			{
				if(_route.target.getPosition().x > _guard.x)
					_guard.velocity.x = Actor.WALK_SPEED;
				else
					_guard.velocity.x = -Actor.WALK_SPEED;
				
				if(_guard.overlaps(_route.target.getPosition()))
					if(_route.target.useWaypoint(_guard))
						_route.nextWaypoint();
			}
			else
				_guard.velocity.x = 0;
		}
	}
}