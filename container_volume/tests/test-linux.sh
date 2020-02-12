#!/bin/bash

echo "building native library ..."
(cd native; make -f Makefile.linux)

echo "testing hl ..."
haxe build-hl-linux.hxml \
&& rm native/lib/linux/hxmoveapi.o \
&& rm native/lib/linux/ammer_hxmoveapi.hl.c \
&& rm native/lib/linux/ammer_hxmoveapi.hl.o \
&& rm native/lib/linux/ammer_hxmoveapi.hdll \
&& rm native/lib/linux/Makefile.hl.ammer \
&& LD_LIBRARY_PATH=native/lib/osx hl bin/hxmoveapi.hl