#!/usr/bin/env bash

cd $(dirname $0)

rm -rf mpv.app
cd mpv
./waf clean
cd ..
cd FFmpeg
make clean
cd ..
./clean_homebrew.sh
