all: build zip-all
build:
	@cd module && ndk-build && cd ..
zip-all:
	ls && pwd && ls module && ls module/template
	@mv module/libs/arm64-v8a/libZygiskHide.so module/template/zygisk
	@mv module/template/zygisk/libZygiskHide.so module/template/arm64-v8a.so
	@mv module/libs/armeabi-v7a/libZygiskHide.so module/template/zygisk
	@mv module/template/zygisk/libZygiskHide.so module/template/zygisk/armeabi-v7a.so
	@zip -r9 module/ZygiskHide.zip module/template/module.prop module/template/zygisk/arm64-v8a.so template/zygisk/armeabi-v7a.so
clean:
	@rm -rf module/libs
	@rm module/ZygiskHide.zip
