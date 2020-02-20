package psmoveapi;

import ammer.Library;
import haxe.io.Bytes;
import ammer.ffi.*;

@:ammer.nativePrefix("psmove_")
class PsMoveApi extends Library<"psmoveapi"> {
	
	@:ammer.native("PSMOVEAPI_VERSION_MAJOR") public static var VERSION_MAJOR:Int;
	@:ammer.native("PSMOVEAPI_VERSION_MINOR") public static var VERSION_MINOR:Int;
	@:ammer.native("PSMOVEAPI_VERSION_PATCH") public static var VERSION_PATCH:Int;
	
	public static function init(v:UInt):Bool;
	
	public static function count_connected():UInt;
	
	@:ammer.native("psmove_connect_by_id")
	public static function connect_by_id(index:UInt):PsMove;
	
	// I put this here because it seems that ammer ignores the
	// ammer.Pointer classes that are not referenced here.
	// If these lines are commented compiling fails.
	@:ammer.c.return("malloc(sizeof(PSMove_3AxisVector))")
	static function create_axis(x:Int, y:Int, z:Int):AxisVector;
	
}

@:ammer.nativePrefix("psmove_")
class PsMove extends ammer.Pointer<"PSMove", PsMoveApi> {
	
	@:ammer.c.return("arg_0 == NULL")
	public function isNull(_:ammer.ffi.This):Bool;
	
	public function get_serial(_:ammer.ffi.This):String;
	
	public function poll(_:ammer.ffi.This):UInt;
	
	public function set_leds(_:ammer.ffi.This, r:UInt, g:UInt, b:UInt):Void;
	
	public function set_rumble(_:ammer.ffi.This, rumble:UInt):Void;
	
	public function update_leds(_:ammer.ffi.This):PSMoveUpdateResult;
	
	public function get_buttons(_:ammer.ffi.This):UInt;
	
	public function get_trigger(_:ammer.ffi.This):UInt;
	
	public function enable_orientation(_:ammer.ffi.This, enable:Bool):Void;
	
	public function has_orientation(_:ammer.ffi.This):Bool;
	
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
    public function get_sensor(_:ammer.ffi.This, sensor:PsMoveSensor):AxisVector;
	
	@:ammer.c.prereturn("
		float x, y, z;
		if (arg_1 == 0) {
			psmove_get_accelerometer_frame(arg_0, arg_2, &x, &y, &z);
		} else if (arg_1 == 1) {
			psmove_get_gyroscope_frame(arg_0, arg_2, &x, &y, &z);
		}
		
		PSMove_3AxisVector * axis = malloc(sizeof(PSMove_3AxisVector));
		axis->x = x;
		axis->y = y;
		axis->z = z;")
	@:ammer.c.return("axis")
    public function get_sensor_frame(_:ammer.ffi.This, sensor:PsMoveSensor, frame:PSMoveFrame):AxisVector;
	
	@:ammer.c.prereturn("
		float x, y, z, w;
		psmove_get_orientation(arg_0, &w, &x, &y, &z);
		
		float arr[] = {x, y, z, w};
		char *result;
		memcpy(result, arr, 100);")
	@:ammer.c.return("result")
    public function get_orientation(_:ammer.ffi.This):Quat;
	
    public function get_transformed_magnetometer_direction(_:ammer.ffi.This, outAxis:AxisVector):Void;
	
    public function get_transformed_accelerometer_frame_3axisvector(_:ammer.ffi.This, frame:PSMoveFrame, outAxis:AxisVector):Void;
    
	public function get_transformed_accelerometer_frame_direction(_:ammer.ffi.This, frame:PSMoveFrame, outAxis:AxisVector):Void;
	
    public function get_transformed_gyroscope_frame_3axisvector(_:ammer.ffi.This, frame:PSMoveFrame, outAxis:AxisVector):Void;
	
	public function disconnect(_:ammer.ffi.This):Void;
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

enum abstract PsMoveSensor(UInt) to UInt from UInt {
	var Accelerometer = 0;
	var Gyroscope;
	var Magnetometer;
}

enum abstract PSMoveFrame(UInt) to UInt from UInt {
	var Frame_FirstHalf = 0; /*!< The older frame */
	var Frame_SecondHalf; /*!< The most recent frame */
}

@:forward
abstract Quat(Array<Float>) from Array<Float> {
	
	@:from static inline public function fromCString(s:ammer.conv.CString):Quat
		return Quat.fromString(s);
		
	@:from static inline public function fromString(s:String):Quat
		return [for (f in s.split(',')) Std.parseFloat(f)];
}