all: run
build:
	export PATH=$PATH:$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/linux-x86_64/bin/
	@cargo build --target=aarch64-linux-android --release
	@cp target/aarch64-linux-android/release/zhd .
run: build
	@./zhd
clean:
	@rm -f zhd
full-clean: clean
	@cargo clean