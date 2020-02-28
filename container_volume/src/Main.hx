import psmoveapi.PsMoveApi;

class Main {
    
    static var move:PsMove;
    
    static public function main() {
        
        var currentVersion = PsMoveApi.VERSION_MAJOR << 16 |
                            PsMoveApi.VERSION_MINOR << 8 |
                            PsMoveApi.VERSION_PATCH << 0;
        var inited = PsMoveApi.init(currentVersion);
        trace('inited: $inited');
        if (!inited) {
            trace('PS Move API init failed (wrong version?)');
            return;
        }
        
        var connectedCount = PsMoveApi.count_connected();
        trace('connectedCount: $connectedCount');
        
        move = PsMoveApi.connect_by_id(0);
        trace('connected: $move');
        if (move.isNull())
            return;
        
        var serial = move.get_serial();
        trace('serial $serial');
        
        move.set_rumble(100);
        haxe.Timer.delay(() -> {
            move.set_rumble(0);
            move.update_leds();
        }, 1000);
        
        move.set_leds(0, 255, 0);
        haxe.Timer.delay(() -> {
            move.set_leds(0, 0, 0);
            move.update_leds();
        }, 3000);
        
        move.update_leds();
        
        haxe.MainLoop.add(update);
    }
    
    static function update() {
        
        if (move.poll() == 0)
            return;
        
        var btn = move.get_buttons();
        
        if (btn != 0) {
            
            var r = 0;
            var g = 0;
            var b = 0;
            if (btn & PsMoveButton.TRIANGLE > 0)
                g = 255;
            if (btn & PsMoveButton.CIRCLE > 0)
                r = 255;
            if (btn & PsMoveButton.CROSS > 0)
                b = 255;
            if (btn & PsMoveButton.SQUARE > 0) {
                r = 255;
                g = 192;
                b = 203;
            }
            if (btn & PsMoveButton.T > 0) {
                r = b = move.get_trigger();
                move.set_rumble(r);
                haxe.Timer.delay(() -> {
                    move.set_rumble(0);
                    move.set_leds(0, 0, 0);
                    move.update_leds();
                }, 3000);
            }

            move.set_leds(r, g, b);
            
            move.update_leds();
            
            if (btn & PsMoveButton.MOVE > 0) {
                var axis = move.get_sensor(Accelerometer);
                trace('accel: [${axis.getX()}, ${axis.getY()}, ${axis.getZ()}]');
                
                axis = move.get_sensor(Gyroscope);
                trace('gyro: [${axis.getX()}, ${axis.getY()}, ${axis.getZ()}]');
                
                axis = move.get_sensor(Magnetometer);
                trace('magneto: [${axis.getX()}, ${axis.getY()}, ${axis.getZ()}]');
            }
        }
    }
}