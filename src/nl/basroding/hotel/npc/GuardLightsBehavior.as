package nl.basroding.hotel.npc
{
	import nl.basroding.hotel.actor.Guard;
	import nl.basroding.hotel.events.RoomEvent;
	import nl.basroding.hotel.path.Route;
	import nl.basroding.hotel.path.ConcreteWaypoint;

	public class GuardLightsBehavior extends GuardWaypointBehavior
	{
		public function GuardLightsBehavior(guard:Guard, route:Route)
		{
			super(guard, route);
		}
		
		override public function onLightSwitch(event:RoomEvent):void
		{
			if(event.switchOn)
			{
				var route:Route = new Route(false, _route.callback);
				route.addWaypoint(new ConcreteWaypoint(_guard.originalPosition.x, _guard.originalPosition.y));
				
				_guard.behavior = new GuardWaypointBehavior(_guard, route);
			}
		}
	}
}