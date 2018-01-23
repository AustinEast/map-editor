package util;

import haxe.Json;
import haxe.io.Path;
import flixel.FlxG;
import flixel.math.FlxPoint;

import zerolib.math.ZArrayUtils;

#if flash
import flash.display.Loader;
import flash.display.LoaderInfo;
import flash.net.FileReference;
import flash.net.FileFilter;
#elseif (cpp || neko)
import systools.Dialogs;
#end

#if sys
	import sys.FileSystem;
	import sys.io.File;
	import sys.io.FileInput;
	import sys.io.FileOutput;
#end

typedef Level = {
    var name:String;
    var collision:Layer;
    var fg:Array<Layer>;
    var bg:Array<Layer>;
    var widthInTiles:Int;
    var heightInTiles:Int;
    var tileWidth:Int;
    var tileHeight:Int;
}

typedef Layer = {
    var name:String;
    var data:Array<Int>;
    var tileSet:String;
    var scrollFactor:FlxPoint;
}

class FileUtil {

    public static var current_level:Level;
    public static var levels_dir:String = "assets/levels";

    public static function init ():Void {
        if (!FileSystem.exists(FileSystem.absolutePath(levels_dir))) {
            FileSystem.createDirectory(FileSystem.absolutePath(levels_dir));
        }
    }

    public static function newLevel (name:String, widthInTiles:Int, heightInTiles:Int, tileWidth:Int, tileHeight:Int):Level {

        var collisionLayer:Layer = {
            "name": "Collision",
            "data": ZArrayUtils.make_1D_array(widthInTiles, heightInTiles),
            "tileSet": "",
            "scrollFactor": FlxPoint.get()
        }

        var level:Level = {
            "name": name,
            "collision": collisionLayer,
            "fg": [],
            "bg": [],
            "widthInTiles": widthInTiles,
            "heightInTiles": heightInTiles,
            "tileWidth": tileWidth,
            "tileHeight": tileHeight
        }

        return _setLevel(level);
    }

    public static function loadLevel (native:Bool = true):Void {
        var filters: FILEFILTERS =
        {
            count: 1,
            descriptions: ["JSON files"],
            extensions: ["*.json"]
        };
        var result:Array<String> = Dialogs.openFile(
            "Load Level",
            "Please select a level JSON from your assets/levels directory",
            filters
        );

        _onSelect(result);
    }

    public static function saveCurrentLevel():Void {
        current_level == null ? FlxG.log.error("No Current Level Selected") : saveLevel(current_level);
    }

    public static function saveLevel (level:Level):Void {

        var filters: FILEFILTERS =
        {
            count: 1,
            descriptions: ["JSON files"],
            extensions: ["*.json"]
        };

        var result = Dialogs.saveFile(
            "Save Level",
            "Name and Save Your Level",
            "/~",
            filters
        );

        FlxG.log.notice("Saving " + level.name + " to " + result);
        File.saveContent(result, _stringifyLevel(level));
        
        // Perhaps use for non-debug builds?
        //File.saveContent(Path.join([FileSystem.absolutePath(levels_dir), level.name + ".json"]), Json.stringify(level, null, "    "));
    }
    
    // TODO: implement relative bool
    public static function listDir (path:String, ?relative:Bool):Array<String> {
        return FileSystem.readDirectory(path);
    }

    // TODO: list level by name defined in map
    public static function listLevels ():Array<String> {
        return listDir(FileSystem.absolutePath(levels_dir));
    }

    private static function _onSelect(arr:Array<String>):Void
	{
		if (arr != null && arr.length > 0)
		{
            _setLevel(_parseLevel(arr[0]));
		}
	}

    private static function _parseLevel(json:String):Level {
        return Json.parse(File.getContent(json));
    }

    private static function _stringifyLevel(level:Level):String {
        return Json.stringify(level, null, "    ");
    }

    private static function _setLevel(level:Level):Level {
        current_level = level;
        return current_level;
    }
}