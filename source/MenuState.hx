package;

import flixel.util.FlxColor;
import flash.system.System;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import sys.FileSystem;
import sys.io.File;

import menu.MenuText;
import util.Bindings;

import zerolib.util.ZMenu;
import zerolib.managers.ZControlsManager;


class MenuState extends FlxState
{
	var menu:ZMenu;

	override public function create():Void
	{
		super.create();

		if (Reg.c == null) Reg.c = new ZControlsManager();
		add(Reg.c);
		new Bindings(Reg.c);

		menu = new ZMenu();
		menu.controls_manager = Reg.c;
		
		var play = new MenuText(0, 0,"Play",24);
		play.callback = function() {
			
		}
		menu.add(play);

		var edit = new MenuText(0, 0,"Edit",24);
		edit.callback = function() {
			trace(FileSystem.readDirectory(FileSystem.absolutePath(Reg.levels_path)));
		}
		menu.add(edit);

		#if !web
		var quit = new MenuText(0, 0,"Quit",24);
		quit.callback = function() {
			System.exit(0);
		}
		menu.add(quit);
		#end

		menu.init();
		menu.arrange_vertically(FlxPoint.get(0, 120), 16, 0);

		var pos:FlxPoint = menu.selected_item.get_center();
		menu.cursor = new FlxSprite(pos.x,pos.y);
		menu.cursor.makeGraphic(2, 2, FlxColor.TRANSPARENT);
		add(menu.cursor);

		add(menu);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		if (Reg.c.anyJustPressed(Button.START) && menu.selected_item != null) 
		{
			menu.selected_item.callback();
		}
	}
}
