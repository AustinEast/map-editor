package util;

import haxe.Json;
import haxe.io.Path;
import flixel.math.FlxPoint;

#if sys
	import systools.Dialogs;
	import sys.FileSystem;
	import sys.io.File;
	import sys.io.FileInput;
	import sys.io.FileOutput;
#end

typedef Level = {
    var name:String;
    var layers:Array<Layer>;
    var width:Float;
    var height:Float;
}

typedef Layer = {
    var name:String;
    var data:String;
    var tileset:String;
    var tileWidth:Float;
    var tileHeight:Float;
    var scrollFactor:FlxPoint;
}

class FileUtil {

    public static function init () {
        if (!FileSystem.exists(Reg.levels_path)) {
            FileSystem.createDirectory(Reg.levels_path);
        }
    }

    public static function loadLevel (fileName:String):Level {
        var json = File.getContent(Path.join([Reg.levels_path, fileName, '.json');
        var level:Level = Json.parse(json);
        return level;
    }

    public static function saveLevel (level:Level):Void {
        
    }

    public static function listLevels (dir:String) {
        
    }
}