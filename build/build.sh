#! /usr/bin/env nix-shell
#! nix-shell -i bash
mkdir -p build/_shake
ghc --make build/Build.hs -rtsopts -with-rtsopts=-I0 -outputdir=build/_shake -o build/_shake/build && build/_shake/build "$@"

