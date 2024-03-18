VERSION := $$(make -s show-version)
CURRENT_REVISION := $(shell git rev-parse --short HEAD)
BUILD_LDFLAGS := "-s -w -X main.revision=$(CURRENT_REVISION)"
GOBIN ?= $(shell go env GOPATH)/bin

.PHONY: show-version
show-version: $(GOBIN)/gobump
	@gobump show -r cmd/sqlc-gen-py

$(GOBIN)/gobump:
	@go install github.com/x-motemen/gobump/cmd/gobump@latest

.PHONY: compile
compile:
	sqlc compile

.PHONY: generate
generate: sqlc.yaml
	sqlc generate


.PHONY: release
release: dist/sqlc-gen-py.wasm dist/sqlc-gen-py.wasm.sha256
	gh release create "v${VERSION}" dist/sqlc-gen-py.wasm dist/sqlc-gen-py.wasm.sha256

.PHONY: release
release-overwrite: dist/sqlc-gen-py.wasm dist/sqlc-gen-py.wasm.sha256
	gh release delete -y --cleanup-tag "v${VERSION}"
	gh release create "v${VERSION}" dist/sqlc-gen-py.wasm dist/sqlc-gen-py.wasm.sha256

.PHONY: clean
clean:
	rm -rf ./_examples/gen

sqlc.yaml: dist/sqlc-gen-py.wasm.sha256 _sqlc.yaml
	cat _sqlc.yaml | WASM_SHA256=$$(cat $<) envsubst > $@

dist/sqlc-gen-py.wasm.sha256: dist/sqlc-gen-py.wasm
	openssl sha256 $< | awk '{print $$2}' > $@

dist/sqlc-gen-py.wasm: internal/*
	GOOS=wasip1 GOARCH=wasm go build -o $@ ./cmd/sqlc-gen-py/main.go
