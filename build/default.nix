with import <nixpkgs> {};

let asciidoctor = bundlerEnv rec {
      name = "asciidoctor-${version}";
      version = "1.5.4";

      ruby = ruby_2_2;
      gemfile = ./Gemfile;
      lockfile = ./Gemfile.lock;
      gemset = ./gemset.nix;

      # Delete dependencies' executables
      postBuild = ''
        find $out/bin -type f -not -wholename '*bin/asciidoctor*' -print0 \
        | xargs -0 rm
      '';
    };
    henv = haskellPackages.ghcWithPackages (p: with p; [shake]);

in
stdenv.mkDerivation {
  name = "notebook-asciidoc-with-pygments.rb";
  buildInputs = [ asciidoctor henv];
}
