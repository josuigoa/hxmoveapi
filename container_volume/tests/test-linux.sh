#!/bin/bash

echo "testing hl ..."
haxe build-hl-linux.hxml \
&& rm native/lib/linux/ammer_psmoveapi.hl.c \
&& rm native/lib/linux/ammer_psmoveapi.hl.o \
&& rm native/lib/linux/Makefile.hl.ammer \
&& LD_LIBRARY_PATH=native/lib/linux hl bin/hxmoveapi.hl