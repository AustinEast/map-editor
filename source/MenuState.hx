package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;

import zerolib.util.ZMenu;


class MenuState extends FlxState
{
	override public function create():Void
	{
		super.create();
		var menu = new ZMenu();
		
		#if !web
		quit = new MenuText(0, 0,"Quit",24);
		quit.callback = function() {
			System.exit(0);
		}
		menu.add(quit);
		#end

		menu.init();
		menu.arrange_vertically(FlxPoint.get(0, 120), 16, 0);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
