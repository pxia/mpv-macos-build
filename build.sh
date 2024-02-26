#!/usr/bin/env bash
set -e

cd $(dirname $0)
BASE=$(pwd)

PATH=$BASE/homebrew/bin:$PATH

# install dependencies other than ffmpeg by homebrew
export HOMEBREW_NO_AUTO_UPDATE=1
BREW=$BASE/homebrew/bin/brew
$BREW install ninja
$BREW install jpeg libarchive libass little-cms2 luajit-openresty mujs \
	uchardet vapoursynth yt-dlp gnutls libvpx x264 x265 dav1d libplacebo

export PKG_CONFIG_PATH="$BASE/homebrew/lib/pkgconfig:$PKG_CONFIG_PATH"
export PKG_CONFIG_PATH="$BASE/homebrew/opt/luajit-openresty/lib/pkgconfig:$PKG_CONFIG_PATH"
export PKG_CONFIG_PATH="$BASE/homebrew/opt/libarchive/lib/pkgconfig:$PKG_CONFIG_PATH"
export PKG_CONFIG_PATH="$BASE/homebrew/opt/gnutls/lib/pkgconfig:$PKG_CONFIG_PATH"

# ffmpeg
cd FFmpeg
./configure \
	--prefix=$BASE/homebrew/ \
	--enable-{gpl,nonfree,libass,libfreetype,gnutls} \
	--enable-{libvpx,libx264,libx265,libdav1d} \
	--enable-hwaccel={h263,h264,hevc,mpeg1,mpeg2,mpeg4,vp9,prores}_videotoolbox
make -j 8
make install
cd ..

# mpv
cd mpv
meson setup --wipe --prefix=$BASE/homebrew/ build || meson setup --prefix=$BASE/homebrew/ build
meson configure -Doptimization=2 -Djavascript=enabled -Duchardet=enabled -Dlua=luajit -Dlibarchive=auto build
meson compile -C build
TOOLS/osxbundle.py -s build/mpv

cd ..
cp -Rf mpv/build/mpv.app ./ 
rm -rf mpv/build/mpv.app


