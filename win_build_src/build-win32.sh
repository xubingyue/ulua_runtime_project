#!/bin/bash
#
# Windows 32-bit/64-bit

# Copyright (C) polynation games ltd - All Rights Reserved
# Unauthorized copying of this file, via any medium is strictly prohibited
# Proprietary and confidential
# Written by Christopher Redden, December 2013

# 32 Bit Version
mkdir -p window/x86

cd luajit
mingw32-make clean

mingw32-make BUILDMODE=static CC="gcc -m32"
cp src/libluajit.a ../window/x86/libluajit.a

# cd ../pbc/
# make clean
# make BUILDMODE=static CC="gcc -m32"
# cp build/libpbc.a ../window/x86/libpbc.a

# cd ../cjson/
# make clean
# make BUILDMODE=static CC="gcc -m32"
# cp build/libcjson.a ../window/x86/libcjson.a

cd ..

gcc lua_wrap.c \
	../struct-0.2/struct.c \
	lpeg.c \
	luasocket/src/luasocket.c \
	luasocket/src/timeout.c \
	luasocket/src/buffer.c \
	luasocket/src/io.c \
	luasocket/src/auxiliar.c \
	luasocket/src/options.c \
	luasocket/src/inet.c \
	luasocket/src/tcp.c \
	luasocket/src/udp.c \
	luasocket/src/except.c \
	luasocket/src/select.c \
	luasocket/src/wsocket.c \
	-o Plugins/x86/ulua.dll -m32 -shared \
	-I./ \
	-Iluajit/src \
	-Iluasocket/src \
	-I../struct-0.2 \
	-Wl,--whole-archive \
	window/x86/libluajit.a \
	-O3 -Wl,--no-whole-archive -lwsock32 -static-libgcc -static-libstdc++
