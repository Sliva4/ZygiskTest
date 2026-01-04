all: run
github-actions: build copy
build:
	@cargo build --target=aarch64-linux-android --release && cp target/aarch64-linux-android/release/zh .
run: build
	@./zh
clean:
	@rm -f module.prop
	@rm -f zh
	@rm -f config.toml
full-clean: clean
	@cargo clean --quiet
release-build:
	@cargo build --release && cp target/release/zh .
release-run:
	@cargo run --release
debug-build:
	@cargo build && cp target/debug/zh .
debug-run:
	@cargo run