build/{PACKAGE}: build {PACKAGE}/*.pony
	ponyc {PACKAGE} -o build

build:
	mkdir build

test: build/{PACKAGE}
	build/{PACKAGE}

clean:
	rm -rf build

.PHONY: clean test
