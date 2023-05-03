#!/bin/bash

# This script is meant to be run inside Docker

PKG_DIR=/package

echo "Running Docker build script.."

export CARCH=aarch64
export PACKAGER="Foo Bar <foo.bar@archlinux.org>"
export GPGKEY="0x0123456789abcdef"
export MAKEFLAGS="ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-"

sudo chmod 777 ${PKG_DIR}
cd ${PKG_DIR}
makepkg
