package nl.basroding.hotel.actor.body
{

	public class Torso extends BodyPart
	{
		public function Torso(skin:Skin)
		{
			super(skin, skin.torsoBitmapData, 16, 6, 0, 16);
		}
	}
}