# mpv-macos-build

This build is most suited for Apple Silicon Macs. 
It enables the exact set of hardware decoder that apple silicon supports, including `h264`, `h265`, `VP9`, and `ProRes`.
This script can also be modified and used for Intel macs. 

Releases happen whenever there is a `mpv` or `ffmpeg` release.

## Usage

Requires `meson` and `dylibbundler` in your system. Install them with

```
brew install meson dylibbundler
```

Init submodules before building:
```
git submodule update --init --recursive
git pull --recurse-submodules --jobs=3
```

- `build.sh` generates an static app bundle `mpv.app`.
- `clean_homebrew.sh` uninstalls all homebrew packages our own homebrew directory (not your system homebrew).
- `clean_all.sh` removes all build artifacts.

## How it works

It creates a self contained Homebrew directory for all the dependencies other then `ffmpeg`.
It is as hermetic as possible. It tries to use the libraries and tools in our own Homebrew directory. 
However, it does use `clang`, `meson`, `dylibbundler` and some basic tools like `sed` or `tr` from your system.

Tested on MacOS 14.4.1
