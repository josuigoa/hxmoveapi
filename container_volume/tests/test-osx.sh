#!/bin/bash

echo "testing hl ..."
haxe hl-osx.hxml \
&& rm native/lib/osx/ammer_psmoveapi.hl.c \
&& rm native/lib/osx/ammer_psmoveapi.hl.o \
&& rm native/lib/osx/Makefile.hl.ammer \
&& DYLD_LIBRARY_PATH=native/lib/osx hl bin/game.hl