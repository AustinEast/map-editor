package;

import flixel.FlxG;

import menu.*;
import util.*;

import zerolib.ZState;
import zerolib.managers.ZControlsManager;


class DebugState extends ZState
{

	override public function create():Void
	{
		super.create();

		FlxG.camera.bgColor = 0xff45283c;

		if (Reg.c == null) Reg.c = new ZControlsManager();
		add(Reg.c);
		new Bindings(Reg.c);

		FlxG.mouse.visible = true;
		persistentUpdate = true;

		openSubState (new TopNav());
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
