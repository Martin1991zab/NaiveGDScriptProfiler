#! /usr/bin/env bash

set -euo pipefail

dir="${1:-$HOME/godot/TelloDroneDemo}"

find $dir -iname '*.gd' | while read line; do
  ./patch.pl $line
done
