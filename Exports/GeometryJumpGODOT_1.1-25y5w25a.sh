#!/bin/sh
echo -ne '\033c\033]0;GeometryJump\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/GeometryJumpGODOT_1.1-25y5w25a.x86_64" "$@"
