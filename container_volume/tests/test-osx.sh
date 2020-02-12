#!/bin/bash

echo "building native library ..."
(cd native; make -f Makefile.osx)

echo "testing hl ..."
haxe build-hl-osx.hxml \
&& rm native/lib/hxmoveapi.o \
&& rm native/lib/osx/ammer_hxmoveapi.hl.c \
&& rm native/lib/osx/ammer_hxmoveapi.hl.o \
&& rm native/lib/osx/ammer_hxmoveapi.hdll \
&& rm native/lib/osx/Makefile.hl.ammer \
&& DYLD_LIBRARY_PATH=native/lib/osx hl bin/hxmoveapi.hl