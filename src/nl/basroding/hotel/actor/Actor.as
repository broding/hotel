package nl.basroding.hotel.actor
{
	import nl.basroding.hotel.Door;
	import nl.basroding.hotel.Game;
	import nl.basroding.hotel.Room;
	import nl.basroding.hotel.actor.body.Body;
	import nl.basroding.hotel.actor.body.Skin;
	
	import org.flixel.FlxSprite;

	public class Actor extends FlxSprite
	{
		public static const CRAWL_SPEED:int = 10;
		public static const WALK_SPEED:int = 30;
		public static const RUN_SPEED:int = 60;
		
		protected var _room:Room;
		protected var _body:Body;
		
		public function Actor(x:int, y:int, skin:Skin, room:Room)
		{
			_body = new Body(skin);
			
			this.makeGraphic(16, 24, 0x00000000);
			
			this.room = room;
			this.x = x;
			this.y = y;
		}
		
		public function set room(value:Room):void
		{
			_room = value;
			_room.addActor(this);
		}
		
		public function getNaked():void
		{
			var skin:Skin = Game.skinManager.getSkinByName("naked");
			
			_body.swapCloths(skin);
		}

		override public function update():void
		{	
			if(velocity.x < 0)
				this.facing = LEFT;
			else if(velocity.x > 0)
				this.facing = RIGHT;
			
			this.velocity.y += 4;
			
			if(velocity.x != 0)
				_body.animation = Body.WALK_ANIMATION;
			else
				_body.animation = Body.STILL_ANIMATION;
			
			_body.update();
			
			super.update();
			
			for each(var child:FlxSprite in _body.members)
				child.update();
				
		}
		
		override public function postUpdate():void
		{
			super.postUpdate();
			
			_body.setActorPosition(x, y, facing);
		}
		
		override public function draw():void
		{
			super.draw();
			
			for each(var child:FlxSprite in _body.members)
				child.draw();
		}
		
		public function useDoor(door:Door):void
		{
			_room.removeActor(this);
			_room = door.targetRoom;
			_room.addActor(this);
			
			this.x = door.connectingDoor.x;
			this.y = door.connectingDoor.y + (door.height - this.height);
		}
		
		override public function kill():void
		{
			this.alive = false;
			this.velocity.x = 0;
			this._room.actorKilled(this);
		}

		public function get room():Room
		{
			return _room;
		}

		public function get skin():Skin
		{
			return _body.skin;
		}

		public function isNaked():Boolean
		{
			return _body.skinName == "naked";
		}
	}
}