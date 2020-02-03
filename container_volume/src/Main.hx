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
        
        PsMoveApi.setLed(irand(), irand(), irand());
        haxe.Timer.delay(() -> PsMoveApi.setLed(0, 0, 0), 1000);
    }
}