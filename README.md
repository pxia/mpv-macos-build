# mpv-macos-build

## Usage

Init submodules before building:
```
git submodule update --init --recursive
git pull --recurse-submodules --jobs=3
```

- `build.sh` generates an app bundle `mpv.app`.
- `clean_homebrew.sh` uninstalls all homebrew packages our own homebrew directory.
- `clean_all.sh` removes all build artifacts.

## How it works

It creates a self contained Homebrew directory for all the dependencies other then `ffmpeg`.

Tested on MacOS 12.3.1 (Apple Silicon)

