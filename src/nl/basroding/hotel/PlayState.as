package nl.basroding.hotel
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import net.pixelpracht.tmx.*;
	
	import nl.basroding.hotel.npc.BehaviorFactory;
	import nl.basroding.hotel.path.AdjacencyMatrix;
	import nl.basroding.hotel.path.ConcreteWaypoint;
	
	import org.flixel.*;
	import org.flixel.system.FlxTile;

	public class PlayState extends FlxState
	{
		[Embed(source="assets/tileset.png")] private var ImgTiles:Class;
		
		private var fpsText:FlxText;
		private var player:Player;
		private var collideMap:FlxTilemap;
		private var loaded:Boolean = false;
		private var level:Level;
		private var npcs:FlxGroup;
		
		public function PlayState()
		{
		}
		
		override public function create():void
		{
			var loader:URLLoader = new URLLoader(); 
			loader.addEventListener(Event.COMPLETE, onTmxLoaded); 
			loader.load(new URLRequest('levels/level1.tmx')); 
			
			FlxG.visualDebug = false;
			FlxG.worldBounds = new FlxRect(0, 0, 2000, 2000);
			
			level = new Level();
			npcs = new FlxGroup();
		}
		
		override public function update():void
		{
			super.update();
			
			if(loaded)
			{
				fpsText.text = "FPS: " + 1 / FlxG.elapsed;
				FlxG.collide(player, collideMap);
				FlxG.collide(npcs, collideMap);
				FlxG.overlap(player, level.doors, player.collideDoorHandler);
				FlxG.overlap(npcs, level.doors, collideNpcDoorHandler);
			}
		}
		
		private function onTmxLoaded(e:Event):void
		{
			var xml:XML = new XML(e.target.data);
			var tmx:TmxMap = new TmxMap(xml);
			loadStateFromTmx(tmx);
		}
		
		private function loadStateFromTmx(tmx:TmxMap):void
		{	
			//Basic level structure
			var sprites:FlxTilemap = new FlxTilemap();
			//generate a CSV from the layer 'map' with all the tiles from the TileSet 'tiles'
			var mapCsv:String = tmx.getLayer('map').toCsv(tmx.getTileSet('tileset'));
			sprites.loadMap(mapCsv,ImgTiles, 16, 16);
			sprites.follow();
			add(sprites);
			
			collideMap = new FlxTilemap();
			mapCsv = tmx.getLayer('collisions').toCsv(tmx.getTileSet('tileset'));
			collideMap.loadMap(mapCsv, ImgTiles, 16, 16);
			
			// spawn objects
			var group:TmxObjectGroup = tmx.getObjectGroup('structure');
			for each(var object:TmxObject in group.objects)
				spawnObject(object);
				
			group = tmx.getObjectGroup('waypoints');
			for each(var object:TmxObject in group.objects)
				spawnObject(object);
				
			// process level further
			Game.level = level;
			level.connectDoorsWithRooms();
			level.connectDoors();
			level.createAdjacencyMatrix();
				
			group = tmx.getObjectGroup('npc');
			for each(var object:TmxObject in group.objects)
				spawnObject(object);
				
			
			FlxG.worldBounds = sprites.getBounds();
			
			player = new Player();
			player.x = 500;
			player.y = 200;
			
			FlxG.camera.scroll.x = 300;
			FlxG.camera.bounds = sprites.getBounds();
			FlxG.camera.follow(player, FlxCamera.STYLE_PLATFORMER);
		
			fpsText = new FlxText(10, 10, 300, "FPS: 0");
			fpsText.scrollFactor.x = 0;
			fpsText.scrollFactor.y = 0;
			
			add(level.doors);
			add(npcs);
			add(player);
			add(fpsText);
			
			loaded = true;
		}
		
		private function spawnObject(object:TmxObject):void
		{
			switch(object.type)
			{
				case "door":
					var door:Door = new Door(object.x, object.y, object.custom["id"], object.custom["connecting"]);
					level.doors.add(door);
					break;
				case "room":
					var room:Room = new Room(object.x, object.y, object.width, object.height);
					level.rooms.add(room);
					break;
				case "waypoint":
					var waypoint:ConcreteWaypoint = new ConcreteWaypoint(object.x, object.y, object.name);
					level.waypoints.add(waypoint);
					break;
				case "npc":
					var npc:Npc = new Npc(level.createRoute(object.custom["waypoints"]), BehaviorFactory.createBehavior(object.custom["type"]));
					npc.x = object.x;
					npc.y = object.y;
					npcs.add(npc);
					break;
			}
		}
		
		public function collideNpcDoorHandler(npc:Npc, door:Door):void
		{
			npc.collideDoor(door);
		}
	}
}