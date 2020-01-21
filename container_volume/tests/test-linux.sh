#!/bin/bash

echo "building native library ..."
(cd native; make -f Makefile.linux)

echo "testing hl ..."
haxe build-hl.hxml \
&& rm native/lib/hxmoveapi.o \
&& rm native/lib/ammer_hxmoveapi.hl.c \
&& rm native/lib/ammer_hxmoveapi.hl.o \
&& rm native/lib/ammer_hxmoveapi.hdll \
&& rm native/lib/Makefile.hl.ammer \
&& cp native/lib/linux/libpsmoveapi.so /usr/lib \
&& cp native/lib/linux/libpsmoveapi_tracker.so /usr/lib \
&& mv native/lib/libhxmoveapi.so /usr/lib \
&& mv bin/ammer_hxmoveapi.hdll /usr/lib \
&& hl bin/hxmoveapi.hl

# echo "testing cpp ..."
# haxe build-cpp.hxml \
# && (cd bin/cpp; LD_LIBRARY_PATH=../../native ./Main)

# echo "testing eval ..."
# LD_LIBRARY_PATH=native haxe -D "ammer.eval.hxDir=$TEST_HXDIR" build-eval.hxml