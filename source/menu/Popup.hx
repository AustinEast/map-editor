package menu;

import flixel.FlxG;
import flixel.text.FlxText;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
using flixel.util.FlxSpriteUtil;

import zerolib.util.ZMenu;

class Popup extends ZMenu
{
    public var text:FlxText;
    
    var tween:FlxTween;

    public function new (_x:Float, _y:Float = 0, _name:String, _sizeOffset:Float = 0)
    {
        super();

        
    }
}