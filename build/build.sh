#! /usr/bin/env nix-shell
#! nix-shell -i bash -p '(import <nixpkgs> {}).haskellPackages.ghcWithPackages (p: with p; [shake])'
mkdir -p build/_shake
ghc --make build/Build.hs -rtsopts -with-rtsopts=-I0 -outputdir=build/_shake -o build/_shake/build && build/_shake/build "$@"
