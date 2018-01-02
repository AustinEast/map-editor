package;

import flixel.util.FlxSave;
import zerolib.managers.ZControlsManager;


/**
 * Handy, pre-built Registry class that can be used to store 
 * references to objects and other things for quick-access. Feel
 * free to simply ignore it or change it in any way you like.
 */
class Reg
{
	public static var levels_path:String = "levels";

	public static var c:ZControlsManager;

	public static var palletes:Array<Array<Int>> = [
		[
			0xffacbcd7,
			0xff778ea1,
			0xff49637a,
			0xff223d57
		]
	];

	public static var currentPallete:Int = 0;
}
