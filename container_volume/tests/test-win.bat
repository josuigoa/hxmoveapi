@echo off

echo "testing hl ..."
haxe build-hl-win.hxml
if errorrlevel 0 (
    cd bin
    cp ../native/lib/hxmoveapi.dll .
    hl hxmoveapi.hl
    cd ..
)