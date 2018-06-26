{ pkgs ? import <nixpkgs> {} }:

with pkgs;
let
ghc = haskellPackages.ghcWithPackages (p: with p; [shake]);
in
mkShell {
  name = "asciidoc-env";
  buildInputs = [ asciidoctor pythonPackages.pygments ghc ];
}
