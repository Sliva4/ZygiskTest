all: run
github-actions: build copy
build:
	@cargo build --target=aarch64-linux-android --release && cp target/aarch64-linux-android/release/monitor .
run: build
	@./monitor
clean:
	@rm -f module.prop
	@rm -f monitor
full-clean: clean
	@cargo clean --quiet
debug:
	@cargo run --release