package nl.basroding.hotel.npc
{
	import nl.basroding.hotel.actor.Guard;
	import nl.basroding.hotel.Room;
	import nl.basroding.hotel.path.IWaypoint;

	public interface IGuardBehavior extends IBehavior
	{
		function onHelpRequest(guard:Guard, room:Room, subject:IWaypoint):void;
	}
}