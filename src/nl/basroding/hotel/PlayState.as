package nl.basroding.hotel
{
	import com.greensock.events.LoaderEvent;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import net.pixelpracht.tmx.TmxMap;
	import net.pixelpracht.tmx.TmxObject;
	import net.pixelpracht.tmx.TmxObjectGroup;
	
	import nl.basroding.hotel.actor.Guard;
	import nl.basroding.hotel.actor.body.Body;
	import nl.basroding.hotel.actor.body.Skin;
	import nl.basroding.hotel.actor.body.SkinManager;
	import nl.basroding.hotel.npc.BehaviorFactory;
	import nl.basroding.hotel.npc.GuardBehavior;
	import nl.basroding.hotel.path.ConcreteWaypoint;
	
	import org.flixel.FlxCamera;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxRect;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxTilemap;

	public class PlayState extends FlxState
	{
		[Embed(source="../../../../assets/levels/tileset.png")] private var tilesetGraphic:Class;
		[Embed(source="../../../../assets/levels/shadows.png")] private var shadowsGraphic:Class;
		
		private var player:Player;
		private var collideMap:FlxTilemap;
		private var loaded:Boolean = false;
		private var level:Level;
		private var shadows:FlxTilemap;
		private var npcs:FlxGroup;
		private var debugDraw:FlxGroup;
		private var guiOverlay:GUIOverlay;
		private var camera:FlxCamera;
		
		public function PlayState()
		{
		}
		
		override public function create():void
		{
			camera = new FlxCamera(0, 0, 840/2, 525/2, 2);
			FlxG.addCamera(camera);
			FlxG.camera = camera;
			
			FlxG.visualDebug = false;
			FlxG.worldBounds = new FlxRect(0, 0, 2000, 2000);
			
			level = new Level();
			npcs = new FlxGroup();
			debugDraw = new FlxGroup();
			Game.debugGroup = debugDraw;
			Game.drawDebug = true;
			
			var skinManager:SkinManager = new SkinManager(function(event:LoaderEvent):void
			{
				var loader:URLLoader = new URLLoader(); 
				loader.addEventListener(Event.COMPLETE, onTmxLoaded); 
				loader.load(new URLRequest('levels/level1.tmx')); 
				
				Game.skinManager = skinManager;
				
				skinManager.addSkin(new Skin("player", "player", "player", "gray"));
				skinManager.addSkin(new Skin("guard", "guard", "guard", "gray"));
				skinManager.addSkin(new Skin("guest", "player", "player", "gray"));
				skinManager.addSkin(new Skin("naked", "player", "naked", "gray"));
			});
			
			skinManager.loadBodyPart(Body.HEAD, "player");
			skinManager.loadBodyPart(Body.HEAD, "guard");
			skinManager.loadBodyPart(Body.TORSO, "player");
			skinManager.loadBodyPart(Body.TORSO, "guard");
			skinManager.loadBodyPart(Body.TORSO, "naked");
			skinManager.loadBodyPart(Body.FEET, "gray");
			skinManager.startLoading();
		}
		
		override public function update():void
		{
			super.update();
			
			if(loaded)
			{
				FlxG.collide(player, collideMap);
				FlxG.collide(npcs, collideMap);
				FlxG.overlap(player, level.doors, player.collideDoorHandler);
				FlxG.overlap(player, npcs, player.collideNpcHandler);
				FlxG.overlap(player, level.switches, player.collideSwitchHandler);
				
				Game.update();
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
			var shadows:FlxTilemap = new FlxTilemap();
			//generate a CSV from the layer 'map' with all the tiles from the TileSet 'tiles'
			var mapCsv:String = tmx.getLayer('map').toCsv(tmx.getTileSet('tileset'));
			sprites.loadMap(mapCsv,tilesetGraphic, 16, 16);
			sprites.follow();
			add(sprites);
			
			var shadowCsv:String = tmx.getLayer('shadows').toCsv(tmx.getTileSet('shadows'));
			shadows.loadMap(shadowCsv,shadowsGraphic, 16, 16);
			add(shadows);
			
			collideMap = new FlxTilemap();
			mapCsv = tmx.getLayer('collisions').toCsv(tmx.getTileSet('tileset'));
			collideMap.loadMap(mapCsv, tilesetGraphic, 16, 16);
			
			// spawn objects
			var group:TmxObjectGroup = tmx.getObjectGroup('structure');
			for each(var object:TmxObject in group.objects)
				spawnObject(object);
				
			group = tmx.getObjectGroup('waypoints');
			for each(object in group.objects)
				spawnObject(object);
				
			group = tmx.getObjectGroup('switch');
			for each(object in group.objects)
				spawnObject(object);
				
			group = tmx.getObjectGroup('lights');
				for each(object in group.objects)
				spawnObject(object);
				
			// process level further
			Game.level = level;
			level.connectDoorsWithRooms();
			level.connectDoors();
			level.createAdjacencyMatrix();
				
			group = tmx.getObjectGroup('npc');
			for each(object in group.objects)
				spawnObject(object);
				
			// add all shadows
			for each(var room:Room in level.rooms.members)
				level.shadows.add(room.shadow);
				
			FlxG.worldBounds = sprites.getBounds();
			
			player = new Player(500, 336, level.getRoomOfPosition(500, 336));
			player.x = 500;
			player.y = 336;
			Game.player = player;
			
			FlxG.camera.follow(player, FlxCamera.STYLE_LOCKON);
			
			var lineSprite:FlxSprite = new FlxSprite(0, 0);
			lineSprite.width = 2000;
			lineSprite.height = 2000;
			Game.lineSprite = lineSprite;
			
			guiOverlay = new GUIOverlay();
			Game.guiOverlay = guiOverlay;
			
			add(level.doors);
			add(level.switches);
			add(npcs);
			add(player);
			add(level.lights);
			add(level.shadows);
			add(lineSprite);
			add(debugDraw);
			add(guiOverlay);
			
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
				case "light":
					var roomOfLight:Room = level.getRoomOfPosition(object.x, object.y);
					var light:Light = new Light(roomOfLight, object.x, object.y);
					level.addLight(light);
					break;
				case "room":
					var room:Room = new Room(object.x, object.y, object.width, object.height, object.custom["allowed"]);
					level.rooms.add(room);
					break;
				case "waypoint":
					var waypoint:ConcreteWaypoint = new ConcreteWaypoint(object.x, object.y, object.name);
					level.waypoints.add(waypoint);
					break;
				case "switch":
					var aSwitch:Switch = new Switch(object.x, object.y, level.getRoomOfPosition(object.x, object.y));
					level.switches.add(aSwitch);
					break;
				case "npc":
					var npc:Npc = new Npc(
						object.x,
						object.y,
						Game.skinManager.getSkinByName("guest"),
						level.getRoomOfPosition(object.x, object.y)
					);
					npc.behavior = BehaviorFactory.createBehavior(object.custom["type"], npc, level.createRoute(object.custom["waypoints"]));
					npcs.add(npc);
					break;
				case "guard":
					var guard:Guard = new Guard(
						object.x,
						object.y,
						level.getRoomOfPosition(object.x, object.y)
					);
					guard.behavior = new GuardBehavior(guard);
					npcs.add(guard);
					break;
			}
		}
	}
}