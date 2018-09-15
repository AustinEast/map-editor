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
    var layers:Array<Layer>;
    var objects:Array<Object>;
    var widthInTiles:Int;
    var heightInTiles:Int;
    var tileWidth:Int;
    var tileHeight:Int;
}

typedef Layer = {
    var name:String;
    var data:Array<Int>;
    var tileSet:String;
    var autoTile:Bool;
    var scrollFactor:FlxPoint;
}

typedef Object = {
    var className:String;
    var img:String;
    var pos:FlxPoint;
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
            "tileSet": "assets/tiles/colortiles.png",
            "autoTile": false,
            "scrollFactor": FlxPoint.get()
        }

        var level:Level = {
            "name": name,
            "collision": collisionLayer,
            "layers": [],
            "objects": [],
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

        if (result != null && result.length > 0) {
            var level = _parseLevel(result[0]);
            FlxG.log.notice("Loading " + level.name + " from " + result);
            _setLevel(level);
		} else {
            FlxG.log.error("Error loading Level.");
        }
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

    public static function loadTileset ():String {

        var filters: FILEFILTERS =
        {
            count: 1,
            descriptions: ["PNG files"],
            extensions: ["*.png"]
        };
        var result:Array<String> = Dialogs.openFile(
            "Load Tileset",
            "Please select a tileset PNG from your assets/tiles directory",
            filters
        );

        return "";
    }

    private static function _parseLevel(json:String):Level {
        return Json.parse(File.getContent(json));
    }

    private static function _stringifyLevel(level:Level):String {
        return Json.stringify(level, null);
    }

    private static function _setLevel(level:Level):Level {
        current_level = level;
        return current_level;
    }
}