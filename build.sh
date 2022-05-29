#!/usr/bin/env bash
set -e

cd $(dirname $0)
BASE=$(pwd)

# install dependencies other than ffmpeg by homebrew
export HOMEBREW_NO_AUTO_UPDATE=1
BREW=$BASE/homebrew/bin/brew
$BREW install jpeg libarchive libass little-cms2 luajit-openresty mujs \
	uchardet vapoursynth yt-dlp gnutls

# ffmpeg
cd FFmpeg
./configure \
	--prefix=$BASE/homebrew/ \
	--enable-{gpl,nonfree,libass,libvpx,libx264,libx265,libfreetype,gnutls} \
	--enable-hwaccel={h263,h264,hevc,mpeg1,mpeg2,mpeg4,vp9,prores}_videotoolbox
make -j 8
make install
cd ..

# mpv
cd mpv
ls waf > /dev/null || ./bootstrap.py
export PKG_CONFIG_PATH="$BASE/homebrew/lib/pkgconfig:$PKG_CONFIG_PATH"
export PKG_CONFIG_PATH="$BASE/homebrew/opt/luajit-openresty/lib/pkgconfig:$PKG_CONFIG_PATH"
export PKG_CONFIG_PATH="$BASE/homebrew/opt/libarchive/lib/pkgconfig:$PKG_CONFIG_PATH"
export PKG_CONFIG_PATH="$BASE/homebrew/opt/gnutls/lib/pkgconfig:$PKG_CONFIG_PATH"
export LV_ALL="C" 
PKG_CONFIG_PATH=$PKG_CONFIG_PATH ./waf configure \
	--prefix=$BASE/homebrew/ \
	--enable-{libmpv-shared,lua,libarchive,uchardet,javascript} \
	--lua=luajit
./waf
TOOLS/osxbundle.py -s build/mpv
cd ..
cp -Rf mpv/build/mpv.app ./
