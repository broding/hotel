package nl.basroding.hotel.npc
{
	import nl.basroding.hotel.actor.Actor;
	import nl.basroding.hotel.Game;
	import nl.basroding.hotel.actor.Guard;
	import nl.basroding.hotel.Room;
	import nl.basroding.hotel.events.RoomEvent;
	import nl.basroding.hotel.path.ConcreteWaypoint;
	import nl.basroding.hotel.path.IWaypoint;
	import nl.basroding.hotel.path.Route;
	
	import org.flixel.FlxObject;

	public class GuardBehavior implements IGuardBehavior
	{	
		protected var _guard:Guard;
		protected var _alertLevel:int;
		
		public function GuardBehavior(guard:Guard)
		{
			_guard = guard;
		}
		
		public function onActorKilledInRoom(event:RoomEvent):void
		{
			if(_guard.room.isLightOn())
				_guard.shootAt(Game.player);
		}
		
		public function onLightSwitch(event:RoomEvent):void
		{
			if(!event.switchOn)
			{
				var route:Route = new Route(false, returnToGuardBehavior);
				route.addWaypoint(event.changedSwitch);
				route.addWaypoint(new ConcreteWaypoint(_guard.originalPosition.x, _guard.originalPosition.y));
				
				_guard.behavior = new GuardLightsBehavior(_guard, route);
			}
		}
		
		private function returnToGuardBehavior():void
		{
			_guard.behavior = new GuardBehavior(_guard);
			_guard.velocity.x = 0;
		}
		
		public function onEnterRoom(room:Room):void
		{
		}
		
		public function onHelpRequest(guard:Guard, room:Room, subject:IWaypoint):void
		{
			if(_guard.room.hasDoorToRoom(room))
			{
				var route:Route = new Route(false);
				route.addWaypoint(subject);
				
				_guard.behavior = new GuardWaypointBehavior(_guard, route);
			}
		}
		
		public function update():void
		{
		}
		
	}
}