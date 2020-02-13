import psmoveapi.PsMoveApi;

class Main {
    
    static public function main() {
        
        var inited = PsMoveApi.init();
        trace('inited: $inited');
        if (!inited) {
            trace('PS Move API init failed (wrong version?)');
            return;
        }
        
        var connectedCount = PsMoveApi.countConnected();
        trace('connectedCount: $connectedCount');
        
        var connected = PsMoveApi.connectById(0);
        trace('connected: $connected');
        if (!connected)
            return;
        
        var serial = PsMoveApi.getSerial();
        trace('serial $serial');
        
        PsMoveApi.setRumble(100);
        haxe.Timer.delay(() -> PsMoveApi.setRumble(0), 1000);
        
        inline function irand() {
            return Std.int(Math.random() * 255);
        }
        
        PsMoveApi.setLed(0, 255, 0);
        haxe.Timer.delay(() -> PsMoveApi.setLed(0, 0, 0), 3000);
        
        haxe.MainLoop.add(update);
    }
    
    static function update() {
        
        var b = PsMoveApi.getButtons();
        
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
            PsMoveApi.setLed(r, g, b);
            
            if (b & PsMoveButton.MOVE > 0) {
                var axis = PsMoveApi.getAccelerometer();
                trace('accel: [${axis.getX()}, ${axis.getY()}, ${axis.getZ()}]');
                
                axis = PsMoveApi.getGyroscope();
                trace('accel: [${axis.getX()}, ${axis.getY()}, ${axis.getZ()}]');
                
                axis = PsMoveApi.getMagnetometer();
                trace('accel: [${axis.getX()}, ${axis.getY()}, ${axis.getZ()}]');
            }
        }
    }
}