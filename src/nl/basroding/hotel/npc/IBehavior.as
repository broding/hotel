package nl.basroding.hotel.npc
{
	import nl.basroding.hotel.Door;
	import nl.basroding.hotel.Npc;
	import nl.basroding.hotel.Room;
	import nl.basroding.hotel.events.IRoomListener;
	
	public interface IBehavior extends IRoomListener
	{
		function update():void;
		function onEnterRoom(room:Room):void;
	}
}