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

import menu.*;
import util.*;

import zerolib.ZState;
import zerolib.util.ZMenu;
import zerolib.managers.ZControlsManager;


class MenuState extends ZState
{
	var menu:ZMenu;

	override public function create():Void
	{
		super.create();

		if (Reg.c == null) Reg.c = new ZControlsManager();
		add(Reg.c);
		new Bindings(Reg.c);

		FlxG.mouse.visible = true;

		var topNav:TopNav = new TopNav();
		add(topNav.cursor);
		add(topNav);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		/*if (Reg.c.anyJustPressed(Button.START) && menu.selected_item != null) 
		{
			menu.selected_item.callback();
		}*/
	}
}
