#!/bin/sh
echo -ne '\033c\033]0;Orbits\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/orbits_linux.x86_64" "$@"
