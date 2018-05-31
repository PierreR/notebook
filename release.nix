with import <nixpkgs> {};

let
ghc = haskellPackages.ghcWithPackages (p: with p; [shake]);
scriptFile = ./build/Build.hs;
in
stdenv.mkDerivation {
  name = "asciidoc-runner";
  buildInputs = [ asciidoctor pythonPackages.pygments ghc ];
  unpackPhase = "true";
  installPhase = ''
    mkdir -p $out
    ${ghc}/bin/ghc --make ${scriptFile} -rtsopts -with-rtsopts=-I0  -o $out/build
  '';
}
