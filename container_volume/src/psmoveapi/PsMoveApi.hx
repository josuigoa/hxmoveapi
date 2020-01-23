package psmoveapi;

import ammer.Library;
import haxe.io.Bytes;
import ammer.ffi.*;

enum abstract PsMoveButton(Int) {
	var TRIANGLE = 1 << 4; /*!< Green triangle */
    var CIRCLE = 1 << 5; /*!< Red circle */
    var CROSS = 1 << 6; /*!< Blue cross */
    var SQUARE = 1 << 7; /*!< Pink square */

    var SELECT = 1 << 8; /*!< Select button, left side */
    var START = 1 << 11; /*!< Start button, right side */

    var PS = 1 << 16; /*!< PS button, front center */
    var MOVE = 1 << 19; /*!< Move button, big front button */
    var T = 1 << 20;
}

class PsMoveApi extends Library<"hxmoveapi"> {
	
	@:ammer.native("init")
	public static function init():Bool;
	
	@:ammer.native("get_serial")
	public static function getSerial():String;
	
	@:ammer.native("set_led")
	public static function setLed(r:UInt, g:UInt, b:UInt):Void;
	
	@:ammer.native("set_rumble")
	public static function setRumble(rumble:UInt):Void;
	
	@:ammer.native("get_buttons")
	public static function getButtons():UInt;
}