#!/bin/bash

echo "building native library ..."
(cd native; make -f Makefile.osx)

echo "testing hl ..."
haxe build-hl.hxml \
&& (cd bin/hl; DYLD_LIBRARY_PATH=../../native hl test.hl)