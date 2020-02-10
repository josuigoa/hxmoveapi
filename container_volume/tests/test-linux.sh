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
&& cp native/lib/linux/libpsmoveapi.so /usr/lib \
&& cp native/lib/linux/libpsmoveapi_tracker.so /usr/lib \
&& mv native/lib/libhxmoveapi.so /usr/lib \
&& mv bin/ammer_hxmoveapi.hdll /usr/lib \
&& hl bin/hxmoveapi.hl