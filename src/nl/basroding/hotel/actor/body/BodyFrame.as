package nl.basroding.hotel.actor.body
{

	public class BodyFrame
	{
		private var _head:BodyPartFrame;
		private var _torso:BodyPartFrame;
		private var _feet:BodyPartFrame;
		
		public function BodyFrame(head:BodyPartFrame, torso:BodyPartFrame, feet:BodyPartFrame)
		{
			_head = head;
			_torso = torso;
			_feet = feet;
		}

		public function get head():BodyPartFrame
		{
			return _head;
		}

		public function get torso():BodyPartFrame
		{
			return _torso;
		}

		public function get feet():BodyPartFrame
		{
			return _feet;
		}


	}
}