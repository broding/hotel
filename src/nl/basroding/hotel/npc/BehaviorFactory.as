package nl.basroding.hotel.npc
{
	public class BehaviorFactory
	{
		public static function createBehavior(type:String):IBehavior
		{
			switch(type)
			{
				case "guest":
					return new GuestBehavior();
			}
			
			return new GuestBehavior();
		}
	}
}