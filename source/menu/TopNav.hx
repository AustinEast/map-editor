package menu;

import flash.system.System;
import flixel.addons.ui.FlxUIPopup;
import flixel.FlxG;
import flixel.addons.ui.FlxUISubState;

import util.FileUtil;
import menu.*;

import zerolib.ZState;

class TopNav extends FlxUISubState
{
	override public function create() 
	{
		_xml_id = "top_nav";
		super.create();
	}
	
	public override function getRequest(id:String, target:Dynamic, data:Dynamic, ?params:Array<Dynamic>):Dynamic
	{
		return null;
	}	
	
	public override function getEvent(id:String, target:Dynamic, data:Dynamic, ?params:Array<Dynamic>):Void
	{
		if (params != null)
		{
			switch (id)
			{
				case "click_button":
					switch (Std.string(params[0]))
					{
						//case "back": FlxG.switchState(new State_Title());
						case "new":var popup:Popup_New = new Popup_New(); //create the popup
									 openSubState(popup);				  //show the popup
						case "quit": System.exit(0);			
					}
			}
		}
	}
}
/*
class TopNav extends ZMenu
{
    var tween:FlxTween;

    public function new ()
    {
        super();

        interface_mode = ZMenuInterfaceMode.MOUSE;

        var _new = new MenuText(0, 0,"New",24);
		_new.callback = function() {
			ZState.instance.openSubState(new Popup("New Map"));
			// Open "new level" popup
			//FileUtil.newLevel();
		}
		add(_new);
		
		var load = new MenuText(0, 0,"Load",24);
		load.callback = function() {
			FileUtil.loadLevelNativeDialog();
		}
		add(load);

		var save = new MenuText(0, 0,"Save",24);
		save.callback = function() {
			trace(FileUtil.listLevels());
		}
		add(save);

        var play = new MenuText(0, 0,"Play",24);
		play.callback = function() {
			
		}
		add(play);

		#if !web
		var quit = new MenuText(0, 0,"Quit",24);
		quit.callback = function() {
			System.exit(0);
		}
		add(quit);
		#end

		init();
		arrange_horizontally(FlxPoint.get(0, 0), 24, 8);

		var pos:FlxPoint = selected_item.get_center();
		cursor = new FlxSprite(pos.x,pos.y);
		cursor.makeGraphic(2, 2, FlxColor.TRANSPARENT);
    }
}
*/