package nl.basroding.hotel.events
{
	import nl.basroding.hotel.Actor;
	import nl.basroding.hotel.Switch;

	public class RoomEvent
	{
		public var killedActor:Actor;
		public var changedSwitch:Switch;
		public var switchOn:Boolean;
		
		public function RoomEvent()
		{
		}
	}
}