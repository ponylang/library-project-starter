build/{PACKAGE}: build {PACKAGE}/*.pony
	ponyc {PACKAGE} -o build --debug

build:
	mkdir build

test: build/{PACKAGE}
	build/{PACKAGE}

clean:
	rm -rf build

.PHONY: clean test
