#! /usr/bin/env nix-shell
#! nix-shell -i bash -p entr
cmd='./build/build.sh html'
#cmd='build/build.sh html && build/build.sh pdf'
while true; do ls *.adoc | entr sh -c "$cmd"; done
