#!/usr/bin/env bash
set -e

cd $(dirname $0)
BASE=$(pwd)
BREW=$BASE/homebrew/bin/brew

while [[ `$BREW list | wc -l` -ne 0 ]]; do
    $BREW uninstall --force --ignore-dependencies `$BREW list`
done
