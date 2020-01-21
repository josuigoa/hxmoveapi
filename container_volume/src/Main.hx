class Main {
    
    static public function main() {
        var hasi = psmoveapi.PsMoveApi.init();
        trace('hasi $hasi');
        
        var serial = psmoveapi.PsMoveApi.getSerial();
        trace('serial $serial');
    }
}