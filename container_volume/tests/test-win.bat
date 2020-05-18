@echo off

echo "testing hl ..."
haxe hl-win.hxml
if errorrlevel 0 (
    cd bin
    cp ../native/lib/win/hxmoveapi.dll .
    hl game.hl
    cd ..
)