package psmoveapi;

import ammer.Library;
import haxe.io.Bytes;
import ammer.ffi.*;

class PsMoveApi extends Library<"psmoveapi"> {
	
	@:ammer.native("PSMOVEAPI_VERSION_MAJOR") public static var VERSION_MAJOR:Int;
	@:ammer.native("PSMOVEAPI_VERSION_MINOR") public static var VERSION_MINOR:Int;
	@:ammer.native("PSMOVEAPI_VERSION_PATCH") public static var VERSION_PATCH:Int;
	
	@:ammer.native("psmove_init")
	public static function init(v:UInt):Bool;
	
	@:ammer.native("psmove_count_connected")
	public static function countConnected():UInt;
	
	@:ammer.native("psmove_connect_by_id")
	public static function connectById(index:UInt):PsMove;
	
	// I put this here because it seems that ammer ignores the
	// ammer.Pointer classes that are not referenced here.
	// If these lines are commented compiling fails.
	@:ammer.c.return("malloc(sizeof(PSMove_3AxisVector))")
	static function create_axis(x:Int, y:Int, z:Int):AxisVector;
	
}

class PsMove extends ammer.Pointer<"PSMove", PsMoveApi> {
	
	@:ammer.c.return("arg_0 == NULL")
	public function isNull(_:ammer.ffi.This):Bool;
	
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
	
	@:ammer.c.prereturn("
		int x, y, z;
		if (arg_1 == 0) {
			psmove_get_accelerometer(arg_0, &x, &y, &z);
		} else if (arg_1 == 1) {
			psmove_get_gyroscope(arg_0, &x, &y, &z);
		} else {
			psmove_get_magnetometer(arg_0, &x, &y, &z);
		}
		
		PSMove_3AxisVector * axis = malloc(sizeof(PSMove_3AxisVector));
		axis->x = x;
		axis->y = y;
		axis->z = z;")
	@:ammer.c.return("axis")
    public function getSensor(_:ammer.ffi.This, sensor:UInt):AxisVector;
	
	@:ammer.c.prereturn("free(arg_0);")
	@:ammer.c.return("true")
	public function free(_:ammer.ffi.This):Bool;
}

class AxisVector extends ammer.Pointer<"PSMove_3AxisVector", PsMoveApi> {
	
	@:ammer.c.return("arg_0->x")
	public function getX(_:ammer.ffi.This):Int;
	
	@:ammer.c.return("arg_0->y")
	public function getY(_:ammer.ffi.This):Int;
	
	@:ammer.c.return("arg_0->z")
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

enum abstract PsMoveSensor(UInt) to UInt {
	var Accelerometer = 0;
	var Gyroscope;
	var Magnetometer;
}