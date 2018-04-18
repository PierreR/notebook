#! /usr/bin/env nix-shell
#! nix-shell --pure
#! nix-shell -p asciidoctor -p pythonPackages.pygments
#! nix-shell -p "haskellPackages.ghcWithPackages(p: with p; [shake])"
#! nix-shell -i bash
mkdir -p build/_shake
ghc --make build/Build.hs -rtsopts -with-rtsopts=-I0 -outputdir=build/_shake -o build/_shake/build && build/_shake/build "$@"
