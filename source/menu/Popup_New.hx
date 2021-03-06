package menu;

import flixel.addons.ui.FlxUIPopup;
import flixel.addons.ui.FlxUI;

import util.FileUtil;

class Popup_New extends FlxUIPopup
{
	public override function create():Void
	{
		_xml_id = "popup_new";
		super.create();
	}
	
	public override function getEvent(id:String, target:Dynamic, data:Dynamic, ?params:Array<Dynamic>):Void 
	{
		if (params != null)
		{
			if (id == "click_button"){
				switch (Std.int(params[0]))
				{
					case 0: create_level();
					case 1: close();
				}
			}
		}
	}

	private function create_level():Void {
		FileUtil.newLevel(
			_ui.getFlxText("name").text,
			Std.parseInt(_ui.getFlxText("width_in_tiles").text),
			Std.parseInt(_ui.getFlxText("height_in_tiles").text),
			Std.parseInt(_ui.getFlxText("tile_width").text),
			Std.parseInt(_ui.getFlxText("tile_height").text)
		);
		close();
	}
}