package;

import psmoveapi.PsMoveApi;

class Player {
    
    public var move:PsMove;
    public var red:UInt;
    public var green:UInt;
    public var blue:UInt;
    public var isOn:Bool = false;
    
    public function new(move, red, green, blue) {
        this.move = move;
        this.red = red;
        this.green = green;
        this.blue = blue;
    }
    
    public function on() {
        onWithColor(red, green, blue);
    }
    
    public function onWithColor(r:UInt, g:UInt, b:UInt) {
        move.set_leds(r, g, b);
        move.update_leds();
        isOn = true;
    }
    
    public function off() {
        move.set_leds(0, 0, 0);
        move.update_leds();
        isOn = false;
    }
    
    public function update() {
        
        if (move.poll() == 0)
            return false;
        
        var btn = move.get_buttons();
        
        if (btn != 0) {
            if (btn & PsMoveButton.MOVE > 0 && !isOn)
                on();
            else if (isOn)
                off();
        }
        
        return isOn;
    }
}