package util;

import haxe.Json;
import haxe.io.Path;
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
}

typedef Layer = {
    var name:String;
    var data:Array<Int>;
    var tileSet:String;
    var tileWidth:Int;
    var tileHeight:Int;
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
            "tileWidth": tileWidth,
            "tileHeight": tileHeight,
            "scrollFactor": FlxPoint.get()
        }

        var level:Level = {
            "name": name,
            "collision": collisionLayer,
            "fg": [],
            "bg": [],
            "widthInTiles": widthInTiles,
            "heightInTiles": heightInTiles
        }

        return level;
    }

    public static function loadLevelNativeDialog ():Void {
        _showFileDialog();
    }

    public static function saveLevel (level:Level):Void {
        
    }
    
    // TODO: implement relative bool
    public static function listDir (path:String, ?relative:Bool):Array<String> {
        return FileSystem.readDirectory(path);
    }

    // TODO: list level by name defined in map
    public static function listLevels ():Array<String> {
        return listDir(FileSystem.absolutePath(levels_dir));
    }
    
    private static function _showFileDialog():Void
	{
        var filters: FILEFILTERS =
        {
            count: 1,
            descriptions: ["JSON files"],
            extensions: ["*.json"]
        };
        var result:Array<String> = Dialogs.openFile(
            "Select a file please!",
            "Please select one or more files, so we can see if this method works",
            filters
        );

        _onSelect(result);
	}

    private static function _onSelect(arr:Array<String>):Void
	{
		if (arr != null && arr.length > 0)
		{
            _setLevel(arr[0]);
		}
	}

    private static function _setLevel(json:String):Level {
        current_level = Json.parse(File.getContent(json));
        return current_level;
    }
}