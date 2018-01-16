package util;

import haxe.Json;
import haxe.io.Path;
import flixel.math.FlxPoint;

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

    public static var current_level:Level;
    public static var current_path:String;

    public static function init ():Void {
        if (!FileSystem.exists(FileSystem.absolutePath(Reg.levels_path))) {
            FileSystem.createDirectory(FileSystem.absolutePath(Reg.levels_path));
        }
    }

    public static function newLevel () {
        
    }

    public static function loadLevel ():Void {
        _showFileDialog();
    }

    public static function saveLevel (level:Level):Void {
        
    }

    // TODO: list level by name defined in map
    public static function listLevels ():Array<String> {
        return FileSystem.readDirectory(FileSystem.absolutePath(Reg.levels_path));
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

    private static function _setLevel(json:String):Void {
        current_path = json;
        current_level = Json.parse(File.getContent(json));
    }
}