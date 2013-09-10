package nl.basroding.hotel.npc
{
	import nl.basroding.hotel.*;
	import nl.basroding.hotel.events.RoomEvent;
	import nl.basroding.hotel.path.*;
	
	import org.flixel.FlxObject;

	public class WaypointBehavior implements IBehavior
	{
		private var _npc:Npc;
		private var _route:Route;
		private var _path:Path;
		private var _target:FlxObject;
		private var _currentWaypoint:FlxObject;
		
		public function WaypointBehavior(npc:Npc, route:Route)
		{
			_npc = npc;
			_route = route;
		}
		
		public function update():void
		{	
			if(_currentWaypoint == null)
				setWaypoint(_route.target);
			
			if(_target != null)
			{
				if(_target.x > _npc.x)
					_npc.velocity.x = Actor.WALK_SPEED;
				else
					_npc.velocity.x = -Actor.WALK_SPEED;
			}
			
			if(_npc.overlaps(_currentWaypoint))
				setWaypoint(_route.nextTarget());
			
			if(_npc.overlaps(_target))
			{
				if(_target is Door)
					useDoor(_target as Door);
				else if(_target is Switch)
					useSwitch(_target as Switch);
			}
		}
		
		private function setWaypoint(waypoint:FlxObject):void
		{
			_currentWaypoint = waypoint;
			_path = Game.generatePath(_npc, _currentWaypoint as FlxObject);
			_target = _path.target;
		}
		
		private function useDoor(door:Door):void
		{
			if(door == _path.target)
			{
				_npc.useDoor(door);
				_target = _path.nextTarget();
			}
		}
		
		private function useSwitch(mySwitch:Switch):void
		{
			mySwitch.toggle(_npc);
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