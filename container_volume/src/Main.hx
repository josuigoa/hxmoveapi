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
        
        var connectedCount = PsMoveApi.countConnected();
        trace('connectedCount: $connectedCount');
        
        move = PsMoveApi.connectById(0);
        trace('connected: $move');
        if (move.isNull())
            return;
        
        var serial = move.getSerial();
        trace('serial $serial');
        
        move.setRumble(100);
        haxe.Timer.delay(() -> {
            move.setRumble(0);
            move.updateLeds();
        }, 1000);
        
        move.setLeds(0, 255, 0);
        haxe.Timer.delay(() -> {
            move.setLeds(0, 0, 0);
            move.updateLeds();
        }, 3000);
        
        move.updateLeds();
        
        haxe.MainLoop.add(update);
    }
    
    static function update() {
        
        if (move.poll() == 0)
            return;
        
        var b = move.getButtons();
        
        if (b != 0) {
            
            trace('button pressed: $b');
            
            var r = 0;
            var g = 0;
            var b = 0;
            if (b & PsMoveButton.TRIANGLE > 0)
                g = 255;
            if (b & PsMoveButton.CIRCLE > 0)
                r = 255;
            if (b & PsMoveButton.CROSS > 0)
                b = 255;
            if (b & PsMoveButton.SQUARE > 0) {
                r = 255;
                g = 192;
                b = 203;
            }
            move.setLeds(r, g, b);
            
            move.updateLeds();
            
            if (b & PsMoveButton.MOVE > 0) {
                var axis = move.getSensor(Accelerometer);
                trace('accel: [${axis.getX()}, ${axis.getY()}, ${axis.getZ()}]');
                
                axis = move.getSensor(Gyroscope);
                trace('accel: [${axis.getX()}, ${axis.getY()}, ${axis.getZ()}]');
                
                axis = move.getSensor(Magnetometer);
                trace('accel: [${axis.getX()}, ${axis.getY()}, ${axis.getZ()}]');
            }
        }
    }
}