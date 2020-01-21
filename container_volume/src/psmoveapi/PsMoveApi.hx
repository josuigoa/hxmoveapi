package psmoveapi;

import ammer.Library;
import haxe.io.Bytes;
import ammer.ffi.*;

class PsMoveApi extends Library<"hxmoveapi"> {
	
	@:ammer.native("init")
	public static function init():Bool;
	
	@:ammer.native("get_serial")
	public static function getSerial():String;
	/*
	
	public static function setLed(r:UInt, g:UInt, b:UInt):Void;
	
	public static function setRumble(rumble:UInt):Void;
	
	public static function getButtons():UInt;
	*/
}