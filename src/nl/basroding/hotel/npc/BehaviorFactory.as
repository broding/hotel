package nl.basroding.hotel.npc
{
	import nl.basroding.hotel.Npc;
	import nl.basroding.hotel.path.Route;

	public class BehaviorFactory
	{
		public static function createBehavior(type:String, npc:Npc = null, route:Route = null):IBehavior
		{
			switch(type)
			{
				case "guest":
					return new WaypointBehavior(npc, route);
					break;
				case "panic":
					return new PanicBehavior(npc);
					break;
			}
			
			return new DeadBehavior();
		}
	}
}