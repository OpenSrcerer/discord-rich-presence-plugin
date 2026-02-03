.PHONY: test build package clean

PLUGIN_NAME := discord-rich-presence
WASM_FILE := plugin.wasm

test:
	go test -race ./...

build:
	tinygo build -opt=2 -scheduler=none -no-debug -o $(WASM_FILE) -target wasi -buildmode=c-shared .

package: build
	zip $(PLUGIN_NAME).ndp $(WASM_FILE) manifest.json

clean:
	rm -f $(WASM_FILE) $(PLUGIN_NAME).ndp
