all: run
github-actions: build copy
build:
	@cargo build --target=aarch64-linux-android --release && cp target/aarch64-linux-android/release/zh .
run: build
	@./zh
clean:
	@rm -f module.prop
	@rm -f zh
full-clean: clean
	@cargo clean --quiet
debug:
	@cargo run --release