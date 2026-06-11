#!/bin/bash

BUILD_DIR=$(mktemp -d)

trap "rm -rf $BUILD_DIR" EXIT

cd "$BUILD_DIR"
git clone https://aur.archlinux.org/paru.git 
cd paru

makepkg -si
