package nl.basroding.hotel.actor.body
{
	import com.greensock.*;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.*;
	import com.greensock.loading.display.*;
	
	import flash.display.BitmapData;
	
	import flashx.textLayout.elements.BreakElement;
	

	public class SkinManager
	{
		private var _skins:Array;
		private var _loaderQueue:LoaderMax;
		private var _onCompleteCallback:Function;
		
		private var _heads:Array;
		private var _torsos:Array;
		private var _feet:Array;
		
		public function SkinManager(onCompleteCallback:Function)
		{
			_skins = new Array();
			_heads = new Array();
			_torsos = new Array();
			_feet = new Array();
			
			_loaderQueue = new LoaderMax({name:"skinQueue", onError:onLoadingError});
			_loaderQueue.addEventListener(LoaderEvent.COMPLETE, onCompleteCallback);
			_loaderQueue.addEventListener(LoaderEvent.CHILD_COMPLETE, onChildComplete);
		}
		
		private function onChildComplete(event:LoaderEvent):void
		{
			var loader:ImageLoader = event.target as ImageLoader;
			
			switch(loader.vars["part"])
			{
				case Body.HEAD:
					_heads[loader.vars["name"]] = event.target.rawContent.bitmapData;
					break;
				case Body.TORSO:
					_torsos[loader.vars["name"]] = event.target.rawContent.bitmapData;
					break;
				case Body.FEET:
					_feet[loader.vars["name"]] = event.target.rawContent.bitmapData;
					break;
			}
		}
		
		private function onLoadingError(event:LoaderEvent):void
		{
			trace("progress: " + event.target.progress);
		}
		
		public function getSkinByName(name:String):Skin
		{
			for each(var skin:Skin in _skins)
			{
				if(skin.name == name)
					return skin;
			}
			
			throw new Error("Skin not found");
		}
		
		public function startLoading():void
		{
			_loaderQueue.load();
		}
		
		public function loadBodyPart(part:int, name:String):void
		{
			var dir:String;
			
			switch(part)
			{
				case Body.HEAD:
					dir = "heads";
					break;
				case Body.TORSO:
					dir = "torsos";
					break;
				case Body.FEET:
					dir = "feet";
					break;
			}
			
			_loaderQueue.append(new ImageLoader("skins/" + dir + "/" + name + ".png", {name:name, part:part}));
		}
		
		internal function getBitmapData(type:int, name:String):BitmapData
		{
			var array:Array;
			
			switch(type)
			{
				case Body.HEAD:
					array = _heads;
					break;
				case Body.TORSO:
					array = _torsos;
					break;
				case Body.FEET:
					array = _feet;
					break;
			}
			
			if(array[name] == null)
				throw new Error("Bitmapdata for skin not found");
			else
				return array[name];
		}
		
		public function addSkin(skin:Skin):void
		{
			_skins.push(skin);
		}

		public function get skins():Array
		{
			return _skins;
		}

	}
}