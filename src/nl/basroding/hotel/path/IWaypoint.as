package nl.basroding.hotel.path
{
	import nl.basroding.hotel.actor.Actor;
	import nl.basroding.hotel.util.Vector2;
	
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	
	public interface IWaypoint
	{
		/** Returns the position of the waypoint. This is used to check if there is an overlap with the user of the waypoint
		 */
		function getPosition():FlxObject;
		
		/**
		 * This function is called whenever the implementor of the IWaypoint is activated. Returns a boolean whether is actually has
		 * been activated or not. If return TRUE, then the next waypoint in the path will be searched
		 */
		function useWaypoint(actor:Actor):Boolean;
	}
}