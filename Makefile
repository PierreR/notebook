cmd = "mkdir -p out && ghc --make build/Build.hs -rtsopts -with-rtsopts=-I0 -outputdir=out -o out/build && out/build $@"

default: html

phony: clean

html:
	@nix-shell --run $(cmd)

pdf:
	@nix-shell --run $(cmd)

clean:
	@echo "Cleaning ..."
	@nix-shell --run $(cmd)

purge: clean
	@echo "Purging ..."
	@rm -rf out
