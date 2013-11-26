#!/bin/bash
#
# Cross-compile using mingw on debian 7 and probably ubuntu
#

TARGET=i586-mingw32msvc

function prepare() {
    if test ! -f ./configure; then
        autoreconf -ifv
    fi
}

function install_mingw32() {
    which "$TARGET-gcc" > /dev/null
    if [ $? != 0 ]; then
        sudo apt-get install mingw32 mingw32-binutils mingw32-runtime
    fi
}

function run_configure() {
    ./configure --host=$TARGET --target=$TARGET $@
}

function compile() {
    make
}

install_mingw32
prepare
run_configure
compile