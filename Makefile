phony: clean html

all: html

html:
	build/build.sh html

pdf:
	build/build.sh pdf

clean:
	@rm -rf css
