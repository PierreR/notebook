with import <nixpkgs> {};

let
ghc = haskellPackages.ghcWithPackages (p: with p; [shake]);
scriptfile = ./build/Build.hs;
in
runCommand "asciidoc-runner" { buildInputs = [ asciidoctor pythonPackages.pygments ghc ]; } ''
  mkdir -p $out
  ghc --make ${scriptfile} -rtsopts -with-rtsopts=-I0 -outputdir=$out -o $out/build && $out/build "$@"
''
