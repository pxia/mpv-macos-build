#!/usr/bin/env bash
set -e

cd $(dirname $0)
BASE=$(pwd)

if [ ! -d "$BASE/homebrew/.git" ]; then
    echo "Error: homebrew/ is not a git repository" >&2
    exit 1
fi

git -C "$BASE/homebrew" rev-parse HEAD > "$BASE/HOMEBREW_COMMIT"
echo "Updated HOMEBREW_COMMIT to $(cat "$BASE/HOMEBREW_COMMIT")"
