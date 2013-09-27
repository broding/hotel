package nl.basroding.hotel.actor.body
{
	
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;

	public class Body extends FlxGroup
	{
		public static const HEAD:int = 0;
		public static const TORSO:int = 1;
		public static const FEET:int = 2;
		
		public static const STILL_ANIMATION = AnimationFactory.createStillAnimation();
		public static const WALK_ANIMATION = AnimationFactory.createWalkAnimation();
		
		private var _skin:Skin;
		private var _animation:BodyAnimation;
		
		private var _frameIndex:uint;
		private var _frameTime:Number;
		
		private var _actorX:int;
		private var _actorY:int;
		
		private var _head:Head;
		private var _torso:Torso;
		private var _feet:Feet;
		
		private var _skinName:String;
		
		public function Body(skin:Skin)
		{
			_skin = skin;
			_skinName = skin.name;
			
			add(_head = new Head(skin));
			add(_torso = new Torso(skin));
			add(_feet = new Feet(skin));
			
			_frameIndex = 0;
			_frameTime = 0;
			_animation = AnimationFactory.createDummy();
		}
		
		public function get skinName():String
		{
			return _skinName;
		}

		override public function update():void
		{
			if(_animation == null)
				return;
			
			_frameTime += FlxG.elapsed;
			
			if(_frameTime >= _animation.framerate / 1000)
			{
				if(_frameIndex+1 >= _animation.length)
				{
					if(_animation.loop)
						_frameIndex = 0;
				}		
				else
				{	
					_frameIndex++;
				}
				
				_frameTime = 0;
				setFrame(animation.getFrameOfIndex(_frameIndex));
			}
			
			super.update();
		}
		
		public function setActorPosition(x:int, y:int, facing:uint):void
		{
			_head.setActorPosition(x, y, facing);
			_torso.setActorPosition(x, y, facing);
			_feet.setActorPosition(x, y, facing);
		}
		
		private function setFrame(frame:BodyFrame):void
		{
			_head.bodyFrame = frame.head;
			_torso.bodyFrame = frame.torso;
			_feet.bodyFrame = frame.feet;
		}
		
		public function get skin():Skin
		{
			return _skin;
		}
		
		public function swapCloths(skin:Skin):void
		{
			_torso.loadBitmapData(skin.torsoBitmapData);
			_feet.loadBitmapData(skin.feetBitmapData);
			
			_skinName = skin.name;
		}

		public function get animation():BodyAnimation
		{
			return _animation;
		}

		public function set animation(value:BodyAnimation):void
		{
			if(_animation == value)
				return;
			
			_animation = value;
			
			_frameIndex = 0;
			_frameTime = 0;
			
			setFrame(animation.getFrameOfIndex(_frameIndex));
		}
		
		public function get cameraTarget():FlxObject
		{
			return this._torso;
		}
	}
}