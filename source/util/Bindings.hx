package util;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.input.keyboard.FlxKey;
import flixel.input.gamepad.FlxGamepadInputID;

import zerolib.managers.ZControlsManager;

/**
 * Class that can be used to assign bindings to up to four Controllers.
 */
class Bindings extends FlxObject
{
	public function new (_controlManager:ZControlsManager) 
    {
        super();
        init(_controlManager);
    }

    function init(_controlManager:ZControlsManager):Void
    {
        if (_controlManager != null) 
        {
            _controlManager.clearControlsArrays();
            
            _controlManager.setKeyControl(Button.A,Controller.ONE,FlxKey.X);
            _controlManager.setKeyControl(Button.B,Controller.ONE,FlxKey.C);
            _controlManager.setKeyControl(Button.UP,Controller.ONE,FlxKey.UP);
            _controlManager.setKeyControl(Button.DOWN,Controller.ONE,FlxKey.DOWN);
            _controlManager.setKeyControl(Button.LEFT,Controller.ONE,FlxKey.LEFT);
            _controlManager.setKeyControl(Button.RIGHT,Controller.ONE,FlxKey.RIGHT);
            _controlManager.setKeyControl(Button.START,Controller.ONE,FlxKey.ENTER);
            _controlManager.setKeyControl(Button.QUIT,Controller.ONE,FlxKey.ESCAPE);
            
            _controlManager.setPadControl(Button.A,Controller.ONE,FlxGamepadInputID.A);
            _controlManager.setPadControl(Button.B,Controller.ONE,FlxGamepadInputID.B);
			_controlManager.setPadControl(Button.UP,Controller.ONE,FlxGamepadInputID.LEFT_STICK_DIGITAL_UP);
			_controlManager.setPadControl(Button.DOWN,Controller.ONE,FlxGamepadInputID.LEFT_STICK_DIGITAL_DOWN);
            _controlManager.setPadControl(Button.LEFT,Controller.ONE,FlxGamepadInputID.LEFT_STICK_DIGITAL_LEFT);
            _controlManager.setPadControl(Button.RIGHT,Controller.ONE,FlxGamepadInputID.LEFT_STICK_DIGITAL_RIGHT);
            _controlManager.setPadControl(Button.START,Controller.ONE,FlxGamepadInputID.START);
        }
    }
}