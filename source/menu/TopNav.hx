package menu;

import flash.system.System;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
using flixel.util.FlxSpriteUtil;

import util.FileUtil;

import zerolib.util.ZMenu;

class TopNav extends ZMenu
{
    public var text:FlxText;
    
    var tween:FlxTween;

    public function new ()
    {
        super();

        interface_mode = ZMenuInterfaceMode.MOUSE;

        var _new = new MenuText(0, 0,"New",24);
		_new.callback = function() {
			FileUtil.newLevel();
		}
		add(_new);
		
		var load = new MenuText(0, 0,"Load",24);
		load.callback = function() {
			FileUtil.loadLevel();
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