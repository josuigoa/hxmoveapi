package psmoveapi;

import ammer.Library;
import haxe.io.Bytes;
import ammer.ffi.*;

class PsMoveApi extends Library<"hxmoveapi"> {
	
	@:ammer.native("psmove_init")
	public static function init(v:UInt):Bool;
	
	@:ammer.native("psmove_count_connected")
	public static function countConnected():UInt;
	
	@:ammer.native("psmove_connect_by_id")
	public static function connectById(index:UInt):PsMove;
	
	// I put this here because it seems that ammer ignores the
	// ammer.Pointer classes that are not referenced here.
	// Comment these lines and compiler will fail.
	@:ammer.native("create_axis")
	static function create_axis(x:Int, y:Int, z:Int):AxisData;
	
}

class PsMove extends ammer.Pointer<"PSMove", PsMoveApi> {
	
	@:ammer.native("psmove_get_serial")
	public function getSerial(_:ammer.ffi.This):String;
	
	@:ammer.native("psmove_poll")
	public function poll(_:ammer.ffi.This):UInt;
	
	@:ammer.native("psmove_set_leds")
	public function setLeds(_:ammer.ffi.This, r:UInt, g:UInt, b:UInt):Void;
	
	@:ammer.native("psmove_set_rumble")
	public function setRumble(_:ammer.ffi.This, rumble:UInt):Void;
	
	@:ammer.native("psmove_update_leds")
	public function updateLeds(_:ammer.ffi.This):PSMoveUpdateResult;
	
	@:ammer.native("psmove_get_buttons")
	public function getButtons(_:ammer.ffi.This):UInt;
	
	@:ammer.native("get_accelerometer")
    public function getAccelerometer(_:ammer.ffi.This):AxisData;
	
	@:ammer.native("get_gyroscope")
    public function getGyroscope(_:ammer.ffi.This):AxisData;
	
	@:ammer.native("get_magnetometer")
    public function getMagnetometer(_:ammer.ffi.This):AxisData;
	
	@:ammer.native("free_psmove")
    public function free(_:ammer.ffi.This):Void;
}

class AxisData extends ammer.Pointer<"axis_data", PsMoveApi> {
	
	@:ammer.native("axis_get_x")
	public function getX(_:ammer.ffi.This):Int;
	
	@:ammer.native("axis_get_y")
	public function getY(_:ammer.ffi.This):Int;
	
	@:ammer.native("axis_get_z")
	public function getZ(_:ammer.ffi.This):Int;
}

enum abstract PsMoveButton(UInt) to UInt {
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

enum abstract PSMoveUpdateResult(UInt) from UInt {
	var UpdateFailed = 0; /*!< Could not update LEDs */
    var UpdateSuccess; /*!< LEDs successfully updated */
    var UpdateIgnored; /*!< LEDs don't need updating, see psmove_set_rate_limiting() */
}