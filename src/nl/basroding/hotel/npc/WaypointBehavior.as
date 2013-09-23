package nl.basroding.hotel.npc
{
	import nl.basroding.hotel.*;
	import nl.basroding.hotel.events.RoomEvent;
	import nl.basroding.hotel.path.*;
	import nl.basroding.hotel.actor.Actor;
	
	import org.flixel.FlxObject;

	public class WaypointBehavior implements IBehavior
	{
		private var _npc:Npc;
		private var _route:Route;
		private var _currentWaypoint:IWaypoint;
		
		public function WaypointBehavior(npc:Npc, route:Route)
		{
			_npc = npc;
			_route = route;
			_route.start(_npc);
		}
		
		public function update():void
		{	
			if(!_route.completed)
			{
				if(_route.target.getPosition().x > _npc.x)
					_npc.velocity.x = Actor.WALK_SPEED;
				else
					_npc.velocity.x = -Actor.WALK_SPEED;
				
				if(_npc.overlaps(_route.target.getPosition()))
					if(_route.target.useWaypoint(_npc))
						_route.nextWaypoint();
			}
			else
				_npc.velocity.x = 0;
		}
		
		public function onActorKilledInRoom(event:RoomEvent):void
		{
			if(_npc.room.isLightOn())
				_npc.behavior = new PanicBehavior(_npc);
		}
		
		public function onLightSwitch(event:RoomEvent):void
		{
			if(_npc.room.hasDeadActor())
				_npc.behavior = new PanicBehavior(_npc);
		}
		
		public function onEnterRoom(room:Room):void
		{
			if(room.hasDeadActor() && room.isLightOn())
				_npc.behavior = new PanicBehavior(_npc);
		}
	}
}