GO_SRC = ./wc-go/src/wc.go
GO_BIN = ./bin/wc-go
RUST_SRC_DIR = ./wc-rust/
RUST_SRC = ./wc-rust/src/main.rs
RUST_BIN = ./bin/wc-rust

HASKELL_SRC = ./wc-haskell/src/Lib.hs ./wc-haskell/app/Main.hs
HASKELL_BIN = ./bin/wc-haskell

RUBY_SRC = ./wc-ruby/lib/binstub
RUBY_BIN = ./bin/wc-ruby

.PHONY: all
all: go haskell ruby rust

.PHONY: rust
go: $(GO_BIN)

$(GO_BIN): $(GO_SRC)
	go build -o $(GO_BIN) $(GO_SRC)

.PHONY: haskell
haskell: $(HASKELL_BIN)

$(HASKELL_BIN): $(HASKELL_SRC)
	cd wc-haskell && \
		stack build && \
		cp ./`stack path --dist-dir`/build/wc-haskell-exe/wc-haskell-exe ../$(HASKELL_BIN)

.PHONY: rust
rust: $(RUST_BIN)

$(RUST_BIN): $(RUST_SRC)
	cd $(RUST_SRC_DIR) && \
	cargo build --release && \
	cd ../ && \
	cp $(RUST_SRC_DIR)target/release/wc-rust $(RUST_BIN)

.PHONY: ruby
ruby: $(RUBY_BIN)

$(RUBY_BIN): $(RUBY_SRC)
	cp $(RUBY_SRC) $(RUBY_BIN) && chmod +x $(RUBY_BIN)

