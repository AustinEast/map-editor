package menu;

import flixel.FlxG;
import flixel.text.FlxText;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
using flixel.util.FlxSpriteUtil;

class Button extends MenuItem
{
    public var text:FlxText;
    
    var tween:FlxTween;

    public function new (_x:Float, _y:Float = 0, _name:String, _sizeOffset:Float = 0)
    {
        super(_x, _y, _name, FlxPoint.get(FlxG.width, 16));

        size.x = _sizeOffset;

        on_hover = function () {
            //FlxG.sound.play("option");
            text.color = FlxColor.RED;
        }

        on_exit = function () {
            text.color = FlxColor.WHITE;
        }

        show = function (?_transitionTime:Float = 0) {
            text.exists = true;
            text.scale.set(0,0);
            FlxTween.tween(text.scale, { x: 1, y: 1 }, _transitionTime);
        }

        hide = function (?_transitionTime:Float = 0) {
            FlxTween.tween(text.scale, { x: 0, y: 0}, _transitionTime, {onComplete: function(tween:FlxTween) { text.exists = false; }});
        }

        text = new FlxText(0, 0, 0, _name);
        //text.setFormat("Instant", 16, FlxColor.WHITE, FlxTextAlign.CENTER,FlxTextBorderStyle.OUTLINE, Reg.colors[4]);
        //text.scale.set(0, 0);
	    add(text);
    }
}