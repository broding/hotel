package nl.basroding.hotel.events
{
	public interface IRoomListener
	{
		function onActorKilledInRoom(event:RoomEvent):void;
		function onLightSwitch(event:RoomEvent):void;
	}
}