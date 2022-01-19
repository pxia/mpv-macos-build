# mpv-macos-build

Init submodules before building:
```
git pull --recurse-submodules --jobs=10
```

- `build.sh` generates an app bundle `mpv.app`.
- `clean_homebrew.sh` uninstalls all homebrew packages our own homebrew directory.
- `clean_all.sh` removes all build artifacts.

Tested on MacOS 12.1 (Apple Silicon)
