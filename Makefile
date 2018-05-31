exec := result/build

default: html

phony: clean rebuild

rebuild:
	@nix build -f release.nix

html: rebuild
	@$(exec) html

pdf: rebuild
	@$(exec) pdf

clean: rebuild
	@$(exec) clean
