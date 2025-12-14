all: build-zygisk zip-all
build-zygisk:
	@cd module && ndk-build && cd ..
zip-all:
	@mv module/libs/arm64-v8a/libZygiskHide.so module/template/zygisk/arm64-v8a.so
	@mv module/libs/armeabi-v7a/libZygiskHide.so module/template/zygisk/armeabi-v7a.so
	@cd module/template && zip -r9 ZygiskHide.zip module.prop zygisk/arm64-v8a.so zygisk/armeabi-v7a.so && mv ZygiskHide.zip .. && cd .. && cd ..
clean:
	@rm -rf module/libs
	@rm -rf module/template/zygisk/arm64-v8a.so
	@rm -rf module/template/zygisk/armeabi-v7a.so
	@rm module/ZygiskHide.zip
