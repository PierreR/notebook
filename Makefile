exec := result/build

default: html

phony: clean rebuild

rebuild:
	nix build -f release.nix

$(exec):
	rebuild

html: $(exec)
	@$(exec) html

pdf:
	@$(exec) pdf

clean:
	@$(exec) clean
