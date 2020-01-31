@echo off

echo "building native library ..."
cd native
nmake /f Makefile.win
cd ..

echo "testing hl ..."
haxe build-hl-win.hxml
if errorrlevel 0 (
    cd bin
    cp ../native/lib/hxmoveapi.dll .
    hl hxmoveapi.hl
    cd ..
)