package nl.basroding.hotel.actor.body
{
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	
	public class AnimationFactory
	{
		public static function createStillAnimation():BodyAnimation
		{
			var animation:BodyAnimation = new BodyAnimation("still", 0, false);
			
			animation.addFrame(new BodyFrame(
				new BodyPartFrame(new FlxPoint(0,0), 0),
				new BodyPartFrame(new FlxPoint(0,0), 0),
				new BodyPartFrame(new FlxPoint(0,0), 0)
			));
			
			return animation;
		}
		
		public static function createWalkAnimation():BodyAnimation
		{
			var animation:BodyAnimation = new BodyAnimation("walk", 50, true);
			
			animation.addFrame(new BodyFrame(
				new BodyPartFrame(new FlxPoint(0,-1), 0),
				new BodyPartFrame(new FlxPoint(0,-1), 5),
				new BodyPartFrame(new FlxPoint(0,-1), 5)
			));
			
			animation.addFrame(new BodyFrame(
				new BodyPartFrame(new FlxPoint(0,-1), 0),
				new BodyPartFrame(new FlxPoint(0,-1), 6),
				new BodyPartFrame(new FlxPoint(0,-1), 6)
			));
			
			animation.addFrame(new BodyFrame(
				new BodyPartFrame(new FlxPoint(0,0), 0),
				new BodyPartFrame(new FlxPoint(0,0), 7),
				new BodyPartFrame(new FlxPoint(0,0), 7)
			));
			
			animation.addFrame(new BodyFrame(
				new BodyPartFrame(new FlxPoint(0,-1), 0),
				new BodyPartFrame(new FlxPoint(0,-1), 1),
				new BodyPartFrame(new FlxPoint(0,-1), 1)
			));
			
			animation.addFrame(new BodyFrame(
				new BodyPartFrame(new FlxPoint(0,-1), 0),
				new BodyPartFrame(new FlxPoint(0,-1), 2),
				new BodyPartFrame(new FlxPoint(0,-1), 2)
			));
			
			animation.addFrame(new BodyFrame(
				new BodyPartFrame(new FlxPoint(0,0), 0),
				new BodyPartFrame(new FlxPoint(0,0), 3),
				new BodyPartFrame(new FlxPoint(0,0), 3)
			));
			
			animation.addFrame(new BodyFrame(
				new BodyPartFrame(new FlxPoint(0,0), 0),
				new BodyPartFrame(new FlxPoint(0,0), 4),
				new BodyPartFrame(new FlxPoint(0,0), 4)
			));
			
			return animation;
		}
		
		public static function createDummy():BodyAnimation
		{
			var animation:BodyAnimation = new BodyAnimation("walk", 10);
			
			animation.addFrame(createBodyFrame());
			animation.addFrame(createBodyFrame());
			animation.addFrame(createBodyFrame());
			
			return animation;
			
		}
		
		private static function createBodyFrame():BodyFrame
		{
			var frame:BodyFrame = new BodyFrame(createBodyPartFrame(), createBodyPartFrame(), createBodyPartFrame());
			
			return frame;
		}
		
		private static function createBodyPartFrame(x:int = 0, y:int = 0, tile:uint = 0):BodyPartFrame
		{	
			return new BodyPartFrame(new FlxPoint(x, y), tile);
		}
	}
}