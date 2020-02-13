package psmoveapi;

import ammer.Library;
import haxe.io.Bytes;
import ammer.ffi.*;

enum abstract PsMoveButton(UInt) to UInt{
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
	
	public static function init():Bool;
	
	@:ammer.native("count_connected")
	public static function countConnected():UInt;
	
	@:ammer.native("connect_by_id")
	public static function connectById(index:UInt):Bool;
	
	@:ammer.native("get_serial")
	public static function getSerial():String;
	
	@:ammer.native("set_led")
	public static function setLed(r:UInt, g:UInt, b:UInt):Void;
	
	@:ammer.native("set_rumble")
	public static function setRumble(rumble:UInt):Void;
	
	@:ammer.native("get_buttons")
	public static function getButtons():UInt;
	
	@:ammer.native("get_accelerometer")
    public static function getAccelerometer():AxisData;
	
	@:ammer.native("get_gyroscope")
    public static function getGyroscope():AxisData;
	
	@:ammer.native("get_magnetometer")
    public static function getMagnetometer():AxisData;
}

class AxisData extends ammer.Pointer<"axis_data", PsMoveApi> {
	@:ammer.native("axis_get_x")
	public function getX(_:ammer.ffi.This):Int;
	@:ammer.native("axis_get_y")
	public function getY(_:ammer.ffi.This):Int;
	@:ammer.native("axis_get_z")
	public function getZ(_:ammer.ffi.This):Int;
}