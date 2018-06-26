{ pkgs ? import <nixpkgs> {} }:

with pkgs;
let
ghc = haskellPackages.ghcWithPackages (p: with p; [shake]);
scriptfile = ./build/Build.hs;
in
runCommand "asciidoc-runner" { buildInputs = [ asciidoctor pythonPackages.pygments ghc ]; } "echo use nix-shell"
