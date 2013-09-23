package nl.basroding.hotel.actor.body
{
	public class BodyAnimation
	{
		private var _name:String;
		private var _frames:Array;
		private var _framerate:uint;
		private var _loop:Boolean;
		
		public function BodyAnimation(name:String, framerate:uint = 10, loop:Boolean = true)
		{
			_name = name;
			_framerate = framerate;
			_loop = loop;
			_frames = new Array();
		}
		
		public function addFrame(frame:BodyFrame):void
		{	
			_frames.push(frame);
		}
		
		public function getFrameOfIndex(index:uint):BodyFrame
		{
			return _frames[index];
		}
		
		public function get length():uint
		{
			return _frames.length;
		}

		public function get framerate():uint
		{
			return _framerate;
		}

		public function get loop():Boolean
		{
			return _loop;
		}

		public function set loop(value:Boolean):void
		{
			_loop = value;
		}

		public function get name():String
		{
			return _name;
		}


	}
}